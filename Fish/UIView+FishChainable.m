//
//  UIView+FishChainable.m
//  FishAnimationDemo
//
//  Created by August on 15/7/3.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "UIView+FishChainable.h"

@implementation UIView (FishChainable)

-(PointChainableBlock)moveCenter
{
    return ^UIView *(CGPoint offset, FishAnimationTimingFunctionType type){
        NSLog(@"offset is %@ , type is %lu",NSStringFromCGPoint(offset),(unsigned long)type);
        return self;
    };
}

@end
