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

static TimingCurve FishSine = TimingCurve(t){
    return sin((t - 1) * M_PI_2) + 1;
};

static TimingCurve FishBounceEaseOut = TimingCurve(t)
{
    if(t < 4/11.0)
    {
        return (121 * t * t)/16.0;
    }
    else if(t < 8/11.0)
    {
        return (363/40.0 * t * t) - (99/10.0 * t) + 17/5.0;
    }
    else if(t < 9/10.0)
    {
        return (4356/361.0 * t * t) - (35442/1805.0 * t) + 16061/1805.0;
    }
    else
    {
        return (54/5.0 * t * t) - (513/25.0 * t) + 268/25.0;
    }
};

static TimingCurve FishBackEaseIn = TimingCurve(t){
    
    return t * t * t - t * sin(t * M_PI);
};

static TimingCurve FishBackEaseOut = TimingCurve(t){
    
    CGFloat f = (1 - t);
    return 1 - (f * f * f - f * sin(f * M_PI));
};

static TimingCurve FishBackEaseInOut = TimingCurve(t){
    
    if(t < 0.5)
    {
        CGFloat f = 2 * t;
        return 0.5 * (f * f * f - f * sin(f * M_PI));
    }
    else
    {
        CGFloat f = (1 - (2*t - 1));
        return 0.5 * (1 - (f * f * f - f * sin(f * M_PI))) + 0.5;
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
        case FishAnimationTimingFunctionTypeSine: {
            return FishQuarticEaseInOut;
            break;
        }
        case FishAnimationTimingFunctionTypeBounceEaseOut: {
            return FishBounceEaseOut;
            break;
        }
        case FishAnimationTimingFunctionTypeBackEaseIn: {
            return FishBackEaseIn;
            break;
        }
        case FishAnimationTimingFunctionTypeBackEaseOut: {
            return FishBackEaseOut;
            break;
        }
        case FishAnimationTimingFunctionTypeBackEaseInOut: {
            return FishBackEaseInOut;
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
