//
//  RTSpinKitThreeBounceVerticalAnimation.m
//  SpinKit
//
//  Created by Jesse Armand Iswaraputra on 20/10/16.
//  Copyright © 2016 Ramon Torres. All rights reserved.
//

#import "RTSpinKitThreeBounceVerticalAnimation.h"

@implementation RTSpinKitThreeBounceVerticalAnimation

-(void)setupSpinKitAnimationInLayer:(CALayer *)layer withSize:(CGSize)size color:(UIColor *)color
{
    NSTimeInterval beginTime = CACurrentMediaTime();

    CGFloat offset = size.width / 8;
    CGFloat circleSize = offset * 1.5;
    
    for (NSInteger i=0; i < 3; i+=1) {
        CALayer *circle = [CALayer layer];
        circle.frame = CGRectMake(i * 3 * offset, size.height / 2, circleSize, circleSize);
        circle.backgroundColor = color.CGColor;
        circle.anchorPoint = CGPointMake(0.5, 0.5);
        circle.cornerRadius = CGRectGetHeight(circle.bounds) * 0.5;
        circle.transform = CATransform3DMakeTranslation(0.0, 0.0, 0.0);
        
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        anim.removedOnCompletion = NO;
        anim.repeatCount = HUGE_VALF;
        anim.duration = 0.8;
        anim.beginTime = beginTime + (0.2 * i);
        anim.keyTimes = @[@(0.4), @(0.6), @(1.0)];

        CGFloat damping = 0.4;
        CAMediaTimingFunction *dampingFunction = [[CAMediaTimingFunction alloc] initWithControlPoints:0.5 :1.1 + (damping / 3.0) :1 :1 ];

        anim.timingFunctions = @[
            dampingFunction,
            dampingFunction,
            dampingFunction
        ];

        anim.values = @[
            [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0.0, 0.0, 0.0)],
            [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0.0, -circleSize, 0.0)],
            [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0.0, 0.0, 0.0)]
        ];
        
        [layer addSublayer:circle];
        [circle addAnimation:anim forKey:@"spinkit-anim"];
    }
}

@end
