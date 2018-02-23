//
//  LLTreeTableView.m
//  TreeTableView
//
//  Created by luo luo on 23/02/2018.
//  Copyright © 2018 ChangeStrong. All rights reserved.
//

#import "LLTreeTableView.h"
#import "BaseTreeTableCell.h"
#import "BaseNode.h"

NSString  * const TreeCellID = @"TreeCellID";
@interface LLTreeTableView()
//所有数据
@property(nonatomic, strong) NSMutableArray <BaseNode *>*allDatas;
//目前正在展示的临时数据
@property(nonatomic, strong) NSMutableArray <BaseNode *>*tempData;
@end
@implementation LLTreeTableView

-(NSMutableArray <BaseNode *>*)tempData
{
    if (!_tempData) {
        _tempData = [[NSMutableArray alloc]init];
    }
    return _tempData;
}
-(NSMutableArray <BaseNode *>*)allDatas
{
    if (!_allDatas) {
        _allDatas = [NSMutableArray new];
    }
    return _allDatas;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.delegate = self;
    self.dataSource = self;
    return self;
}
//通过storyboad加载进来的情况
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    self.delegate = self;
    self.dataSource = self;
    return self;
}

-(void)setDataArray:(NSArray <BaseNode *> *)dataArray
{
    [self.allDatas setArray:dataArray];
    [self initTempData];
}

-(void)initTempData
{
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i=0; i<self.allDatas.count; i++) {
        BaseNode *node = [self.allDatas objectAtIndex:i];
        if (node.isShowing) {
            [tempArray addObject:node];
        }
    }
    [self.tempData setArray:tempArray];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tempData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BaseNode *node = [self.tempData objectAtIndex:indexPath.row];
    BaseTreeTableCell *treeCell = [tableView dequeueReusableCellWithIdentifier:TreeCellID];
    if (!treeCell) {
        treeCell =  [[BaseTreeTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TreeCellID];
    }
    treeCell.indentationLevel = node.level; // 缩进级别
    treeCell.indentationWidth = 15.f; // 每个缩进级别的距离
    treeCell.node = node;
    
    treeCell.textLabel.text = node.descrb;
    
    return treeCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BaseNode *currentNode = self.tempData[indexPath.row];
    if (!currentNode.isParentNode) {
        NSLog(@"点击跳转");
    }else{
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //将此节点下的所有数据插入进来并展开
            NSUInteger startPosition = indexPath.row+1;
            NSUInteger endPosition = startPosition;
            BOOL expand = NO;
            for (int i=0; i<self.allDatas.count; i++) {
                BaseNode *node = [self.allDatas objectAtIndex:i];
                if (node.parentNodeID == currentNode.ID) {
                    node.isShowing = !node.isShowing;
                    if (node.isShowing) {
                        //需要插入
                        [_tempData insertObject:node atIndex:endPosition];
                        expand = YES;
                        //BaseTreeTableCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                        //[cell updateUI];
                        endPosition++;
                    }else{
                        //需要移除
                        expand = NO;
                        endPosition = [self removeAllNodesAtParentNode:currentNode];
                        break;
                    }
                }
            }
            //插入或者删除cell
            [self insertOrDeleteTempCellTableView:tableView isInsert:expand startPosition:startPosition endPosition:endPosition];
        });
        
    }
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

#pragma mark 其它
/**
 *  删除该父节点下的所有子节点（包括孙子节点）
 *
 *  @param parentNode 父节点
 *
 *  @return 该父节点下一个相邻的统一级别的节点的位置
 */
-(NSUInteger)removeAllNodesAtParentNode : (BaseNode *)parentNode{
    NSUInteger startPosition = [self.tempData indexOfObject:parentNode];
    NSUInteger endPosition = startPosition;
    
    for (NSUInteger i=startPosition+1; i<self.tempData.count; i++) {
        BaseNode *node = [_tempData objectAtIndex:i];
        endPosition++;
        if (node.level <= parentNode.level) {
            //跟父节点同一级则到了不需要删除的地方
            break;
        }
        if(endPosition == _tempData.count-1){
            endPosition++;
            node.isShowing = NO;
            break;
        }
        node.isShowing = NO;
    }
    if (endPosition>startPosition) {
        [_tempData removeObjectsInRange:NSMakeRange(startPosition+1, endPosition-startPosition-1)];
    }
    return endPosition;
}

//从某位置插入cell或者删除cell
-(void)insertOrDeleteTempCellTableView:(UITableView *)tableview
                              isInsert:(BOOL)isInsert
                         startPosition:(NSInteger)startPosition
                           endPosition:(NSInteger)endPosition
{
    //获得需要修正的indexPath
    NSMutableArray *indexPathArray = [NSMutableArray array];
    for (NSUInteger i=startPosition; i<endPosition; i++) {
        NSIndexPath *tempIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [indexPathArray addObject:tempIndexPath];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self beginUpdates];//会重新调用下cell高度
        // 插入或者删除相关节点
        if (isInsert) {
            [self insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationRight];
            
        }else{
            [self deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationNone];
        }
        [self endUpdates];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:startPosition-1 inSection:0];
        [tableview deselectRowAtIndexPath:indexPath animated:NO];
        
    });
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
