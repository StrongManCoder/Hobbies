//
//  GTWRecognizerView.m
//  GTW
//
//  Created by bjfxtx on 15/3/13.
//  Copyright (c) 2015年 xcode. All rights reserved.
//

#import "GTWRecognizerView.h"

#import "iflyMSC/IFlySpeechRecognizerDelegate.h"
#import "iflyMSC/IFlySpeechRecognizer.h"
#import "ISRDataHelper.h"
@interface GTWRecognizerView ()<IFlySpeechRecognizerDelegate>
{
    
    //语音识别
    IFlySpeechRecognizer *_iflySpeechRecognizer;
    
    
    
    UIView *_voiceView;    //识别控件背景View
    UILabel *_voiceTitleLabel; //title
    UIImageView *_voiceImageView; //图像动画
    UIImageView *_lineImageView; //黄色横线
    UIImageView *_verticalView;//竖线
    
    UIButton *_cancelBtn; //取消
    UIButton *_finishBtn; //完毕
    
}

@end


@implementation GTWRecognizerView


-(id)initWithDelegate:(id)delegate
{
    self = [super init];
    
    if (self) {
        
        self.delegate = delegate;
        self.frame = [UIScreen mainScreen].bounds;
        [self layoutUI];
    }
    
    return self;
}

-(void)layoutUI
{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kPLScreenWidth, kPLScreenHeight)];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.3;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgTapClick:)];
    [bgView addGestureRecognizer:tap];
    [self addSubview:bgView];
    
    
    _voiceView = [[UIView alloc]initWithFrame:CGRectMake(41, 100, kPLScreenWidth-82, 187)];
    _voiceView.layer.cornerRadius = 5;
    _voiceView.layer.masksToBounds = YES;
    _voiceView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_voiceView];
    
    _voiceTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 17, kFrame_Width(_voiceView), 14)];
    _voiceTitleLabel.text = @"请您开始说话";
    _voiceTitleLabel.textColor =UIColorFromRGB(0x1f1f1f);
    _voiceTitleLabel.font = [UIFont systemFontOfSize:14.f];
    _voiceTitleLabel.textAlignment = NSTextAlignmentCenter;
    [_voiceView addSubview:_voiceTitleLabel];
    
    _voiceImageView = [[UIImageView alloc]init];
    NSArray *images =@[@"hy_meeting_volume_level_0",@"hy_meeting_volume_level_1",@"hy_meeting_volume_level_2",@"hy_meeting_volume_level_3"];
    
    NSMutableArray *imageArray = [NSMutableArray array];
    for (NSInteger i = 0; i < images.count; i ++)
    {
        UIImage *image = [UIImage imageNamed:images[i]];
        [imageArray addObject:image];
    }
    _voiceImageView.frame = CGRectMake((kFrame_Width(_voiceView)-145)/2, kFrame_YHeight(_voiceTitleLabel)+24, 145, 65);
    _voiceImageView.animationImages = imageArray;
    _voiceImageView.animationDuration = 1.5f;
    _voiceImageView.animationRepeatCount = 0;
    [_voiceView addSubview:_voiceImageView];
    [_voiceImageView startAnimating];
    
    _lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, kFrame_YHeight(_voiceImageView)+49/2, kFrame_Width(_voiceView), 1)];
    _lineImageView.backgroundColor = UIColorFromRGB(0xe3e3e3);
    [_voiceView addSubview:_lineImageView];
    
    _verticalView = [[UIImageView alloc]initWithFrame:CGRectMake(kFrame_Width(_voiceView)/2, kFrame_YHeight(_voiceImageView)+49/2, 1, 44)];
    _verticalView.backgroundColor = UIColorFromRGB(0xe3e3e3);
    [_voiceView addSubview:_verticalView];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.frame = CGRectMake(0, kFrame_YHeight(_lineImageView), kFrame_Width(_voiceView)/2, 44);
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:UIColorFromRGB(0x1f1f1f) forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [_cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_voiceView addSubview:_cancelBtn];
    
    _finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _finishBtn.frame = CGRectMake(kFrame_Width(_voiceView)/2,kFrame_YHeight(_lineImageView) , kFrame_Width(_voiceView)/2, 44);
    [_finishBtn setTitle:@"完毕" forState:UIControlStateNormal];
    _finishBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [_finishBtn setTitleColor:UIColorFromRGB(0x1f1f1f) forState:UIControlStateNormal];
    [_finishBtn addTarget:self action:@selector(finishBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_voiceView addSubview:_finishBtn];
    
    //语音实例对象

    _iflySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
    _iflySpeechRecognizer.delegate = self;
    [_iflySpeechRecognizer setParameter:@"doman" forKey:@"iat"];
    [_iflySpeechRecognizer setParameter:@"asr_sch" forKey:@"1"];
//    [_iflySpeechRecognizer setParameter:@"" forKey:<#(NSString *)#>];
    
//    [_iflySpeechRecognizer setParameter:@"domain" value:@"iat"];
//    [_iflySpeechRecognizer setParameter:@"asr_sch" value:@"1"];
//    [_iflySpeechRecognizer setParameter:@"plain_result" value:@"1"];
//    [_iflySpeechRecognizer setParameter:@"params" value:@"rst=json,nlp_version=2.0"];
    [_iflySpeechRecognizer startListening];
    
    

}

#pragma mark - IFlySpeechRecognizerDelegate

- (void) onResults:(NSArray *) results isLast:(BOOL)isLast;
{
    
    NSMutableString *result = [[NSMutableString alloc] init];
    NSDictionary *dic = [results objectAtIndex:0];
    for (NSString *key in dic)
    {
        [result appendFormat:@"%@",key];//合并结果
    }
    NSString * resultFromJson =  [[ISRDataHelper shareInstance] getResultFromJson:result];
    
    
    DLog(@"%@",resultFromJson);
    
    if ([self.delegate respondsToSelector:@selector(getRecognizerViewtext::)])
    {
        [self.delegate getRecognizerViewtext:self :resultFromJson];
    }
    
}
- (void) onError:(IFlySpeechError *) errorCode;
{
    
    DLog(@"%@",errorCode);
    
}
-(void)cancelBtnClick:(UIButton *)cancelBtn
{
    [self stopAndCancel];
    if ([self.delegate respondsToSelector:@selector(cancelBtnClick:)])
    {
        [self.delegate cancelBtnClick:self];
    }
}

-(void)finishBtnClick:(UIButton *)finishBtn
{
    [self stopAndCancel];
    if ([self.delegate respondsToSelector:@selector(finishBtnClick:)])
    {
        [self.delegate finishBtnClick:self];
    }
}
-(void)stopAndCancel
{
    [_iflySpeechRecognizer stopListening];
    [_voiceImageView stopAnimating];
    [_iflySpeechRecognizer cancel];

    
}
-(void)bgTapClick:(UITapGestureRecognizer *)tap
{
    
    if ([self.delegate respondsToSelector:@selector(backgroundViewActionClick:)]) {
        
        [self.delegate backgroundViewActionClick:self];
        }
    
}

@end
