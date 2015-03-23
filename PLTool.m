/**
 *  Created by 闫鹏 on 15/1/1.
 *
 *  Copyright (c) 2015年 P.L.Technology. All rights reserved.
 *
 *  QQ  :724198635
 *  Mail:top_yp@126.com
 */

#import "PLTool.h"

#define kPLIOS7 ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)

@implementation PLTool
/**
 *  重写属性的getter方法，避免使用空值
 */
+(id)RewritePropertyGetterMethods:(id)propety
{
    DLog(@"%@",[propety class]);
    if ([propety isEqual:[NSNull null]] && !propety) {
        if ([[propety class] isSubclassOfClass:[NSString class]]) {
            return @"";
        }
        if ([[propety class] isSubclassOfClass:[NSArray class]]) {
            return [NSArray array];
        }
        if ([[propety class] isSubclassOfClass:[NSDictionary class]]) {
            return [NSDictionary dictionary];
        }
        return [[propety class] new];
    }
    return propety;
}

/**
 *  拼接字符串
 */
+(NSString *)AppendString:(NSArray *)strings
{
    if (strings.count > 0) {
        NSString * appendString = @"";
        for (NSString * string in strings) {
            appendString = [appendString stringByAppendingString:string];
        }
        return appendString;
    }
    NSLog(@"数组为空");
    return nil;
}

/**
 *  拼接网络请求参数字符串
 */
+(NSString *)AppendStringForNetRequest:(NSDictionary *)parDic
{
    if (parDic) {
        NSString * bodyStr = @"";
        NSArray * parDicAllKeys = [parDic allKeys];
        for (NSString * key in parDicAllKeys) {
            if (parDicAllKeys.count > 1) {
                if (![key isEqual:[parDicAllKeys lastObject]]) {
                    bodyStr = [NSString stringWithFormat:@"%@%@=%@&",bodyStr,key,parDic[key]];
                }else {
                    bodyStr = [NSString stringWithFormat:@"%@%@=%@",bodyStr,key,parDic[key]];
                }
            }else if (parDicAllKeys.count == 1) {
                bodyStr = [NSString stringWithFormat:@"%@&%@=%@",bodyStr,key,parDic[key]];
            }
        }
        return bodyStr;
    }
    return nil;
}

/**
 *  日期转换
 */
+(NSString *)DateTansform:(NSDate *)date Formatter:(NSString *)formatter
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = formatter;
    NSString *dateStr = [format stringFromDate:date];
    return dateStr;
}

/**
 *  屏蔽特殊字符：只允许汉字、字母、数字
 */
+(NSString *)ScreenSpecialChar:(NSString *)string
{
    NSString *result = @"";
    for (NSInteger i = 0; i < string.length; i++) {
        NSString * s = [string substringWithRange:NSMakeRange(i, 1)];
        const char * ch=[s UTF8String];
        if ((*ch >= '0' && *ch <= '9' ) || strlen(ch) > 1 || (*ch >= 'A' && *ch <= 'Z') || (*ch >= 'a' && *ch <= 'z')) {
            result = [result stringByAppendingString:s];
        }
    }
    return result;
}

/**
 *  标准字符串长度计算
 */
+(NSInteger)StringConvertStandardCharToInt:(NSString *)string
{
    NSInteger strlength = 0;
    char * p = (char *)[string cStringUsingEncoding:NSUnicodeStringEncoding];
    for (NSInteger i = 0 ;i<[string lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
        if (* p) {
            p++;
            strlength++;
        }else{
            p++;
        }
    }
    return strlength;
}
/**
 *  汉字字符串长度计算
 */
+(NSInteger)StringConvertChineseWordToInt:(NSString *)string
{
    return ([PLTool StringConvertStandardCharToInt:string] + 1)/2;
}
/**
 *  字符串中包含多少个汉字
 */
+(NSInteger)StringContainsChineseWordCount:(NSString *)string
{
    NSInteger chineseWordCount = 0;
    for (NSInteger i = 0; i < string.length; i++) {
        NSRange range = NSMakeRange(i,1);
        NSString * subString = [string substringWithRange:range];
        const char * cString = [subString UTF8String];
        if (strlen(cString) > 1) {
            chineseWordCount++;
        }
    }
    return chineseWordCount;
}

/**
 *  属性字符串：改变特定范围内字符串的字体颜色(单次改变)
 */
+(NSAttributedString *)AttStringTransform:(NSString *)string Range:(NSRange)range Color:(UIColor *)color
{
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:string];
    if (attStr) {
        [attStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    return attStr;
}

/**
 *  属性字符串：改变特定范围内字符串的字体颜色(多次改变)
 */
+(NSAttributedString *)AttStringTransform:(NSString *)string Ranges:(NSArray *)ranges Colors:(NSArray *)colors
{
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:string];
    if (attStr) {
        for (NSInteger i = 0; i < ranges.count; i++) {
            NSRange range = [ranges[i] rangeValue];
            [attStr addAttribute:NSForegroundColorAttributeName value:colors[i] range:range];
        }
    }
    return attStr;
}

/**
 *  属性字符串：改变文本字符串的行间距(整个文本字符串)
 */
+(NSAttributedString *)AttStringTransform:(NSString *)string LineSpace:(CGFloat)space
{
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:string];
    if (attStr) {
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:space];
        [attStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
    }
    return attStr;
}

/**
 *  属性字符串：改变文本字符串的字体(单次改变)
 */
+(NSAttributedString *)AttStringTransform:(NSString *)string Range:(NSRange)range Font:(UIFont *)font
{
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:string];
    if (attStr) {
        [attStr addAttribute:NSFontAttributeName value:font range:range];
    }
    return attStr;
}

/**
 *  属性字符串：改变文本字符串的字体(多次改变)
 */
+(NSAttributedString *)AttStringTransform:(NSString *)string Ranges:(NSArray *)ranges Fonts:(NSArray *)fonts
{
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:string];
    if (attStr) {
        for (NSInteger i = 0; i < ranges.count; i++) {
            NSRange range = [ranges[i] rangeValue];
            [attStr addAttribute:NSFontAttributeName value:fonts[i] range:range];
        }
    }
    return attStr;
}

/**
 *  获取文本字符串的大小
 */
+(CGSize)ContentSize:(NSString *)string MaxSize:(CGSize)size FontName:(NSString *)name FontSize:(CGFloat)fontSize LineBreakMode:(NSLineBreakMode)mode
{
    UIFont *contentFont;
    if (name) {
        contentFont = [UIFont fontWithName:name size:fontSize];
    }else{
        contentFont = [UIFont systemFontOfSize:fontSize];
    }
    CGSize actualsize;
    NSDictionary *contentDic = @{NSFontAttributeName:contentFont};
    
    if (kPLIOS7) {
        actualsize = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:contentDic context:nil].size;
    } else {
        actualsize = [string sizeWithFont:contentFont constrainedToSize:size lineBreakMode:mode];
    }
    return actualsize;
}
/**
 *  获取单个文件的大小
 */
+(NSUInteger)FileSizeAtPath:(NSString*)filePath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

/**
 *  获取单个文件夹总文件大小(非嵌套文件夹)
 */
+(CGFloat)FolderSizeAtPath:(NSString*)folderPath Unit:(PLByteUnit)unit
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [PLTool FileSizeAtPath:fileAbsolutePath];
    }
    CGFloat byteUnit;
    switch (unit) {
        case PLByte:
            byteUnit = 1.f;
            break;
        case PLKB:
            byteUnit = 1.f * 1024.f;
            break;
        case PLMB:
            byteUnit = 1.f * 1024.f * 1024.f;
            break;
        case PLGB:
            byteUnit = 1.f * 1024.f * 1024.f * 1024.f;
            break;
        case PLTB:
            byteUnit = 1.f * 1024.f * 1024.f * 1024.f * 1024.f;
            break;
        default:
            break;
    }
    return folderSize/byteUnit;
}
/**
 *  图片去除方向性
 */
+(UIImage *)FixOrientation:(UIImage *)image
{
    if (image.imageOrientation == UIImageOrientationUp)
        return image;
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (image.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, image.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, image.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (image.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, image.size.width, image.size.height,
                                             CGImageGetBitsPerComponent(image.CGImage), 0,
                                             CGImageGetColorSpace(image.CGImage),
                                             CGImageGetBitmapInfo(image.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (image.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.height,image.size.width), image.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.width,image.size.height), image.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
/**
 *  重绘图片
 */
+(UIImage *)ReDrawImage:(UIImage *)image Size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0,size.width,size.height)];
    UIImage* reDrawImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reDrawImg;
}
/**
 *  图片拉伸
 */
+(UIImage *)StretchImageWithName:(NSString *)name LeftCapWidth:(NSInteger)leftCapWidth TopCapHeight:(NSInteger)topCapHeight
{
    UIImage * image = [UIImage imageNamed:name];
    image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    return image;
}

/**
 *  拨打电话
 */
+(void)callNumber:(NSString *)number
{
    UIWebView * webView = [[UIWebView alloc] init];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",number]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

@end
