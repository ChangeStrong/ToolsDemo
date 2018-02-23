//
//  LLTabBarView.m
//  LLTabBar
//
//  Created by luo luo on 22/02/2018.
//  Copyright © 2018 ChangeStrong. All rights reserved.
//

#import "LLTabBarView.h"

@interface LLTabBarView()


@end

@implementation LLTabBarView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)centerButtonAction:(UIButton *)sender {
    NSLog(@"点击了");
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
//    self.centerButton.layer.cornerRadius = self.centerButton.frame.size.height/2.0;
//    self.centerButton.layer.masksToBounds = YES;
}

@end
