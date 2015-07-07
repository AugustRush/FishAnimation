//
//  UIView+FishChainable.h
//  FishAnimationDemo
//
//  Created by August on 15/7/3.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FishAnimation.h"

typedef UIView* (^MoveCenterChainableBlock) (CGPoint changeOffset, FishAnimationTimingFunctionType type);

@interface UIView (FishChainable)

-(MoveCenterChainableBlock)moveCenter;

@end
