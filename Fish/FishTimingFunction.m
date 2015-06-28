//
//  FishTimingFunction.m
//  FishAnimationDemo
//
//  Created by August on 15/6/25.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "FishTimingFunction.h"

//  t: current time
//  b: beginning value
//  c: change in value
//  d: duration
typedef CGFloat(^TimingFunction)(CGFloat t,CGFloat b,CGFloat c,CGFloat d);

static TimingFunction linear = ^CGFloat(CGFloat t, CGFloat b, CGFloat c, CGFloat d){
    t /= d;
    return c * t + b;
};

/**
 *  function impliment
 */
@implementation FishTimingFunction

+(instancetype)timingFunctionWithType:(FishAnimationTimingFunctionType)type
{
    FishTimingFunction *timingFunction = [[FishTimingFunction alloc] init];
    timingFunction.timingFunctionType = type;
    return timingFunction;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end
