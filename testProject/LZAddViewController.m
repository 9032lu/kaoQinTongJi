//
//  LZAddViewController.m
//  testProject
//
//  Created by lzd on 2023/5/7.
//

#import "LZAddViewController.h"
@interface LZAddViewController ()
@property (nonatomic,strong) NSDate *startDate;
@property (nonatomic,strong) NSDate *endData;

@end

@implementation LZAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"增加";
    self.view.backgroundColor = UIColor.greenColor;
    
}

- (IBAction)addClick:(id)sender {
    
    NSTimeInterval interval = [self.endData timeIntervalSinceDate:self.startDate];
    CGFloat hours = interval / 3600.f;
    NSLog(@"%f, %f", interval, hours);
}
- (IBAction)startTap:(UITapGestureRecognizer *)sender {
    WSDatePickerView *dataPick = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowMonthDayHourMinute CompleteBlock:^(NSDate *date) {
        self.startDate = date;
        UILabel *lab = (UILabel *)sender.view;
        lab.text = [self changeData:date];
    }];
    [dataPick show];
}
- (IBAction)endTap:(UITapGestureRecognizer *)sender {
    WSDatePickerView *dataPick = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowMonthDayHourMinute CompleteBlock:^(NSDate *date) {
        NSLog(@"%@",date);
        self.endData = date;
        UILabel *lab = (UILabel *)sender.view;
        lab.text = [self changeData:date];
    }];
    [dataPick show];
}

- (NSString *)changeData:(NSDate *)date {
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    objDateformat.timeZone = [NSTimeZone localTimeZone];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * str = [NSString stringWithFormat:@"%@",[objDateformat stringFromDate: date]];
    return str;
}

@end
