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

@property (nonatomic, assign) BOOL completed;
@property (nonatomic, assign) NSTimeInterval beginTime;

@end

@implementation FishAnimation

#pragma mark - init methods

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
        _beginTime = 0.0;
    }
    return self;
}

#pragma mark - private methods

-(void)setDelay:(CFTimeInterval)delay
{
    _delay = delay;
    _beginTime = -_delay;
}

#pragma mark - render methods

-(void)renderforObject:(id)object
{
    _beginTime += frameDuration;
    if (_beginTime < 0) {
        return;
    }
    CFTimeInterval progress = _beginTime/_duration;
    if (progress >= 1) {
        _completed = YES;
        progress = 1;
    }
    [self animationDidChangedFrameValue:[self.timingFunction getValueWithCurrentTime:progress] forObject:object];
}

-(void)animationDidChangedFrameValue:(CGFloat)frameValue forObject:(id)object{}

#pragma mark - state methods

-(BOOL)isCompleted
{
    return self.completed;
}

@end
