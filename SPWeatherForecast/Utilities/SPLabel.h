//
//  SPLabel.h
//  SPWeatherForecast
//
//  Created by sheng on 16/1/5.
//  Copyright © 2016年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPLabel : UILabel
+(instancetype)CreatHeaderLabelWithText:(NSString*)text andFont:(UIFont*)font;
+(instancetype)CreatHeaderLabelWithText:(NSString*)text andAttribute:(NSDictionary *)dic;
/**
 *  title创建方法
 *
 */
+(instancetype)initTitleLabelByText:(NSString*)text;
/**
 *  MAX MIN temp的文本设置，带˚C
 */
-(void)setAttributedStringWithTemp:(NSNumber *)number andIsMax:(BOOL)ismax;
/**
 *  Tip界面下文本的创建方法
 *
 */
-(void)setTipsLabelByText:(NSString *)text;
@end
