//
//  FishSpringAnimation.m
//  FishAnimationDemo
//
//  Created by August on 15/7/7.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "FishSpringAnimation.h"

@interface FishSpringAnimation ()

@property (nonatomic, assign) CFTimeInterval caculateTime;
@property (nonatomic, assign) BOOL completed;

@end

@implementation FishSpringAnimation

#pragma mark - init methods

+(instancetype)animationWithKeyPath:(NSString *)path
{
    FishSpringAnimation *animation = [[FishSpringAnimation alloc] initWithKeyPath:path];
    animation.mass = 2;
    animation.damping = 30;
    animation.velocity = 20;
    return animation;
}

#pragma mark - override methods

-(void)renderforObject:(id)object
{
    _caculateTime += frameDuration;
    if (_caculateTime < 0) {
        return;
    }
    CFTimeInterval progress = _caculateTime/self.duration;
    if (progress >= 1) {
        _completed = YES;
        progress = 1;
    }
    CGFloat frameValue = [self springValueWithDamping:self.damping velocity:self.velocity mass:self.mass time:progress];
    [super animationDidChangedFrameValue:frameValue forObject:object];
}

-(BOOL)isCompleted
{
    return self.completed;
}

-(void)setDelay:(CFTimeInterval)delay
{
    [super setDelay:delay];
    _caculateTime = -delay;
}

#pragma mark - spring value caculate methods

-(CGFloat)springValueWithDamping:(CGFloat)damping velocity:(CGFloat)velocity mass:(CGFloat)mass time:(CFTimeInterval)time {
    return 1-pow(M_E, -0.5*damping/mass * time) * cos(velocity * time);
}

@end
