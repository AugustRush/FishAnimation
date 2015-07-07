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
@property (nonatomic, assign) BOOL completed;

@end

@implementation FishAnimationGroup

-(instancetype)initWithAnimations:(NSArray *)animations
{
    self = [super init];
    if (self) {
        self.animations = animations;
        self.currentSecton = 0;
    }
    return self;
}

-(void)renderforObject:(id)object
{
    //maybe out of bounds
    FishAnimation *animation = self.animations[_currentSecton];
    [animation renderforObject:object];
    if ([animation isCompleted]) {
        ++_currentSecton;
        if (_currentSecton == self.animations.count) {
            self.completed = YES;
        }
    }
}

-(BOOL)isCompleted
{
    return self.completed;
}

@end
