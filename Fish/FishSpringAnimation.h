//
//  FishSpringAnimation.h
//  FishAnimationDemo
//
//  Created by August on 15/7/7.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "FishPropertyAnimation.h"

@interface FishSpringAnimation : FishPropertyAnimation

/**
 *  [10 - 40]
 */
@property (nonatomic, assign) CGFloat damping;
/**
 *  [1 - 40]
 */
@property (nonatomic, assign) CGFloat velocity;

/**
 *  [1 - 5]
 */
@property (nonatomic, assign) CGFloat mass;

@end
