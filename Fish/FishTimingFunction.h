//
//  FishTimingFunction.h
//  FishAnimationDemo
//
//  Created by August on 15/6/25.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef CGFloat(^TimingCurve)(CGFloat t);
#define TimingCurve(t) ^CGFloat(CGFloat t)

typedef NS_ENUM(NSUInteger, FishAnimationTimingFunctionType) {
    FishAnimationTimingFunctionTypeLinear = 0,
    FishAnimationTimingFunctionTypeSquare,
    FishAnimationTimingFunctionTypeCubic,
    FishAnimationTimingFunctionTypeQuartic,
    FishAnimationTimingFunctionTypeQuarticEaseInOut,
    FishAnimationTimingFunctionTypeSine,
    FishAnimationTimingFunctionTypeBounceEaseOut,
    FishAnimationTimingFunctionTypeBackEaseIn,
    FishAnimationTimingFunctionTypeBackEaseOut,
    FishAnimationTimingFunctionTypeBackEaseInOut,
    FishAnimationTimingFunctionTypeTestSpring
};

@interface FishTimingFunction : NSObject

@property (nonatomic, assign) FishAnimationTimingFunctionType timingFunctionType;

+(instancetype)timingFunctionWithType:(FishAnimationTimingFunctionType)type;

///**
// *  use for custom timing curve
// *
// *  @param timingCurve the defined TimingCurve block
// *
// *  @return custom timing function
// */
//-(instancetype)initWithTimingCurve:(TimingCurve)timingCurve;

-(CGFloat)getValueWithCurrentTime:(CFTimeInterval)time;

@end
