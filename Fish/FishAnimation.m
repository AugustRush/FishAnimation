//
//  FishAnimation.m
//  FishAnimationDemo
//
//  Created by August on 15/6/25.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "FishAnimation.h"
#import "FishAnimator.h"

@interface FishAnimation ()

@property (nonatomic, assign, readwrite) BOOL completed;

@end

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

-(void)renderforObject:(id)object
{
    _beginTime += frameDuration;
    CFTimeInterval progress = _beginTime/(CFTimeInterval)_duration;
    if (progress >= 1) {
        _completed = YES;
        progress = 1;
    }
    [self animationDidChangedFrameValue:[self.timingFunction getValueWithCurrentTime:progress] forObject:object];
}

-(BOOL)isCompleted
{
    return self.completed;
}

-(void)animationDidChangedFrameValue:(CGFloat)frameValue forObject:(id)object{}

@end
