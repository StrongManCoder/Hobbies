//
//  GTWDemanReportView.h
//  GTW
//
//  Created by bjfxtx on 15/3/5.
//  Copyright (c) 2015年 xcode. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GTWDemanReportView;
@protocol GTWDemanReportDelegate <NSObject>

-(void)GTWDemanReportView:(GTWDemanReportView*)reportView TitileDic:(NSMutableDictionary *)titleDic;


@end
@interface GTWDemanReportView : UIView

@property (nonatomic,weak)id <GTWDemanReportDelegate>delegate;


/**
 *  初始化多个按钮 不同title的举报  最后一个是其他 高度任意值
 *
 *  @param delegate <#delegate description#>
 *  @param frame    View的高度设为0 高度根据个数计算
 *  @param titleArr title 数组
 *
 *  @return <#return value description#>
 */
-(id)initWithDelegate:(id)delegate Frame:(CGRect)frame BtnTitleArr:(NSArray *)titleArr;


@end
