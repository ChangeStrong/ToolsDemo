//
//  BaseNode.h
//  TreeTableView
//
//  Created by luo luo on 23/02/2018.
//  Copyright © 2018 ChangeStrong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseNode : NSObject
//等级
@property(nonatomic, assign) NSInteger level;
//本节点ID
@property(nonatomic, assign) NSInteger ID;
//父节点ID
@property(nonatomic, assign) NSInteger parentNodeID;
//是否是可展开的父节点
@property(nonatomic) BOOL isParentNode;
//是否正在展示中
@property(nonatomic) BOOL isShowing;

//***可要可不要
@property(nonatomic, copy) NSString *descrb;

@end
