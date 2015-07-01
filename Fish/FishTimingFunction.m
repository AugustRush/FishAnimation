//
//  FishTimingFunction.m
//  FishAnimationDemo
//
//  Created by August on 15/6/25.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "FishTimingFunction.h"

static TimingCurve FishLinear = TimingCurve(t){
    return t;
};

static TimingCurve FishSquare = TimingCurve(t){
    return t*t;
};

static TimingCurve FishCubic = TimingCurve(t){
    return t*t*t;
};

static TimingCurve FishQuartic = TimingCurve(t){
    return t*t*t*t;
};

static TimingCurve FishQuarticEaseInOut = TimingCurve(t){
    if(t < 0.5)
    {
        return 8 * t * t * t * t;
    }
    else
    {
        CGFloat f = (t - 1);
        return -8 * f * f * f * f + 1;
    }
};

/**
 *  function impliment
 */
@interface FishTimingFunction ()

@property (nonatomic, copy) TimingCurve timingCurve;

@end

@implementation FishTimingFunction

+(instancetype)timingFunctionWithType:(FishAnimationTimingFunctionType)type
{
    FishTimingFunction *timingFunction = [[FishTimingFunction alloc] init];
    timingFunction.timingFunctionType = type;
    timingFunction.timingCurve = [timingFunction getTimingCurveWithType:type];
    return timingFunction;
}

-(TimingCurve)getTimingCurveWithType:(FishAnimationTimingFunctionType)type
{
    switch (type) {
        case FishAnimationTimingFunctionTypeLinear: {
            return FishLinear;
            break;
        }
        case FishAnimationTimingFunctionTypeCubic: {
            return FishCubic;
            break;
        }
        case FishAnimationTimingFunctionTypeSquare: {
            return FishSquare;
            break;
        }
            
        case FishAnimationTimingFunctionTypeQuartic: {
            return FishQuartic;
            break;
        }
        case FishAnimationTimingFunctionTypeQuarticEaseInOut: {
            return FishQuarticEaseInOut;
            break;
        }
    
        default: {
            break;
        }
    }
}

-(CGFloat)getValueWithCurrentTime:(CFTimeInterval)time
{
    return self.timingCurve(time);
}

@end
