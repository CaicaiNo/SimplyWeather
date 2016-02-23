//
//  WheelView.m
//  SPWeatherForecast
//
//  Created by sheng on 16/1/6.
//  Copyright © 2016年 simple. All rights reserved.
//

#import "WheelView.h"
#import "SPImageView.h"
@interface WheelView()


@end
@implementation WheelView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        for (NSInteger i = 0; i < 8; i ++) {
            SPImageView *imageView = [SPImageView initWithFrame:CGRectMake((self.bounds.size.width / 2)-75, (self.bounds.size.height / 2)-85, 75, 110) andImage:[UIImage imageNamed:[NSString stringWithFormat:@"updating_icon_%ld",i+1]]];
            imageView.layer.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
            imageView.transform = CGAffineTransformRotate(imageView.transform, M_PI_4*i);
            [self addSubview:imageView];
            self.fromValue = 0;
            self.toValue = 0;
        }
    }
    return self;
}
-(void)show
{
    
    
}
-(void)hide
{
    
}
-(void)startAnimation
{
    int i = arc4random()%7+1;
    while (i == self.toValue/M_PI_4) {
        i = arc4random()%7+1;
    }
    CGFloat oldValue = self.toValue;
    CGFloat newValue = M_PI_4*i;
    
    self.fromValue = oldValue;
    self.toValue = newValue;
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    springAnimation.fromValue = [NSNumber numberWithFloat:self.fromValue];
    springAnimation.toValue = [NSNumber numberWithFloat:self.toValue];
    springAnimation.removedOnCompletion = NO;
    
    springAnimation.dynamicsTension = 120.f;
    springAnimation.dynamicsMass = 1.2f;
    //    springAnimation.dynamicsFriction = 100;
    [self.layer pop_addAnimation:springAnimation forKey:nil];
}
-(void)stopAnimation
{
    [self pop_removeAllAnimations];
}
@end
