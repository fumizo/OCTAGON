//
//  ChangeRGB.m
//  colorTest
//
//  Created by masa on 2013/08/27.
//  Copyright (c) 2013年 Tryworks-Design. All rights reserved.
//

#import "ChangeRGB.h"

@implementation ChangeRGB

+ (UIColor *)changeRGB:(NSString *)rgbCode alpha:(float)alpha
{
    //rgbCodeが@"#"から始まっている場合
    if([rgbCode hasPrefix:@"#"])
    {
        //rgbCodeの#の文字をトリムしている。
        rgbCode = [rgbCode stringByReplacingOccurrencesOfString:@"#" withString:@""];
    }
    //16進数のカラーコードを取得して、RGBのそれぞれを配列に格納する。
    NSArray *codeArray = @[
                           [rgbCode substringWithRange:NSMakeRange(0,2)],
                           [rgbCode substringWithRange:NSMakeRange(2,2)],
                           [rgbCode substringWithRange:NSMakeRange(4,2)]];
    
    //16進数のカラーコードを8bitのカラーコードに変換して、0 ~ 1.0のカラーコードに変更する。
    float redRGB = (float)[self calcRGB:codeArray[0]] / 255;
    float greenRGB = (float)[self calcRGB:codeArray[1]] / 255;
    float blueRGB = (float)[self calcRGB:codeArray[2]] / 255;
    
    return [UIColor colorWithRed:redRGB green:greenRGB blue:blueRGB alpha:alpha];
}
//16進数の文字列を8bitのカラーコードに変更するメソッド
+ (int)calcRGB:(NSString *)rgbCode
{
    NSScanner *pScanner = [NSScanner scannerWithString:rgbCode];
    unsigned int iValue;
    [pScanner scanHexInt:&iValue];
    return iValue;
}
@end
