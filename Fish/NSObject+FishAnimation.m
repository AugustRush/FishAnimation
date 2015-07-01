//
//  NSObject+FishAnimation.m
//  FishAnimationDemo
//
//  Created by August on 15/6/25.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "NSObject+FishAnimation.h"
#import "FishAnimator.h"

@implementation NSObject (FishAnimation)

-(void)fish_addAnimation:(FishAnimation *)animation forKey:(NSString *)key completed:(AnimationCompleted)completed
{
    [[FishAnimator shareAnimator] addAnimation:animation forObject:self key:key completed:completed];
}

-(void)fish_removeAnimationForKey:(NSString *)key
{
    [[FishAnimator shareAnimator] removeAnimationForObject:self Key:key completed:nil];
}

-(void)fish_removeAllAnimations
{
    [[FishAnimator shareAnimator] removeAllAnimationsForObject:self];
}

@end
