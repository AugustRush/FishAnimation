//
//  FishAnimation.m
//  FishAnimationDemo
//
//  Created by August on 15/6/25.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "FishAnimation.h"
#import "FishAnimator.h"

const double frameDuration = 1/60.0;

@implementation FishAnimation
{
    CFTimeInterval _beginTime;
}

+(instancetype)animation
{
    FishAnimation *animation = [[FishAnimation alloc] init];
    return animation;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.timingFunction = [FishTimingFunction timingFunctionWithType:FishAnimationTimingFunctionTypeLinear];
        _beginTime = 0;
    }
    return self;
}

-(void)_updateProgress:(id)object
{
    _beginTime += frameDuration;
    CGFloat progress = _beginTime/(CGFloat)_duration;
    if (progress >= 1) {
        self.completed = YES;
        progress = 1;
    }
    [self animationDidChangedFrameValue:[self.timingFunction getValueWithCurrentTime:progress] forObject:object];
}

-(void)animationDidChangedFrameValue:(CGFloat)frameValue forObject:(id)object{}

@end
