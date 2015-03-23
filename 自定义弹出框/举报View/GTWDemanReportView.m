//
//  GTWDemanReportView.m
//  GTW
//
//  Created by bjfxtx on 15/3/5.
//  Copyright (c) 2015年 xcode. All rights reserved.
//

#import "GTWDemanReportView.h"
#import "PLDefine.h"

//距离最前面和最后面距离
#define kSpaceWith 30/2
//按钮间隔
#define kSpaceLnterval 40/2

#define BtnHeight 58/2

#define kUpDownSpace 20/2

#define kViewWith self.frame.size.width

@interface GTWDemanReportView ()
{
    NSArray *_titleArr;
    NSInteger _rowNumber;
    NSMutableDictionary *_numberDic;
    NSInteger _titleCount;
    NSMutableArray *_buttonArray;
    
}
@end



@implementation GTWDemanReportView


-(id)initWithDelegate:(id)delegate Frame:(CGRect)frame BtnTitleArr:(NSArray *)titleArr
{
    self = [super init];
    if (self)
    {
        self.delegate = delegate;
        _titleArr = titleArr;
        _titleCount = titleArr.count +1;
        _rowNumber = (titleArr.count+1)/2+(titleArr.count+1)%2;
        _numberDic = [NSMutableDictionary dictionary];
        _buttonArray = [NSMutableArray array];
        CGFloat rowHeight =(_rowNumber+1)*kUpDownSpace+_rowNumber*BtnHeight;
        self.backgroundColor = [UIColor whiteColor];
        CGRect newFrame;
        newFrame.origin.x = frame.origin.x;
        newFrame.origin.y = frame.origin.y;
        newFrame.size.width = frame.size.width;
        newFrame.size.height = rowHeight;
        self.frame = newFrame;
        
        //                CGRectMake(0, 0, kPLScreenWidth, (_rowNumber+1)*kUpDownSpace+_rowNumber*BtnHeight);
    }
    [self layoutUI];
    return self;
}

-(void)layoutUI
{
    for (int i = 0; i < _titleCount; i ++)
    {
        UIImage *noChooseImg=[UIImage imageNamed:@"reportlabel_default_bg"];
        noChooseImg=[noChooseImg stretchableImageWithLeftCapWidth:5 topCapHeight:5];
        
        UIImage *chooseImg = [UIImage imageNamed:@"reportlabel_activated_bg"];
        chooseImg=[chooseImg stretchableImageWithLeftCapWidth:5 topCapHeight:5];
        
        int BtnWith =(kViewWith-kSpaceWith*2-kSpaceLnterval)/2;
        UIButton *keywordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        keywordBtn.frame = CGRectMake(kSpaceWith+i%2*(BtnWith+kSpaceLnterval), kUpDownSpace+i/2*(BtnHeight+kUpDownSpace), BtnWith, BtnHeight);
        if (i == _titleCount-1)
        {
         [keywordBtn setTitle:@"其他" forState:UIControlStateNormal];
        }else
        {
            [keywordBtn setTitle:[_titleArr objectAtIndex:i]  forState:UIControlStateNormal];
            [_buttonArray addObject:keywordBtn];
        }
        
        [keywordBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [keywordBtn setBackgroundImage:noChooseImg forState:UIControlStateNormal];
        [keywordBtn setBackgroundImage:chooseImg forState:UIControlStateSelected];
        keywordBtn.titleLabel.font = [UIFont systemFontOfSize:13.f];
        keywordBtn.tag = 1000+i;
        [keywordBtn addTarget:self action:@selector(keywordBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:keywordBtn];
    }
}

#pragma mark - 举报类型按钮
-(void)keywordBtnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    NSInteger indexNum = sender.tag - 1000;
    if (indexNum != _titleCount-1)
    {
        NSString *titleString = [_titleArr objectAtIndex:indexNum];
        if ([_numberDic valueForKey:[NSString stringWithFormat:@"%d",indexNum]]) {
            [_numberDic removeObjectForKey:[NSString stringWithFormat:@"%d",indexNum]];
        }else
        {
           [_numberDic setValue:titleString forKey:[NSString stringWithFormat:@"%d",indexNum]];
        }
        
        [_numberDic removeObjectForKey:[NSString stringWithFormat:@"%d",_titleCount-1]];
        UIButton *aloneBtn = (UIButton *)[self viewWithTag:_titleCount-1+1000];
        aloneBtn.selected = NO;

    }else   //"其他"按钮
    {
        NSString *titleString = @"其他";
        for (UIButton *btn in _buttonArray) {
            if (btn.tag >=  1000 && btn .tag < 1000+_titleCount-1 )
            {
                btn.selected = NO;
            }
            [_numberDic removeAllObjects];
            
            UIButton *aloneBtn = (UIButton *)[self viewWithTag:_titleCount-1+1000];
            if (aloneBtn.selected)
            {
                [_numberDic setValue:titleString forKey:[NSString stringWithFormat:@"%d",indexNum]];
            }else
            {
                [_numberDic removeObjectForKey:[NSString stringWithFormat:@"%d",indexNum]];
            }
            
            
//            if ([_numberDic valueForKey:[NSString stringWithFormat:@"%d",indexNum]]) {
//                [_numberDic removeObjectForKey:[NSString stringWithFormat:@"%d",indexNum]];
//            }else
//            {
//                [_numberDic setValue:titleString forKey:[NSString stringWithFormat:@"%d",indexNum]];
//            }
        }
    }
    if ([self.delegate respondsToSelector:@selector(GTWDemanReportView:TitileDic:)])
    {
        [self.delegate GTWDemanReportView:self TitileDic:_numberDic];
    }

}

@end
