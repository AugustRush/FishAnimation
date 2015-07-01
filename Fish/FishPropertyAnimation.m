//
//  FishPropertyAnimation.m
//  FishAnimationDemo
//
//  Created by August on 15/7/1.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "FishPropertyAnimation.h"

typedef id (^CaculateValueFunction)(CGFloat frame,id startValue, id toValue);

@interface FishPropertyAnimation ()

@property (nonatomic, copy) CaculateValueFunction caculateValueFunction;

@end

@implementation FishPropertyAnimation

+(instancetype)animationWithKeyPath:(NSString *)path
{
    FishPropertyAnimation *animation = [[FishPropertyAnimation alloc] init];
    animation.keyPath = path;
    animation.caculateValueFunction = [animation getCaculateFunctionWithKeyPath:0];
    return animation;
}

//override

-(void)animationDidChangedFrameValue:(CGFloat)frameValue forObject:(id)object
{
    id value = self.caculateValueFunction(frameValue,self.fromValue,self.toValue);
    [object setValue:value forKeyPath:self.keyPath];
}

-(CaculateValueFunction)getCaculateFunctionWithKeyPath:(NSUInteger)keyPath
{
    return nil;
}

@end
