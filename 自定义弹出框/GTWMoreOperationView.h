//
//  GTWMoreOperationView.h
//  GTW
//
//  Created by apple on 15/2/27.
//  Copyright (c) 2015年 xcode. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GTWMoreOperationView;
@protocol GTWMoreOperationViewDelegate <NSObject>
@optional
-(void)backgroundViewTapClick;

-(void)moreOperationView:(GTWMoreOperationView *)moreOperationView ClickBtnAtIndex:(NSInteger)index;

@end

@interface GTWMoreOperationView : UIView

@property(nonatomic,weak) id <GTWMoreOperationViewDelegate> delegate;
@property(nonatomic,readonly) NSString * text;

-(id)initWithDelegate:(id)delegate BtnTitles:(NSArray *)titles;
-(id)initWithDelegate:(id)delegate TelTypes:(NSArray *)types Numbers:(NSArray *)numbers;

-(id)initWithDelegate:(id)delegate Title:(NSString *)title Placeholder:(NSString *)placeholder;

@end
