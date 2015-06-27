//
//  FishAnimator.h
//  FishAnimationDemo
//
//  Created by August on 15/6/26.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishAnimation.h"

@interface FishAnimator : NSObject

+(instancetype)shareAnimator;

-(void)addAnimation:(FishAnimation *)animation forObject:(id)object key:(NSString *)key;
-(void)removeAnimationForObject:(id)object Key:(NSString *)key;
-(void)removeAllAnimationsForObject:(id)object;

@end
