//
//  LZNavigationController.m
//  testProject
//
//  Created by lzd on 2023/5/7.
//

#import "LZNavigationController.h"

@interface LZNavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation LZNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
    self.delegate = self;
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_40px"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage new]];

//    self.navigationBar.shadowImage = [UIImage imageNamed:@"bg_40px"];
//    self.navigationBar.barTintColor = RGB(((194-40)/(1-40/255)), ((31-40)/(1-40/255)), ((24-40)/(1-40/255)));
    self.navigationBar.translucent = YES;
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:largeFont}];
    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *appearance = [UINavigationBarAppearance new];
        [appearance configureWithOpaqueBackground];
        [appearance setBackgroundColor:UIColor.whiteColor];
        [appearance setBackgroundImage:[UIImage imageNamed:@"bg_40px"]];
//        [appearance setShadowImage:[UIImage imageWithColor:UIColor.clearColor]];

        [appearance setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:largeFont}];
        self.navigationBar.standardAppearance = appearance;
        self.navigationBar.scrollEdgeAppearance = self.navigationBar.standardAppearance;
        
        [self.navigationBar.subviews.firstObject.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                       if ([obj isKindOfClass:NSClassFromString(@"_UIBarBackgroundShadowContentImageView")] || [obj isKindOfClass:NSClassFromString(@"_UIBarBackgroundShadowView")]) {
                           obj.hidden=YES;
                       }
                   }];
    }
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,21,19.5)];
        [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateHighlighted];
        [leftButton setTitle:@"返回" forState:0];
        [leftButton setTitle:@"返回" forState:UIControlStateHighlighted];
        [leftButton setTitleColor:UIColor.blackColor forState:0];
        leftButton.titleLabel.textColor = [UIColor blackColor];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
        viewController.navigationItem.leftBarButtonItem = leftItem;
        
    }
    
    [super pushViewController:viewController animated:YES];
}

-(void)back {
    
    [self popViewControllerAnimated:YES];
}

@end
