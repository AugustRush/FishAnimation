//
//  FishSpringAnimation.h
//  FishAnimationDemo
//
//  Created by August on 15/7/7.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "FishPropertyAnimation.h"

@interface FishSpringAnimation : FishPropertyAnimation

@property (nonatomic, assign) CGFloat damping;
@property (nonatomic, assign) CGFloat velocity;
@property (nonatomic, assign) CGFloat mass;

@end
