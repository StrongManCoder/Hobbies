//
//  GTWMoreOperationView.m
//  GTW
//
//  Created by apple on 15/2/27.
//  Copyright (c) 2015年 xcode. All rights reserved.
//

#import "GTWMoreOperationView.h"
#import "PLDefine.h"
#define GTWMoreOperationViewBtnTag 1000
@interface GTWMoreOperationView ()<UITextFieldDelegate>
{
    NSArray     * _titles;
    NSArray     * _telTypes;
    NSArray     * _numbers;
    NSInteger     _btnCount;
    NSInteger     _initType;
    
    NSString    * _title;
    NSString    * _placeholder;
    UITextField * _textField;
}
@end

@implementation GTWMoreOperationView

-(id)initWithDelegate:(id)delegate BtnTitles:(NSArray *)titles
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        _initType = 1;
        _titles = titles;
        _btnCount = titles.count;
        self.frame = [UIScreen mainScreen].bounds;
        if (_btnCount > 0) {
            [self layoutUI];
        }
    }
    return self;
}

-(id)initWithDelegate:(id)delegate TelTypes:(NSArray *)types Numbers:(NSArray *)numbers
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        _initType = 2;
        _telTypes = types;
        _numbers = numbers;
        _btnCount = numbers.count + 1;
        self.frame = [UIScreen mainScreen].bounds;
        if (_btnCount > 0) {
            [self layoutUI];
        }
    }
    return self;
}

-(id)initWithDelegate:(id)delegate Title:(NSString *)title Placeholder:(NSString *)placeholder
{
    if (self = [super init]) {
        self.delegate = delegate;
        _title = title;
        _placeholder = placeholder;
        self.frame = [UIScreen mainScreen].bounds;
        [self addBackgroundView];
        [self addAlertView];
    }
    return self;
}

-(void)layoutUI
{
    [self addBackgroundView];
    [self addButtons];
}

-(void)addBackgroundView
{
    UIControl * control = [[UIControl alloc] initWithFrame:self.bounds];
    control.backgroundColor = kBlackColor;
    control.alpha = 0.4;
    [self addSubview:control];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [control addGestureRecognizer:tap];
}

-(void)addButtons
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(41, 200 - 64, kPLScreenWidth - 82, _btnCount * 44)];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 3;
    view.backgroundColor = kWhiteColor;
    [self addSubview:view];
    
    for (NSInteger i = 0; i < _btnCount; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0 + i * 44, view.bounds.size.width, 44);
        btn.tag = GTWMoreOperationViewBtnTag + i;
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:UIColorFromRGB(0x1f1f1f) forState:UIControlStateNormal];
        if (_initType == 1) {
            [btn setTitle:_titles[i] forState:UIControlStateNormal];
        }
        if (_initType == 2) {
            if (_btnCount == 1) {
                [btn setTitle:@"联系电话空缺" forState:UIControlStateNormal];
                btn.userInteractionEnabled = NO;
            }else{
                if (i == 0) {
                    [btn setTitle:@"请选择电话" forState:UIControlStateNormal];
                    btn.userInteractionEnabled = NO;
                }else{
                    for (NSInteger j = 0; j < 2; j++) {
                        CGRect frame1 = CGRectMake(20, i * 44, 70, 44);
                        CGRect frame2 = CGRectMake(96, i * 44, view.bounds.size.width - 90 - 20, 44);
                        UILabel * lab = [[UILabel alloc] initWithFrame:(j?frame2:frame1)];
                        lab.font = [UIFont systemFontOfSize:15];
                        lab.adjustsFontSizeToFitWidth = YES;
                        lab.textColor = (j?UIColorFromRGB(0x3996fd):UIColorFromRGB(0x808080));
                        lab.textAlignment = (j?NSTextAlignmentCenter:NSTextAlignmentLeft);
                        lab.text = (j?_numbers[i - 1]:_telTypes[i - 1]);
                        [view addSubview:lab];
                    }
                }
            }
        }
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        if (i + 1 < _btnCount) {
            UIView * line = [[UIView alloc] initWithFrame:CGRectMake(10, 43 + i * 44, view.bounds.size.width - 20, 1)];
            line.backgroundColor = UIColorFromRGB(0xe3e3e3);
            [view addSubview:line];
        }
    }
}

-(void)addAlertView
{
    UIImageView * bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(41, 200, kPLScreenWidth - 82, 126)];
    bgImgView.image = [PLTool StretchImageWithName:@"popbox_bg.png" LeftCapWidth:246 TopCapHeight:2];
    bgImgView.userInteractionEnabled = YES;
    bgImgView.layer.masksToBounds = YES;
    bgImgView.layer.cornerRadius = 4;
    [self addSubview:bgImgView];
    
    UILabel * titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, kFrame_Width(bgImgView), 15)];
    titleLab.font = [UIFont systemFontOfSize:14.f];
    titleLab.textColor = UIColorFromRGB(0x1f1f1f);
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text = _title;
    [bgImgView addSubview:titleLab];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(16, kFrame_YHeight(titleLab) + 15, kFrame_Width(bgImgView) - 32, 30)];
    _textField.placeholder = _placeholder;
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.textColor = UIColorFromRGB(0x1f1f1f);
    _textField.font = [UIFont systemFontOfSize:13.f];
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.delegate = self;
    [_textField addTarget:self action:@selector(textFieldTextValueChanged:) forControlEvents:UIControlEventEditingChanged];
    [bgImgView addSubview:_textField];
    
    for (NSInteger i = 0; i < 2; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * kFrame_Width(bgImgView) / 2, kFrame_Height(bgImgView) - 39, kFrame_Width(bgImgView) / 2, 39);
        [btn setTitle:(i?@"确定":@"取消") forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = GTWMoreOperationViewBtnTag + i;
        btn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [btn setTitleColor:UIColorFromRGB(0x1f1f1f) forState:UIControlStateNormal];
        [bgImgView addSubview:btn];
    }
}

-(void)btnClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(moreOperationView:ClickBtnAtIndex:)]) {
        [self.delegate moreOperationView:self ClickBtnAtIndex:btn.tag - GTWMoreOperationViewBtnTag];
    }
}

-(void)tapClick:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(backgroundViewTapClick)]) {
        [self.delegate backgroundViewTapClick];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldTextValueChanged:(UITextField *)textField
{
    NSInteger _wordCount;
    UITextRange * selectedRange = [textField markedTextRange];
    NSString * newText = [textField textInRange:selectedRange];
    if (newText) {
        _wordCount = 20 - ([PLTool StringConvertStandardCharToInt:textField.text] - [PLTool StringConvertStandardCharToInt:newText]);
    }else{
        _wordCount = 20 - [PLTool StringConvertStandardCharToInt:textField.text];
    }
    if (_wordCount < 0) {
        NSInteger chineseWordCount = [PLTool StringContainsChineseWordCount:textField.text];
        textField.text = [textField.text substringToIndex:20/2 + (textField.text.length - chineseWordCount)/2];
        _wordCount = 0;
        AlertShow(@"文本输入已达到上限");
    }
}

-(NSString *)text
{
    if (_textField) {
        return _textField.text;
    }
    return @"";
}

@end
