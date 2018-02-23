//
//  BaseTreeTableCell.h
//  TreeTableView
//
//  Created by luo luo on 23/02/2018.
//  Copyright © 2018 ChangeStrong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNode.h"
@interface BaseTreeTableCell : UITableViewCell
//携带的节点信息
@property(nonatomic, strong) BaseNode *node;

@end
