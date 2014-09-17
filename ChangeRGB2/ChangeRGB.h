//
//  ChangeRGB.h
//  colorTest
//
//  Created by masa on 2013/08/27.
//  Copyright (c) 2013年 Tryworks-Design. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChangeRGB : NSObject
+ (UIColor *)changeRGB:(NSString *)rgbCode alpha:(float)alpha;
+ (int)calcRGB:(NSString *)rgbCode;
@end
