/**
 *  Created by 闫鹏 on 15/1/1.
 *
 *  Copyright (c) 2015年 P.L.Technology. All rights reserved.
 *
 *  QQ  :724198635
 *  Mail:top_yp@126.com
 */


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    PLByte = 0,
    PLKB,
    PLMB,
    PLGB,
    PLTB,
} PLByteUnit;

@interface PLTool : NSObject

/**
 *  重写属性的getter方法，避免使用空值
 *
 *  @param propety 需要被重写的属性
 *
 *  @return 重写后的属性
 */
+(id)RewritePropertyGetterMethods:(id)propety;

/**
 *  拼接字符串
 *
 *  @param strings 需要拼接的字符串数组
 *
 *  @return 拼接完成的字符串
 */
+(NSString *)AppendString:(NSArray *)strings;

/**
 *  拼接网络请求参数字符串
 *
 *  @param parDic 参数字典
 *
 *  @return 拼接完成的字符串
 */
+(NSString *)AppendStringForNetRequest:(NSDictionary *)parDic;

/**
 *  日期转换
 *  @param date      需要被转换的日期
 *  @param formatter 需要转换成的日期格式
 *
 *  @return 按照特定日期格式转换的字符串
 */
+(NSString *)DateTansform:(NSDate *)date Formatter:(NSString *)formatter;

/**
 *  屏蔽特殊字符：只允许汉字、字母、数字
 *
 *  @param string 需要被屏蔽的字符串
 *
 *  @return 屏蔽完的字符串
 */
+(NSString *)ScreenSpecialChar:(NSString *)string;

/**
 *  标准字符串长度计算
 *  @param string      需要计算长度的字符串
 *
 *  @return 字符串长度
 */
+(NSInteger)StringConvertStandardCharToInt:(NSString *)string;

/**
 *  汉字字符串长度计算
 *  @param string      需要计算长度的字符串
 *
 *  @return 字符串长度
 */
+(NSInteger)StringConvertChineseWordToInt:(NSString *)string;

/**
 *  字符串中包含多少个汉字
 *
 *  @param string 需要计算的字符串
 *
 *  @return 字符串中包含汉字的个数
 */
+(NSInteger)StringContainsChineseWordCount:(NSString *)string;

/**
 *  属性字符串：改变特定范围内字符串的字体颜色(单次改变)
 *
 *  @param string 需要改变颜色的字符串
 *  @param range  需要改变颜色的字符串范围
 *  @param color  需要改变成的颜色
 *
 *  @return 改变颜色后的属性字符串
 */
+(NSAttributedString *)AttStringTransform:(NSString *)string Range:(NSRange)range Color:(UIColor *)color;

/**
 *  属性字符串：改变特定范围内字符串的字体颜色(多次改变)
 *
 *  @param string  需要改变颜色的字符串
 *  @param ranges  需要改变颜色的字符串范围数组
 *  @param colors  需要改变成的颜色数组
 *
 *  @return 改变颜色后的属性字符串
 */
+(NSAttributedString *)AttStringTransform:(NSString *)string Ranges:(NSArray *)ranges Colors:(NSArray *)colors;

/**
 *  属性字符串：改变文本字符串的行间距(整个文本字符串)
 *
 *  @param string 需要改变行间距的文本字符串
 *  @param space  需要改成的行间距
 *
 *  @return 改变行间距后的属性字符串
 */
+(NSAttributedString *)AttStringTransform:(NSString *)string LineSpace:(CGFloat)space;

/**
 *  属性字符串：改变文本字符串的字体(单次更改)
 *
 *  @param string 需要改变字体的字符串
 *  @param range  需要改变字体的字符串范围
 *  @param font   需要改变成的字体
 *
 *  @return 改变字体后的属性字符串
 */
+(NSAttributedString *)AttStringTransform:(NSString *)string Range:(NSRange)range Font:(UIFont *)font;
/**
 *  属性字符串：改变文本字符串的字体(多次更改)
 *
 *  @param string 需要改变字体的字符串
 *  @param ranges 需要改变字体的字符串范围数组
 *  @param fonts  需要改变的字体数组
 *
 *  @return 改变字体后的属性字符串
 */
+(NSAttributedString *)AttStringTransform:(NSString *)string Ranges:(NSArray *)ranges Fonts:(NSArray *)fonts;

/**
 *  获取文本字符串的大小(兼容ios7及以下版本)
 *
 *  @param string   需要获取大小的文本字符串
 *  @param size     目标控件的最大空间
 *  @param name     文本字符串的字体名称，设置为nil则为系统默认字体
 *  @param fontSize 文本字符串的字体大小
 *  @param mode     文本字符串换行模式
 *
 *  @return 文本字符串的大小
 */
+(CGSize)ContentSize:(NSString *)string MaxSize:(CGSize)size FontName:(NSString *)name FontSize:(CGFloat)fontSize LineBreakMode:(NSLineBreakMode)mode;

/**
 *  获取单个文件的大小
 *
 *  @param filePath 目标文件路径
 *
 *  @return 目标文件的大小(字节数)
 */
+(NSUInteger)FileSizeAtPath:(NSString*)filePath;

/**
 *  获取单个文件夹总文件大小(非嵌套文件夹)
 *
 *  @param folderPath 目标文件夹路径
 *  @param unit       返回值单位
 *
 *  @return 按特定单位返回目标文件夹总文件的大小
 */
+(CGFloat)FolderSizeAtPath:(NSString*)folderPath Unit:(PLByteUnit)unit;

/**
 *  图片去除方向性
 *
 *  @param aImage 需要去除方向性的图片
 *
 *  @return 已被去除方向性的图片
 */
+(UIImage *)FixOrientation:(UIImage *)image;

/**
 *  重绘图片
 *
 *  @param image 需要重绘的原图片
 *  @param size  需要重绘的尺寸
 *
 *  @return 按照设定的重绘尺寸返回的新图片
 */
+(UIImage *)ReDrawImage:(UIImage *)image Size:(CGSize)size;

/**
 *  图片拉伸
 *
 *  @param name         图片名称
 *  @param leftCapWidth 左侧像素位置
 *  @param topCapHeight 上方像素位置
 *
 *  @return 按照拉伸要求返回的新图片
 */
+(UIImage *)StretchImageWithName:(NSString *)name LeftCapWidth:(NSInteger)leftCapWidth TopCapHeight:(NSInteger)topCapHeight;
/**
 *  拨打电话
 *
 *  @param number 电话号码
 */
+(void)callNumber:(NSString *)number;

@end
