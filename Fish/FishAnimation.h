//
//  FishAnimation.h
//  FishAnimationDemo
//
//  Created by August on 15/6/25.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishTimingFunction.h"

@class FishAnimation;
@protocol FishAnimationDelegate <NSObject>

-(void)animationDidStart:(FishAnimation *)animation;
-(void)animationDidStop:(FishAnimation *)animation isFinished:(BOOL)isFinished;

@end

@interface FishAnimation : NSObject

+(instancetype)animation;

@property (nonatomic, strong) FishTimingFunction *timingFunction;
@property (nonatomic, weak) id<FishAnimationDelegate> delegate;

@end
