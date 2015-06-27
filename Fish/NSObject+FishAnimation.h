//
//  NSObject+FishAnimation.h
//  FishAnimationDemo
//
//  Created by August on 15/6/25.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishAnimation.h"

@interface NSObject (FishAnimation)

-(void)fish_addAnimation:(FishAnimation *)animation forKey:(NSString *)key;
-(void)fish_removeAnimationForKey:(NSString *)key;
-(void)fish_removeAllAnimations;

@end
