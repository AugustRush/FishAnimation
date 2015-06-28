//
//  FishAnimation.m
//  FishAnimationDemo
//
//  Created by August on 15/6/25.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "FishAnimation.h"

@implementation FishAnimation

+(instancetype)animation
{
    FishAnimation *animation = [[FishAnimation alloc] init];
    animation.timingFunction = [FishTimingFunction timingFunctionWithType:FishAnimationTimingFunctionTypeLinear];
    return animation;
}

@end
