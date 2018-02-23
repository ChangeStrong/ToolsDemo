//
//  TextImageTool.m
//  CommonTools
//
//  Created by luo luo on 23/02/2018.
//  Copyright © 2018 ChangeStrong. All rights reserved.
//

#import "TextImageTool.h"

@implementation TextImageTool

+ (UIImage *)drawImageFromText:(NSString *)text
                     imageSize:(CGSize)imageSize
                     textColor:(UIColor *)textColor
                 bacgroudColor:(UIColor *)backgroudColor
                  textFontSize:(CGFloat)fontSize
{
    //需要绘制的图片大小
    CGRect rect = CGRectMake(0.0f, 0.0f, imageSize.width, imageSize.height);
    //以图片尺寸创建上下文
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //填充上下文中背景色
    CGContextSetFillColorWithColor(context, [backgroudColor CGColor]);
    CGContextFillRect(context, rect);
    //从当前上下文中生成一张图片
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImage *headerimg = [self imageToAddText:img withText:text textColor:textColor textFontSize:fontSize];
    return headerimg;
}

//把文字绘制到图片上
+ (UIImage *)imageToAddText:(UIImage *)img
                   withText:(NSString *)text
                  textColor:(UIColor *)textColor
               textFontSize:(CGFloat)fontSize
{
    //1.获取上下文
    UIGraphicsBeginImageContext(img.size);
    //2.将图片作为背景绘制到上下文中
    [img drawInRect:CGRectMake(0, 0, img.size.width, img.size.height)];
    //3.绘制文字--y轴距离上边10分之一处
    NSLog(@"y=%f",img.size.height/10.0);
    CGRect rect = CGRectMake(0.0,(img.size.height-fontSize-5)/2.0, img.size.width, fontSize+5);//文字绘制的区域
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentCenter;
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSParagraphStyleAttributeName:style,NSForegroundColorAttributeName:textColor};//文字的属性
    //再将文字绘制到上下文中
    [text drawInRect:rect withAttributes:dic];
    //4.获取绘制到得图片
    UIImage *watermarkImg = UIGraphicsGetImageFromCurrentImageContext();
    //5.结束图片的绘制
    UIGraphicsEndImageContext();
    
    return watermarkImg;
}
@end
