//
//  TextImageTool.h
//  CommonTools
//
//  Created by luo luo on 23/02/2018.
//  Copyright © 2018 ChangeStrong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TextImageTool : NSObject
//把文字生成图片
+ (UIImage *)drawImageFromText:(NSString *)text
                     imageSize:(CGSize)imageSize
                     textColor:(UIColor *)textColor
                 bacgroudColor:(UIColor *)backgroudColor
                  textFontSize:(CGFloat)fontSize;
@end
