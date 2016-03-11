//
//  SPLabel.m
//  SPWeatherForecast
//
//  Created by sheng on 16/1/5.
//  Copyright © 2016年 simple. All rights reserved.
//

#import "SPLabel.h"

@implementation SPLabel
+(instancetype)CreatHeaderLabelWithText:(NSString*)text andFont:(UIFont*)font{
    SPLabel *label = [[SPLabel alloc]init];
    label.text = text;
    label.font = font;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}
+(instancetype)CreatHeaderLabelWithText:(NSString*)text andAttribute:(NSDictionary *)dic
{
    SPLabel *label = [[SPLabel alloc]init];
    label.attributedText = [[NSAttributedString alloc]initWithString:text attributes:dic];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}
+(instancetype)initTitleLabelByText:(NSString *)text
{
    
    SPLabel *label = [[SPLabel alloc]init];
    label.frame = CGRectMake(10, 0, 150, 25);
    NSDictionary *attrDict = @{ NSTextEffectAttributeName: NSTextEffectLetterpressStyle,
                                 NSForegroundColorAttributeName: [UIColor blackColor],
                                 NSFontAttributeName: Font_STHeitiSC_Light(15) };
    label.attributedText = [[NSAttributedString alloc] initWithString: text attributes: attrDict];
//    label.backgroundColor = [UIColor redColor];
    return label;
}
-(void)setTipsLabelByText:(NSString *)text
{
    NSArray *strArray = [text componentsSeparatedByString:@":"];
    NSString *preStr = strArray.firstObject;
    NSString *str = [preStr stringByAppendingString:@":"];
    NSString *info = strArray.lastObject;
    NSRange rangeOne = [text rangeOfString:str];
    NSRange rangeTwo = [text rangeOfString:info];
    UIColor *color = [self setColorByString:info];
    NSDictionary *attrDict1 = @{
                                NSForegroundColorAttributeName:[UIColor blackColor],
                                NSFontAttributeName: Font_STHeitiSC_Light(12) };
    NSDictionary *attrDict2 = @{NSForegroundColorAttributeName:color,
                                NSFontAttributeName: Font_STHeitiSC_Light(12) };
    NSAttributedString *attr1 = [[NSAttributedString alloc]initWithString:[text substringWithRange:rangeOne] attributes:attrDict1];
    NSAttributedString *attr2 = [[NSAttributedString alloc]initWithString:[text substringWithRange:rangeTwo] attributes:attrDict2];
    NSMutableAttributedString *mutableAttr = [[NSMutableAttributedString alloc]initWithAttributedString:attr1];
    [mutableAttr appendAttributedString:attr2];
    self.attributedText = mutableAttr;
    //    label.backgroundColor = [UIColor redColor];

}
- (UIColor *)setColorByString:(NSString *)str
{
    if ([str containsString:@"较热"]||[str containsString:@"较不宜"]||[str containsString:@"较强"]) {
        return UIColorFromRGB(0xFF8800);
    }else if([str containsString:@"热"]||[str containsString:@"不宜"]||[str containsString:@"强"]){
        return UIColorFromRGB(0xE32424);
    }else if([str containsString:@"舒适"]||[str containsString:@"适宜"]||[str containsString:@"弱"]){
        return UIColorFromRGB(0x2AFF00);
    }else if([str containsString:@"寒冷"]){
        return UIColorFromRGB(0x4A90E2);
    }else if([str containsString:@"冷"]){
        return UIColorFromRGB(0x31AEDB);
    }
    else {
        return UIColorFromRGB(0xFFD93D);
    }
}
-(void)setAttributedStringWithTemp:(NSNumber *)number andIsMax:(BOOL)ismax
{
    UIColor *setColor = nil;
    if (ismax) {
        setColor = UIColorFromRGB(0xE32424);
    }else{
        setColor = UIColorFromRGB(0x7D91DB);
    }
        NSInteger integer = [number integerValue];
        NSString *tempStr = [NSString stringWithFormat:@"%ld",(long)integer];
//        NSString *totalStr = [NSString stringWithFormat:@"%@˚C",tempStr];
        
//        NSRange tempRange = [tempStr rangeOfString:totalStr];
//        NSRange CRange = [@"˚C" rangeOfString:totalStr];
        
    NSShadow *shadow = [[NSShadow alloc]init];
    shadow.shadowOffset = CGSizeMake(1, 1);
    shadow.shadowBlurRadius = 6.f;
    shadow.shadowColor = setColor;
    NSDictionary *attrDic1                   = @{NSFontAttributeName:[UIFont fontWithName:LATO_REGULAR size:15],NSForegroundColorAttributeName:[UIColor whiteColor]};
    NSAttributedString *attrStr1             = [[NSAttributedString alloc]initWithString:tempStr attributes:attrDic1];
    NSDictionary *attrDic2                   = @{NSFontAttributeName:[UIFont fontWithName:LATO_REGULAR size:15],NSForegroundColorAttributeName:setColor,NSShadowAttributeName:shadow};
    NSAttributedString *attrStr2             = [[NSAttributedString alloc]initWithString:@"˚C" attributes:attrDic2];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithAttributedString:attrStr1];
        [attributedStr appendAttributedString:attrStr2];
    self.attributedText                      = attributedStr;
        
    
}

@end
