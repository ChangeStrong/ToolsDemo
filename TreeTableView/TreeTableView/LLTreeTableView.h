//
//  LLTreeTableView.h
//  TreeTableView
//
//  Created by luo luo on 23/02/2018.
//  Copyright © 2018 ChangeStrong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNode.h"
@interface LLTreeTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
-(void)setDataArray:(NSArray <BaseNode *> *)dataArray;



@end
