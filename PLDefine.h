//
//  PLDefine.h
//  PLTool
//
//  Created by apple on 15/2/19.
//  Copyright (c) 2015年 P.L.Technology. All rights reserved.
//

#ifndef PLTool_PLDefine_h
#define PLTool_PLDefine_h

#define kPLScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kPLScreenHeight [[UIScreen mainScreen] bounds].size.height

#define kFrame_X(View) View.frame.origin.x
#define kFrame_Y(View) View.frame.origin.y
#define kFrame_Width(View) View.frame.size.width
#define kFrame_Height(View) View.frame.size.height

#define kFrame_XWidth(View) View.frame.origin.x + View.frame.size.width
#define kFrame_YHeight(View) View.frame.origin.y + View.frame.size.height

//判断系统版本是否为7.0以上
#define kPLIOS7          ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
//判断系统版本是否为8.0以上
#define kPLIOS8          ([[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending)
//获取不同版本下导航条的高度
#define kPLNavBarHeight  (kPLIOS7 ? 64 : 44)
//获取不同版本下除去导航条后屏幕的高度
#define kPLDeleteNavBarHeight  (kPLIOS7 ? kPLScreenHeight - 64 : kPLScreenHeight - 44)
//获取FileManager
#define kPLFileManager [NSFileManager defaultManager]
//判断文件是否存在
#define kPLFileIsExists(path) [[NSFileManager defaultManager] fileExistsAtPath:path]
//获取沙盒路径
#define kPLBasePath [NSString stringWithFormat:@"%@/Documents",NSHomeDirectory()]
//获取通知中心
#define kPLNotificationCenter [NSNotificationCenter defaultCenter]
//获取AppDelegate
#define kPLAppDelegate [[UIApplication sharedApplication] delegate]
//获取NSUserDefault
#define kPLUserDefault [NSUserDefaults standardUserDefaults]

#ifdef DEBUG
#define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#define ELog(err) {if(err) DLog(@"%@", err)}
#else
#define DLog(...)
#define ELog(err)
#endif

// 颜色值
// 16进制颜色
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// RGB颜色
#define kRGB(r,g,b) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:1]
#define kBlackColor [UIColor blackColor]
#define kDarkGrayColor [UIColor darkGrayColor]
#define kLightGrayColor [UIColor lightGrayColor]
#define kWhiteColor [UIColor whiteColor]
#define kGrayColor [UIColor grayColor]
#define kRedColor [UIColor redColor]
#define kGreenColor [UIColor greenColor]
#define kBlueColor [UIColor blueColor]
#define kCyanColor [UIColor cyanColor]
#define kYellowColor [UIColor yellowColor]
#define kMagentaColor [UIColor magentaColor]
#define kOrangeColor [UIColor orangeColor]
#define kPurpleColor [UIColor purpleColor]
#define kBrownColor [UIColor brownColor]
#define kClearColor [UIColor clearColor]

#define AlertShow(msg) [[[UIAlertView alloc]initWithTitle:@"温馨提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show]



#endif
