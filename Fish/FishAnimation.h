//
//  FishAnimation.h
//  FishAnimationDemo
//
//  Created by August on 15/6/25.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishTimingFunction.h"
#import "FishRenderProtocol.h"

static const CFTimeInterval frameDuration = 1/60.0;

@interface FishAnimation : NSObject<FishRenderProtocol>

+(instancetype)animation;

@property (nonatomic, strong) FishTimingFunction *timingFunction;
@property CFTimeInterval duration;

///methods subclass must be override to custom animation
-(void)animationDidChangedFrameValue:(CGFloat)frameValue forObject:(id)object;
-(BOOL)isCompleted;

@end
