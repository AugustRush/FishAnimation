//
//  FishAnimationGroup.m
//  FishAnimationDemo
//
//  Created by August on 15/6/26.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "FishAnimationGroup.h"
#import <QuartzCore/QuartzCore.h>

@interface FishAnimationGroup ()

@property (nonatomic, strong) NSArray *animations;
@property (nonatomic, assign) NSUInteger currentSecton;
@property (nonatomic, assign) CFTimeInterval currentSectionTime;
@property (nonatomic, assign) CFTimeInterval cumulativeTime;
@property (nonatomic, assign) BOOL completed;

@end

@implementation FishAnimationGroup

-(instancetype)initWithAnimations:(NSArray *)animations
{
    self = [super init];
    if (self) {
        self.animations = animations;
        self.currentSecton = 0;
        self.cumulativeTime = 0.0;
        FishAnimation *animation = animations[0];
        self.currentSectionTime = [animation duration];
    }
    return self;
}

-(void)renderforObject:(id)object
{
    _cumulativeTime += frameDuration;
    CFTimeInterval progress = _cumulativeTime/_currentSectionTime;
    FishAnimation *animation = self.animations[self.currentSecton];
    [animation animationDidChangedFrameValue:[animation.timingFunction getValueWithCurrentTime:progress] forObject:object];
    if (progress >= 1.0) {
        _cumulativeTime = 0.0;
        if (self.currentSecton < self.animations.count - 1) {
            ++self.currentSecton;
            animation = self.animations[self.currentSecton];
            self.currentSectionTime = [animation duration];
        }else{
            self.completed = YES;
        }
    }
}

-(BOOL)isCompleted
{
    return self.completed;
}

@end
