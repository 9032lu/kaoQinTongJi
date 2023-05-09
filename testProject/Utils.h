//
//  Utils.h
//  WormManager
//
//  Created by ZhangTu on 2018/1/12.
//  Copyright © 2018年 zhangtu. All rights reserved.
//

#ifndef Utils_h
#define Utils_h

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]

#define UIColorFromHex(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:1.0]
#define fontScale 1

//#define fontScale [UIScreen mainScreen].bounds.size.width/375.0
#define bigFont [UIFont systemFontOfSize:24 * fontScale]
#define largeFont [UIFont systemFontOfSize:20 * fontScale]
#define BMTitleFont [UIFont systemFontOfSize:18 * fontScale]
#define BMNormalFont [UIFont systemFontOfSize:16 * fontScale]
#define BMFifteenFont [UIFont systemFontOfSize:15 * fontScale]

#define BMsmallFont [UIFont systemFontOfSize:14 * fontScale]
#define SAMCHAIN_SERVE @"com.swanGooseReading.www"
#define SAMCHAIN_UUID  @"uuid"

#define LZDMainColor  RGB(194,31,24)
#define themeColor_light RGBA(242,220,153,1.0)

#define  SETTitleTextColorFont  [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:largeFont,NSForegroundColorAttributeName:RGB(255,255,255)}];

//真机还是模拟器
#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR 1
#elif TARGET_OS_IPHONE
#define SIMULATOR 0
#endif

#define ZTScreenW   [UIScreen mainScreen].bounds.size.width
#define ZTScreenH   [UIScreen mainScreen].bounds.size.height

#define ScreenWidth   [UIScreen mainScreen].bounds.size.width
#define ScreenHeight   [UIScreen mainScreen].bounds.size.height
// 判断是否为iPhone X 系列  这样写消除了在Xcode10上的警告。
#define iPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

#define CardNum_default  @"00022388"
#define CardPass_default  @"123456"
#define libararyId_default  @"10055"


//#define iPhoneX (ScreenWidth == 375.f && ScreenHeight == 812.f ? YES : NO)
// Status bar height.
#define StatusBarHeight  (iPhoneX ? 44.f : 20.f)

// Navigation bar height.
#define NavigationBarHeight  44.f

// Tabbar height.
#define TabbarHeight  (iPhoneX ? (49.f+34.f) : 49.f)
// Tabbar safe bottom margin.
#define TabbarSafeBottomMargin (iPhoneX ? 34.f : 0.f)
// Status bar & navigation bar height.
#define StatusBarAndNavigationBarHeight  (iPhoneX ? 88.f : 64.f)

#define ViewSafeAreInsets(view) ({UIEdgeInsets insets; if(@available(iOS 11.0, *)) {insets = view.safeAreaInsets;} else {insets = UIEdgeInsetsZero;} insets;})

#define  PUSH(viewColler)  viewColler*vc =[[viewColler alloc]init];[self.navigationController pushViewController:vc animated:YES];

#define  POP   [self.navigationController popViewControllerAnimated:YES];

#define HIDEHUD  [MBProgressHUD hideHUDForView:self.view animated:YES];

#define SHOWHUD [MBProgressHUD showHUDAddedTo:self.view animated:YES];

/* 使用高德地图API，请注册Key，注册地址：http://lbs.amap.com/dev/#/ */

const static NSString *AmapAPIKey = @"5bccd8e529dbbdc0587cc0d2e872b7d2";

const static NSString *AmapTableID = @"";


//打印的日志
#ifdef DEBUG
#define LZDLog(...) \
NSLog(@"%@第%d行:%@\n---------------------------",[[NSString stringWithFormat:@"%s",__FILE__] componentsSeparatedByString:@"/"][[[NSString stringWithFormat:@"%s",__FILE__] componentsSeparatedByString:@"/"].count-1], __LINE__, [NSString stringWithFormat:__VA_ARGS__]);
#else
#define LZDLog(...)
#endif


#define  SCANEDSUCCESSNOTIFICATION @"LzdScanedSuccess"

#define  BUILDIDNOTIFICATION @"buildIDNotification"
#define  USER_INFO_KEY  @"userInfo_key"
#define  LZDUserPhone  @"userLoginPhone"
#define  LZDUserPassWord  @"userLoginPassWord"


//图书图片占位图
#define BOOKPlaceHolderImgName @"book_bg"
#define HeaderPlaceHolderImgName @"资源 5"

#define BannedColor RGBA(194,31,24,1.0)



#define backgColor RGBA(234,234,234,1.0)
#define TEXTColor  RGBA(51,51,15,1.0)

#define TEXTLightGrayColor  RGBA(153,153,153,1.0)

/** 按钮颜色 */
#define ZTBTNCOLOR  RGBA(255, 180, 0,1)


#define  IP_   @"206"
#define  Host_IP_   @"5"

//#ifdef DEBUG
//
//#define RequestTimeOut 15
////#define  URLHeader   [NSString stringWithFormat:@"http://192.168.%@.%@:8080/",Host_IP_,IP_]
//
//#define  URLHeader   @"http://sxkj.s1.natapp.cc/"
//
//#else
#define RequestTimeOut 15


#define  URLHeader   @"http://hy.xianmaigu.com/"

//#endif


/**
 图书图片
 */
#define  BookIconHeader  @"http://sf.xianmaigu.com:8088/api/pic/isbn/"


/**
 头型地址

 */
#define  IMGHeader   [NSString stringWithFormat:@"%@upload/",URLHeader]

/**
 1.用户注册(用手机号)
 @long phone,电话号码
 @String verificationCode,手机验证码
 @String pass,密码（密码长度必须在6~18位以内）
*/
#define User_registerByPhone   [NSString stringWithFormat:@"%@hongYan/user/registerByPhone.html",URLHeader]


/**
2.用户登录（按手机号
 ：Long phone,
 String pass,
 String deviceName,设备名
 String deviceId,设备号
 String deviceVersion,系统版本
 String deviceType,系统类型
 */
#define User_loginByPhone   [NSString stringWithFormat:@"%@hongYan/user/loginByPhone.html",URLHeader]


/**
3.获取手机UUID并分配一个TOKEN
 参数：deviceId  设备号
 */
#define User_getMessageToken [NSString stringWithFormat:@"%@hongYan/user/getMessageToken.html", URLHeader]


/**
4.获取验证码
 参数： phone 注册手机号
 codeIndex 1代表找回密码，0代表注册
 deviceId  设备号
 token 获取验证码的token，（通过getMessageToken获取到的）前台加密后传给后台     
 */
#define User_getMessageCode [NSString stringWithFormat:@"%@hongYan/user/getMessageCode.html",URLHeader]


/**
5.找回密码
 参数： Long userId
 String phone 电话号码
 String pass 密码
 String verificationCode 验证码
 */
#define User_retrievePass [NSString stringWithFormat:@"%@hongYan/user/retrievePass.html",URLHeader]



/**
6.修改用户头像
 Long userId
 coverFile 照片名字
 */
#define User_editHeader [NSString stringWithFormat:@"%@hongYan/user/editHeader.html",URLHeader]



/**
7.绑定图书馆
 参数： userId 用户id
 cardNum 读者证号
 cardPs 账号密码
 */
#define User_bind [NSString stringWithFormat:@"%@hongYan/user/bind.html",URLHeader]
/**
 8.获取绑卡页面信息
 */
#define User_getLibraryInfo [NSString stringWithFormat:@"%@hongYan/user/getLibraryInfo.html",URLHeader]

/**
 9.获取首页数据
 
 参数：
 libraryId
 cardNumber
 */
#define Book_getHomeInfo [NSString stringWithFormat:@"%@hongYan/book/getHomeInfo.html",URLHeader]



/**
 10.获取查询条件和热搜词
 参数：
 libraryId
 */
#define Book_getSearchCodeAndHotwords [NSString stringWithFormat:@"%@hongYan/book/getSearchCodeAndHotwords.html",URLHeader]
/**
11.修改昵称
 参数：
 userId
 nickName 昵称
 */
#define User_editNickName [NSString stringWithFormat:@"%@hongYan/user/editNickName.html",URLHeader]
/**
12.图书查询
 参数：
 page
 keywords 关键字
 searchType 搜索类型
 libraryId
 */
#define Book_searchBook [NSString stringWithFormat:@"%@hongYan/book/searchBook.html",URLHeader]


/**
 15.查询单册书籍副本
 参数：
 libraryId
 userId
 docnumber
 */
#define Book_getItem [NSString stringWithFormat:@"%@hongYan/book/getItem.html", URLHeader]


/**
16.扫描isbn借书
 参数：
 libraryId
 userId
 cardNumber
 isbn
 bookName
 */
#define Book_borrowByIsbn [NSString stringWithFormat:@"%@hongYan/book/borrowByIsbn.html", URLHeader]


///**
// 17.扫码结算  书店使用
// 参数：
// borrowRecordId
// */
//#define Book_settleBook [NSString stringWithFormat:@"%@hongYan/book/settleBook.html", URLHeader]

/**
 18.在借图书
 参数：
 libraryId
 page
 cardNumber
 */
#define Book_getBorrowBook [NSString stringWithFormat:@"%@hongYan/book/getBorrowBook.html", URLHeader]
#define Book_getBorrowList [NSString stringWithFormat:@"%@hongYan/book/getBorrowList.html", URLHeader]



/**
19.在借历史
 参数：
 libraryId
 page
 cardNumber
 
 */
#define Book_getHistoryBorrowRecord [NSString stringWithFormat:@"%@hongYan/book/getHistoryBorrowRecord.html", URLHeader]
#define Book_getBorrowHistory [NSString stringWithFormat:@"%@hongYan/book/getBorrowHistory.html", URLHeader]


/**
20.修改借书卡密码
 参数：
 userId
 libraryId
 oldPassword
 newPassword
 */
#define User_updatePassword [NSString stringWithFormat:@"%@hongYan/user/updatePassword.html", URLHeader]

/**
21.获取呼和浩特市图合作的新华书店
 参数：
 libraryId
 page
 */
#define Book_getBookStore [NSString stringWithFormat:@"%@hongYan/book/getBookStore.html", URLHeader]
/**
22.获取生成校验二维码的信息
 参数：
 //borrowRecordId 在借记录的主键id
 */
#define Book_getQRCodeInfo [NSString stringWithFormat:@"%@hongYan/book/getQRCodeInfo.html", URLHeader]
/**
23.还书操作 参数：
 borrowRecordId 在借记录的主键id
 */
#define Book_returnBook [NSString stringWithFormat:@"%@hongYan/book/returnBook.html", URLHeader]

/**
 24.验证是否可以购书
 参数：
 borrowRecordId 在借记录的主键id
 */
#define Book_checkBuyBook [NSString stringWithFormat:@"%@hongYan/book/checkBuyBook.html", URLHeader]

#pragma mark  12.27根据客户要求修改

/**
 1
 参数：
 根据卡号，密码登录
 */
#define User_loginByCardNumberAndPass [NSString stringWithFormat:@"%@hongYan/user/loginByCardNumberAndPass.html", URLHeader]


/**
、图书续借(调图创接口 v2.0)
 参数：barNumber //书籍barNumber（馆藏码）
 cardNumber //卡号
 */
#define Book_continueBorrow [NSString stringWithFormat:@"%@hongYan/book/continueBorrow.html", URLHeader]
/**
获取鸿雁借阅图书
 参数：
 cardNumber //卡号
 */
#define Book_getHongYanBorrowBook [NSString stringWithFormat:@"%@hongYan/book/getHongYanBorrowBook.html", URLHeader]
/**
 获取结算验证码
 参数：id
 借书记录的主键id
 */
#define Book_getVerificationCode [NSString stringWithFormat:@"%@hongYan/book/getVerificationCode.html", URLHeader]

/**
 获得当前图书的电子书

 isbn=1234569
 libraryId=10000
 cardNumber=4567
 
 说明：url=null 为空则代表当前图书没有电子书
 openTouristMode 1代表游客模式可以阅读
 2代表非游客模式，必须登陆才可以看电子书

 */
#define Book_getEbAllShopEbook [NSString stringWithFormat:@"%@hongYan/book/getEbAllShopEbook.html", URLHeader]


/**
 获取电子书的阅读记录
 
 cardNumber=123456&libraryId=10000
 说明：shelflife;//1代表正常，0代表已经过期

 */
#define Book_getMyBookShell [NSString stringWithFormat:@"%@hongYan/book/getMyBookShell.html", URLHeader]

/**
通过书商id获取书商信息:
 参数：bookSho
 pId=12&libraryId=10000
 借书记录的主键id
 */
#define Book_getUrlByBookshopId [NSString stringWithFormat:@"%@hongYan/book/getUrlByBookshopId.html", URLHeader]


/**
 添加阅读记录
:
 参数：
 bookName=当时只道是寻常
 libraryId=10000
 cardNumber=4567
 author=纳兰
 searchCode=TP311/10
 isbn=456774
 publisher=电子工业
 publishDate=2015
 docNumber=45645


 */
#define Book_addBookToMyShell [NSString stringWithFormat:@"%@hongYan/book/addBookToMyShell.html", URLHeader]

/**
 删除电子书的阅读记录:
 参数：

 Ids=1,2,3
 
 */
#define Book_delMyShell [NSString stringWithFormat:@"%@hongYan/book/delMyShell.html", URLHeader]

/**
 人天电子书商城入口:

 @return  * libraryId 必须
 cardNumber 非必须，登陆之后传，未登陆可不传

 */
#define Book_getAllShopEbooks [NSString stringWithFormat:@"%@hongYan/book/getAllShopEbooks.html", URLHeader]


/**
鸿雁快借:
 Step1通过接口获取rdid ，libcode
 接口：/hongYan/user/loginBookFastBorrow.html?cardNumber=c2018112702
 请求方式：POST/GET

 参数说明：cardNumber 卡号

 */
#define Book_loginBookFastBorrow [NSString stringWithFormat:@"%@hongYan/user/loginBookFastBorrow.html", URLHeader]

/**
 鸿雁悦读续借图书接口
 接口：hongyan/book/continueBorrow.html
 请求方式：POST
 参数说明：cardNumber 卡号
         barNumber   书的馆藏码、条码号

 */
#define Book_newContinueBorrow [NSString stringWithFormat:@"%@hongYan/book/continueBorrow.html", URLHeader]

/**
 鸿雁悦读在借图书接口
 接口：hongyan/book/getBorrowList.html
 请求方式：POST
 参数说明：cardNumber 卡号

 */
#define Book_newGetBorrowList [NSString stringWithFormat:@"%@hongYan/book/getBorrowList.html", URLHeader]
/**
 空白网页

 @return <#return value description#>
 */
#define LZDBlankUrl @"about:blank"



#define LZDPlaceHolderImage  [UIImage imageNamed:@"book_bg"]



#endif /* Utils_h */
