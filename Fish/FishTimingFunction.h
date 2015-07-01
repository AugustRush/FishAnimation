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

typedef NS_ENUM(NSUInteger, FishAnimationTimingFunctionType) {
    FishAnimationTimingFunctionTypeLinear,
    FishAnimationTimingFunctionTypeCubic
};

@interface FishTimingFunction : NSObject

@property (nonatomic, assign) FishAnimationTimingFunctionType timingFunctionType;

+(instancetype)timingFunctionWithType:(FishAnimationTimingFunctionType)type;

-(CGFloat)getValueWithCurrentTime:(CFTimeInterval)time;

@end
