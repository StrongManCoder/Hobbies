//
//  RequestData.h
//  JSONMessage
//
//  Created by usr on 14-8-16.
//  Copyright (c) 2014年 MIAO L ®. All rights reserved.
//

#import <Foundation/Foundation.h>
//

@interface MyTool : NSObject

//获得请求管理者

+(id)shareInstance;
/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)get:(NSString*)url
     parama:(NSDictionary*)parama
    succese:(void(^)(id responseObj))success
    failure:(void(^)(NSString * error))failure;

/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)post:(NSString*)url
      params:(NSDictionary*)params
     succese:(void(^)(id responseObj))succeaa
     failure:(void(^)(NSString*error))failure;


/**
 *  万能九宫格
 *
 *  @param backView 九宫格要显示的底层view
 *  @param view     要显示的view
 *  @param number   要显示的view 的个数
 *  @param eColum   期望显示的view 分几列
 *
 *  @return 返回的是view的数组
 */
+(NSMutableArray *)jiuGongGeWithBackGroundView:(UIView *)backView  view:(UIView *)view numberOfViews:(int)number exceptColum:(int)eColum;


@end
