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

@class FishAnimation;
@protocol FishAnimationDelegate <NSObject>

-(void)animationDidStart:(FishAnimation *)animation;
-(void)animationDidStop:(FishAnimation *)animation isFinished:(BOOL)isFinished;

@end

@interface FishAnimation : NSObject<FishRenderProtocol>

+(instancetype)animation;

@property (nonatomic, strong) FishTimingFunction *timingFunction;
@property (nonatomic, weak) id<FishAnimationDelegate> delegate;
@property CFTimeInterval duration;
@property (nonatomic, assign) BOOL completed;
-(void)animationDidChangedFrameValue:(CGFloat)frameValue forObject:(id)object;

@end
