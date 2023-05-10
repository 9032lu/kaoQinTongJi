//
//  ViewController.m
//  testProject
//
//  Created by 鲁征东 on 2022/11/23.
//

#import "ViewController.h"

static NSString * const fotmatHour = @"HH:mm:ss";
static NSString * const fotmatDay = @"yyyyMMdd";
static NSString * const fotmatMonth = @"yyyyMM";


@interface ViewController ()<FSCalendarDelegate, FSCalendarDataSource>
@property (weak, nonatomic) IBOutlet FSCalendar *calendar;
@property (nonatomic, copy) NSString *startDate;
@property (nonatomic, copy) NSString *endData;
@property (weak, nonatomic) IBOutlet UILabel *startLab;
@property (weak, nonatomic) IBOutlet UILabel *endLab;
@property (weak, nonatomic) IBOutlet UIButton *btn;
/// <#Description#>
@property (nonatomic, strong) NSDate *currentDate;
/// <#Description#>
@property (nonatomic, strong) NSMutableDictionary *dataSource;
/// 当前选中月
@property (nonatomic, strong) NSString *currentMonth;
/// 当前选中日
@property (nonatomic, strong) NSString *currentDay;
@property (nonatomic, copy) NSString *plistPath;

/// 单日统计
@property (weak, nonatomic) IBOutlet UILabel *dayTongji;
@property (weak, nonatomic) IBOutlet UILabel *workDaysLab;

/// 日均统计
@property (weak, nonatomic) IBOutlet UILabel *everyDayTongji;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    [self setCalendar:self.calendar];
    self.btn.layer.cornerRadius= 20;
    self.btn.layer.masksToBounds = YES;
    self.dataSource = [self readPlist];
    self.currentMonth = [self changeData:self.currentDate withFormate:fotmatMonth];
    self.currentDay = [self changeData:self.currentDate withFormate:fotmatDay];
    [self setLabData];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"clear" style:UIBarButtonItemStyleDone target:self action:@selector(clearClick)];
    // Do any additional setup after loading the view.
}
- (void)clearClick {
    NSMutableDictionary *mutabD = [NSMutableDictionary dictionaryWithDictionary:self.dataSource[_currentMonth]];
    [mutabD removeObjectForKey:_currentDay];
    [self.dataSource setValue:mutabD forKey:_currentMonth];
    BOOL success = [self.dataSource writeToFile:self.plistPath atomically:YES];
    if (success) {
        NSLog(@"写入成功");
        [self setLabData];

    } else {
        NSLog(@"写入失败");
    }
}
- (NSMutableDictionary *)readPlist {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    self.plistPath = [path stringByAppendingPathComponent:@"recod.plist"];
    NSMutableDictionary *dic;
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.plistPath]) {
        dic = [NSMutableDictionary dictionaryWithContentsOfFile:self.plistPath];
    }
    if (!dic) {
        dic = [NSMutableDictionary dictionary];
    }
    NSLog(@"%@",dic);
    return dic;
}

#pragma mark - FSCalendarDelegate ,dataSource

- (NSString *)calendar:(FSCalendar *)calendar subtitleForDate:(NSDate *)date {
    NSString *month = [self changeData:date withFormate:fotmatMonth];
    NSString *day = [self changeData:date withFormate:fotmatDay];
    NSDictionary *dayDic = self.dataSource[month][day];
    if ([dayDic[@"hours"] length] > 0) {
        return @"已打卡";
    }

    return @"";
}

// 设置五行显示时的calendar布局
- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated {
    [UIView animateWithDuration:.3 animations:^{
//        calendar.frame = (CGRect){calendar.frame.origin,bounds.size};
//        self.myTableView.frame = CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT);
//        ScheduleHeaderView *headerView = (ScheduleHeaderView *)[self.myTableView headerViewForSection:0];
//        headerView.frame = calendar.frame;
//        [self.myTableView reloadData];
    } completion:^(BOOL finished) {
    }];
    NSLog(@"0---%f",calendar.frame.origin.y);
//    NSLog(@"0---%f",self.myTableView.frame.origin.y);
}

// 对有事件的显示一个点,默认是显示三个点
- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
//    if ([self.datesWithEvent containsObject:[dateFormatter stringFromDate:date]]) {
//        return 1;
//    }
    return 0;
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar {
    
    NSLog(@"calendar.currentPage--  %@",calendar.currentPage);
    //日历翻页时记录第一天
//    NSDate *changeDate = [calendar tomorrowOfDate:calendar.currentPage];
//    NSDate *changeDate = calendar.currentPage;
//    dateStr = [calendar stringFromDate:changeDate format:@"yyyyMMdd"];
//    //有事件的日期的年和月
//    NSDateFormatter *formatterYearAndMonth = [[NSDateFormatter alloc] init];
//    formatterYearAndMonth.dateFormat = @"yyyy-MM";
//    dateYearAndMonthStr = [formatterYearAndMonth stringFromDate:changeDate];
//    // 当日
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat = @"yyyy-MM-dd";
//    NSString *todayDateYearAndMonthStr = [formatterYearAndMonth stringFromDate: [NSDate date]];
//    // 设置切换到当前月份的时候,显示的是当天的日程
//    if ([[dateYearAndMonthStr substringWithRange:NSMakeRange(5, 2)] isEqualToString:[todayDateYearAndMonthStr substringWithRange:NSMakeRange(5, 2)]]) {
//        dateStr = [calendar stringFromDate:[NSDate date] format:@"yyyyMMdd"];
//    }
//    [self loadData];
}
- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    self.currentDate = date;
    NSString *day = [self changeData:date withFormate:fotmatDay];
    NSString *hour = [self changeData:[NSDate date] withFormate:fotmatHour];
    NSLog(@"did select date %@ %@", day, hour);
    
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    objDateformat.timeZone = [NSTimeZone localTimeZone];
    [objDateformat setDateFormat:[NSString stringWithFormat:@"%@ %@", fotmatDay, fotmatHour]];
    self.currentDate = [objDateformat dateFromString:[NSString stringWithFormat:@"%@ %@", day, hour]];
    
    self.currentDay = [self changeData:date withFormate:fotmatDay];
    self.currentMonth = [self changeData:date withFormate:fotmatMonth];
    [self setLabData];
   
}

/// 设置lab文字
- (void)setLabData {
    NSString *s = self.dataSource[_currentMonth][_currentDay][@"start"];
    NSString *e = self.dataSource[_currentMonth][_currentDay][@"end"];
    NSString *h = self.dataSource[_currentMonth][_currentDay][@"hours"];

    self.startLab.text = s.length > 0 ? s : @"未打卡";
    self.endLab.text = e.length > 0 ? e : @"未打卡";
    self.dayTongji.text = h.length > 0 ? h : @"--";
    self.startDate = s;
    self.endData = e;

    NSDictionary *dic = _dataSource[_currentMonth];
    NSArray *days = dic.allValues;
   __block CGFloat allhours = 0.0;

    [days enumerateObjectsUsingBlock:^(NSDictionary  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        allhours += [obj[@"hours"] floatValue];
    }];
    CGFloat everyDays = allhours / days.count;
    self.everyDayTongji.text =  [NSString stringWithFormat:@"%.2f", everyDays];
    self.workDaysLab.text = [NSString stringWithFormat:@"出勤：%ld天", days.count];

}
- (IBAction)startTap:(UITapGestureRecognizer *)sender {
    WSDatePickerView *dataPick = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowHourMinuteSecond scrollToDate:self.currentDate CompleteBlock:^(NSDate *date) {
        NSLog(@"%@",date);
        UILabel *lab = (UILabel *)sender.view;
        self.startDate = lab.text = [self changeData:date withFormate:fotmatHour];
    }];
    [dataPick show];
}
- (IBAction)endTap:(UITapGestureRecognizer *)sender {
        
    WSDatePickerView *dataPick =  [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowHourMinuteSecond scrollToDate:self.currentDate CompleteBlock:^(NSDate *date) {
        NSLog(@"%@",date);
        UILabel *lab = (UILabel *)sender.view;
        self.endData = lab.text = [self changeData:date withFormate:fotmatHour];
    }];
    [dataPick show];
}
- (IBAction)editBtnClick:(UIButton *)sender {
    if (sender.isSelected) {
        NSMutableDictionary *currentMonthDays = [NSMutableDictionary dictionaryWithDictionary:self.dataSource[self.currentMonth]];
        NSMutableDictionary *currentDayDic = [NSMutableDictionary dictionaryWithDictionary:currentMonthDays[self.currentDay]];
      
        [currentDayDic setValue:self.currentDay forKey:@"day"];
        [currentDayDic setValue:self.startDate forKey:@"start"];
        [currentDayDic setValue:self.endData forKey:@"end"];
        if (self.startDate.length > 0 && self.endData.length > 0) {
            NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
            objDateformat.timeZone = [NSTimeZone localTimeZone];
            [objDateformat setDateFormat:[NSString stringWithFormat:@"%@ %@", fotmatDay, fotmatHour]];
            NSDate *data8 = [objDateformat dateFromString:[NSString stringWithFormat:@"%@ %@", self.currentDay, @"08:00:00"]];
            NSDate *data12 = [objDateformat dateFromString:[NSString stringWithFormat:@"%@ %@", self.currentDay, @"12:00:00"]];
            NSDate *data13 = [objDateformat dateFromString:[NSString stringWithFormat:@"%@ %@", self.currentDay, @"13:30:00"]];
            NSDate *data17 = [objDateformat dateFromString:[NSString stringWithFormat:@"%@ %@", self.currentDay, @"17:30:00"]];
            NSDate *data18 = [objDateformat dateFromString:[NSString stringWithFormat:@"%@ %@", self.currentDay, @"18:00:00"]];
            NSDate *date_end = [objDateformat dateFromString:[NSString stringWithFormat:@"%@ %@", self.currentDay, self.endData]];
            NSDate *date_start = [objDateformat dateFromString:[NSString stringWithFormat:@"%@ %@", self.currentDay, self.startDate]];

            NSTimeInterval interval  = 0.0f;
            if ([self date:date_end isBetweenDate:data17 andDate:data18]) {
                interval = [data17 timeIntervalSinceDate:date_start];

                interval -= 1.5 * 60 * 60; // 午休1.5小时
            } else {
                interval = [date_end timeIntervalSinceDate:date_start];
                interval -= 2 * 60 * 60;
            }
            CGFloat hours = interval / 3600.0f;
            [currentDayDic setValue:[NSString stringWithFormat:@"%.2f", hours] forKey:@"hours"];
        }
        
        
        [currentMonthDays setValue:currentDayDic forKey:self.currentDay];
        [self.dataSource setValue:currentMonthDays forKey:self.currentMonth];
        NSLog(@"%@",_dataSource);
        BOOL success = [self.dataSource writeToFile:self.plistPath atomically:YES];
        if (success) {
            NSLog(@"写入成功");
        } else {
            NSLog(@"写入失败");
        }
    }
    
    [self setLabData];

    sender.selected = !sender.isSelected;
    self.startLab.userInteractionEnabled = self.endLab.userInteractionEnabled = sender.isSelected;
    if (sender.isSelected) {
        self.startLab.textColor = UIColor.redColor;
        self.endLab.textColor = UIColor.redColor;

    } else {
        self.startLab.textColor = UIColor.blackColor;
        self.endLab.textColor = UIColor.blackColor;
    }
}

- (BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate {

    if([date compare:beginDate] ==NSOrderedAscending) return NO;
    if([date compare:endDate] ==NSOrderedDescending) return NO;
    return YES;
}

- (NSString *)changeData:(NSDate *)date withFormate:(NSString *)formate {
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    objDateformat.timeZone = [NSTimeZone localTimeZone];
    [objDateformat setDateFormat:formate];
    NSString * str = [NSString stringWithFormat:@"%@",[objDateformat stringFromDate: date]];
    return str;
}
- (void)setCalendar:(FSCalendar *)calendar {
    _calendar = calendar;
    _calendar.dataSource = self;
    _calendar.delegate = self;
    _calendar.firstWeekday = 1;     //设置周一为第一天
    _calendar.appearance.weekdayTextColor = [UIColor blackColor];
    _calendar.appearance.weekdayFont = BMTitleFont;
    _calendar.appearance.headerTitleColor = [UIColor darkGrayColor];
    _calendar.appearance.titleDefaultColor = [UIColor darkGrayColor];
    _calendar.appearance.titleFont = BMTitleFont;
//        _calendar.appearance.subtitleDefaultColor = [UIColor greenColor];
    _calendar.appearance.eventDefaultColor = [UIColor lightGrayColor];
    _calendar.appearance.eventSelectionColor = [UIColor lightGrayColor];
    _calendar.appearance.selectionColor = [UIColor redColor];
    _calendar.appearance.headerDateFormat = @"yyyy年MM月";
    _calendar.appearance.todayColor = [UIColor clearColor];
    _calendar.appearance.titleTodayColor = [UIColor lightGrayColor];
    _calendar.appearance.subtitleTodayColor = [UIColor lightGrayColor];
    _calendar.appearance.borderRadius = 1.0;  // 设置当前选择是圆形,0.0是正方形
    _calendar.appearance.headerMinimumDissolvedAlpha = 0.0;
    _calendar.backgroundColor = [UIColor whiteColor];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文
    _calendar.locale = locale;  // 设置周次是中文显示
//        _calendar.headerHeight = 0.0f; // 当不显示头的时候设置
    _calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;  // 设置周次为一,二
    [_calendar selectDate:[NSDate date]]; // 设置默认选中日期是今天
    self.currentDate = [NSDate date];
    // 设置不能翻页
//        _calendar.pagingEnabled = NO;
//        _calendar.scrollEnabled = NO;
    _calendar.placeholderType = FSCalendarPlaceholderTypeFillHeadTail; //月份模式时，只显示当前月份
}

@end
