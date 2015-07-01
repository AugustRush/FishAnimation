//
//  FishTimingFunction.m
//  FishAnimationDemo
//
//  Created by August on 15/6/25.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "FishTimingFunction.h"

static TimingCurve fishLinear = ^CGFloat(CGFloat t){
    return t;
};

static TimingCurve fishCubic = ^CGFloat(CGFloat t){
    return t*t*t;
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
            return fishLinear;
            break;
        }
        case FishAnimationTimingFunctionTypeCubic: {
            return fishCubic;
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
