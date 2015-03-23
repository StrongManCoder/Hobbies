//
//  GTWRecognizerView.h
//  GTW
//
//  Created by bjfxtx on 15/3/13.
//  Copyright (c) 2015年 xcode. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GTWRecognizerView;
@protocol GTWRecognizerViewDelegate <NSObject>

-(void)backgroundViewActionClick:(GTWRecognizerView *)recognizerView;

-(void)cancelBtnClick:(GTWRecognizerView *)recognizerView;

- (void)finishBtnClick:(GTWRecognizerView *)recognizerView;

//获取语音转换后的文字
-(void)getRecognizerViewtext:(GTWRecognizerView *)recognizerView :(NSString *)textString;



@end



@interface GTWRecognizerView : UIView

@property(nonatomic,weak)id<GTWRecognizerViewDelegate>delegate;





-(id)initWithDelegate:(id)delegate;

@end
