//
//  ViewController.m
//  TreeTableView
//
//  Created by luo luo on 23/02/2018.
//  Copyright © 2018 ChangeStrong. All rights reserved.
//

#import "ViewController.h"
#import "LLTreeTableView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet LLTreeTableView *treeTableView;
@property(nonatomic, strong) NSMutableArray <BaseNode *>*dataNodes;

@end

@implementation ViewController

-(NSMutableArray <BaseNode *>*)dataNodes
{
    if (!_dataNodes) {
        _dataNodes = [NSMutableArray new];
    }
    return _dataNodes;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadData];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.treeTableView setDataArray:self.dataNodes];
    [self.treeTableView reloadData];
}

-(void)loadData
{
    for (int i = 1; i<3; i++) {
        
        BaseNode *node0 = [[BaseNode alloc]init];
        node0.level = 0;
        node0.ID = i;
        node0.parentNodeID = 0;
        node0.isParentNode = YES;
        node0.isShowing = YES;
        node0.descrb = [NSString stringWithFormat:@"父%d",i];
        [self.dataNodes addObject:node0];
        for (int j=100; j<110; j++) {
            BaseNode *node = [[BaseNode alloc]init];
            node.level = 1;
            node.ID = j+i*100;
            node.parentNodeID = i;
            node.isParentNode = NO;
            node.isShowing = NO;
            node.descrb = [NSString stringWithFormat:@"parentId:%d ownId:%d",(int)node.parentNodeID,(int)node.ID];
            [self.dataNodes addObject:node];
        }
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
