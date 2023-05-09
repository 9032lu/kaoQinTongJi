//
//  LZListViewController.m
//  testProject
//
//  Created by lzd on 2023/5/7.
//

#import "LZListViewController.h"
#import "LZAddViewController.h"

@interface LZListViewController ()

@end

@implementation LZListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"列表";
    self.view.backgroundColor = UIColor.blueColor;
    // Do any additional setup after loading the view from its nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    LZAddViewController *vc = [[LZAddViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
