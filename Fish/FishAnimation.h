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

@property (nonatomic, strong) FishTimingFunction *timingFunction;//default is liner
@property (nonatomic, assign) CFTimeInterval duration;//default is 0.3s
@property (nonatomic, assign) CFTimeInterval delay;//default is 0.0s

///methods subclass must be override to custom animation
-(void)animationDidChangedFrameValue:(CGFloat)frameValue forObject:(id)object;
-(BOOL)isCompleted;

@end
