//
//  LLTabBarVC.m
//  LLTabBar
//
//  Created by luo luo on 22/02/2018.
//  Copyright © 2018 ChangeStrong. All rights reserved.
//

#import "LLTabBarVC.h"
#import "LLTabBar.h"
#import "LLTabBarView.h"

@interface LLTabBarVC ()
@property(nonatomic, strong) LLTabBarView *tabBarBarBgView;
@end

@implementation LLTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    LLTabBar *tabBar = [[LLTabBar alloc]init];
    
    tabBar.frame =  self.tabBar.frame;
    //替换系统自带tabBar
    [self setValue:tabBar forKey:@"tabBar"];
    
    self.tabBarBarBgView = [[[NSBundle mainBundle] loadNibNamed:@"LLTabBarView" owner:nil options:nil] firstObject];
//    self.tabBarBarBgView.frame = tabBar.bounds;
   
    [tabBar addSubview:self.tabBarBarBgView];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    
    [tabBar setShadowImage:[[UIImage alloc] init]];
    [tabBar setBackgroundImage:[[UIImage alloc] init]];
    
    
     NSLog(@"tabBarHeight:%f,",self.tabBar.bounds.size.height);
}

//更改tabBar高度
-(void)viewWillLayoutSubviews{
    CGRect tabFrame = self.tabBar.frame;//(0,687,414,49)
    tabFrame.size.height = 69;
    tabFrame.origin.y = self.view.frame.size.height-69;
    self.tabBar.frame = tabFrame;
    self.tabBarBarBgView.frame = self.tabBar.bounds;
}


#pragma mark 横屏相关
// New Autorotation support. IOS(6_0);
- (BOOL)shouldAutorotate
{
    UIViewController *viewController = self.selectedViewController;
    return [viewController shouldAutorotate];
}

//IOS(6_0)
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    UIViewController *viewController = self.selectedViewController;
    return [viewController supportedInterfaceOrientations];
}
//// Returns interface orientation masks. IOS(6_0);
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    UIViewController *viewController = self.selectedViewController;
    return [viewController preferredInterfaceOrientationForPresentation];
}

//状态栏
- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.selectedViewController;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
