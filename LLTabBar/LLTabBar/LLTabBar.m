//
//  LLTabBar.m
//  LLTabBar
//
//  Created by luo luo on 22/02/2018.
//  Copyright © 2018 ChangeStrong. All rights reserved.
//

#import "LLTabBar.h"
#import "LLTabBarView.h"

@implementation LLTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//解决点击中间按钮上边缘无响应问题
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    if (self.isHidden == NO) {
        
        LLTabBarView *tabBarBgView;
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[LLTabBarView class]]) {
                tabBarBgView= (LLTabBarView *)view;
//                NSLog(@"找到了LLTabBarView pointX=%f Y=%f",point.x,point.y);
                break;
            }
        }
        if (tabBarBgView) {
            //将tabBar上的point这个点转换到中心按钮上的坐标点
            CGPoint newP = [self convertPoint:point toView:tabBarBgView.centerButton];
//            NSLog(@"newPointX=%f Y=%f",newP.x,newP.y);
            //判断此点是否点击button上
            if ( [tabBarBgView.centerButton pointInside:newP withEvent:event]) {
//                NSLog(@"点击了中间button");
                return [tabBarBgView.centerButton hitTest:newP withEvent:event];
            }else{
//                NSLog(@"此点不在中间按钮上");
                return [super hitTest:point withEvent:event];
            }
        }else{
            
            return [super hitTest:point withEvent:event];
        }
        
    }else {
        return [super hitTest:point withEvent:event];
    }
}


@end
