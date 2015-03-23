//
//  RequestData.m
//  JSONMessage
//
//  Created by usr on 14-8-16.
//  Copyright (c) 2014年 MIAO L ®. All rights reserved.


#import "MyTool.h"
#import "AFHTTPRequestOperationManager.h"
@implementation MyTool
//获得请求管理者
+(id)shareInstance;
{
    //线程同步
    @synchronized(self)
    {
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
//    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        return mgr ;
    }
}

#pragma mark GET
+(void)get:(NSString *)url parama:(NSDictionary *)parama succese:(void (^)(id))success failure:(void (^)(NSString *))failure
{
    //开劈线程
    dispatch_async(dispatch_queue_create("laosun", NULL), ^{
    
    //3.发送Get请求
    [[self shareInstance] GET:url
  parameters :parama
     success :^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
         
         if (success) {
             success(responseObject);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         if (failure) {
             
             UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"系统温馨提示" message:nil delegate:nil cancelButtonTitle:@"请查看网络连接!" otherButtonTitles:nil];
             [alert show];
         }
     }];

   });
}

#pragma mark POST
+ (void)post:(NSString*)url
     params :(NSDictionary*)params
    succese :(void(^)(id responseObj))succeaa
    failure :(void(^)(NSString*error))failure;
{
    dispatch_async(dispatch_queue_create("post", NULL), ^{
       // 发送post请求
        
        [[self shareInstance]POST :url
                       parameters :params
                          success :^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
            if (succeaa) {
                succeaa(responseObject);
                
            }
        } failure :^(AFHTTPRequestOperation *operation, NSError *error) {
            
            if (failure) {
                DLog(@"%@",error);
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"系统温馨提示" message:nil delegate:nil cancelButtonTitle:@"请查看网络连接!" otherButtonTitles:nil];
                [alert show];
            }
        }];
        
    });
}
/**
 *  万能九宫格
 *
 *  @param backView 九宫格要显示的底层view
 *  @param view     要显示的view
 *  @param number   要显示的view 的个数
 *  @param eColum   期望显示的view 分几列
 *
 *  @return 返回的是view 的坐标数组
 */
+(NSMutableArray *)jiuGongGeWithBackGroundView:(UIView *)backView  view:(UIView *)view numberOfViews:(int)number exceptColum:(int)eColum{
    
    int eRow = 0;//根据，number和期望列数，算出期望行数
    if (number % eColum ==0) {
        
        eRow = number/eColum;
    }else
    {
        eRow = number /eColum+1;
    }
    //    NSLog(@"---------->>%d",eRow);
    /*--------------------------------*/
    //背景的大小
    float Bwidth = backView.frame.size.width;
    float Bheight = backView.frame.size.height;
    
    //要显示的view 的大小
    float width = view.frame.size.width;
    float height = view.frame.size.height;
    
    //行高，列宽
    float columWidth = (Bwidth - width * eColum) / (eColum +1);
    float rowHeight = (Bheight - height *  eRow) / (eRow + 1);
    
    
    NSMutableArray  *CGRectArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i<number; i++) {
        //view在九宫格中的行数，列数
        int row = i/ eColum;
        int colum = i % eColum;
        float x = (width +columWidth) * colum + columWidth;
        float y = (height + rowHeight) * row + rowHeight;
        
        
        UIView  *view1 = [[UIView alloc] init];
        view1.frame= CGRectMake(x+backView.frame.origin.x, y+backView.frame.origin.y, width, height);
        
        
//        NSLog(@",,,,,,,,,%f,%f",view1.frame.origin.x,view1.frame.origin.y);
        
        [CGRectArray addObject:view1];
    }
    
    return  CGRectArray;
    
}


@end
