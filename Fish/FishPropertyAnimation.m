//
//  FishPropertyAnimation.m
//  FishAnimationDemo
//
//  Created by August on 15/7/1.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "FishPropertyAnimation.h"

#pragma mark - animated keypath constants

NSString *const kFishViewAlpha = @"alpha";
NSString *const kFishViewBackgroundColor = @"backgroundColor";
NSString *const kFishViewCenter = @"center";
/**
 *  define caculate function block
 *
 *  @param frame      current frame progress
 *  @param startValue animate start value
 *  @param toValue    animate to value
 *
 *  @return the animate frame real value
 */

typedef id (^CaculateValueFunction)(CGFloat frame,id startValue, id toValue);
#define CaculateValueFunction(frame,startValue,toValue) ^id(CGFloat frame,id startValue, id toValue)

static CaculateValueFunction FishAlphaFunc = CaculateValueFunction(f, s, t){
    CGFloat to = [t floatValue];
    CGFloat start = [s floatValue];
    return [NSNumber numberWithFloat:start+f*(to - start)];
};

static CaculateValueFunction FishColorFunc = CaculateValueFunction(f, s, t){
    const CGFloat * sColor = CGColorGetComponents([s CGColor]);
    const CGFloat * tColor = CGColorGetComponents([t CGColor]);
    CGFloat changeR = tColor[0] - sColor[0];
    CGFloat changeG = tColor[1] - sColor[1];
    CGFloat changeB = tColor[2] - sColor[2];
    CGFloat changeA = tColor[3] - sColor[3];

    return [UIColor colorWithRed:sColor[0]+f*changeR green:sColor[1]+f*changeG blue:sColor[2]+f*changeB alpha:sColor[3]+f*changeA];
};

static CaculateValueFunction FishCenterFunc = CaculateValueFunction(f, s, t){
    CGFloat sX = [s CGPointValue].x;
    CGFloat sY = [s CGPointValue].y;
    CGFloat changeX = [t CGPointValue].x - sX;
    CGFloat changeY = [t CGPointValue].y - sY;
    
    CGPoint point = CGPointMake(sX + f*changeX, sY + f*changeY);
    return [NSValue valueWithCGPoint:point];
};
//
//  property animation implementation
//
@interface FishPropertyAnimation ()

@property (nonatomic, copy) CaculateValueFunction caculateValueFunction;

@end

@implementation FishPropertyAnimation

+(instancetype)animationWithKeyPath:(NSString *)path
{
    FishPropertyAnimation *animation = [[FishPropertyAnimation alloc] init];
    animation.keyPath = path;
    animation.caculateValueFunction = [animation getCaculateFunctionWithKeyPath:path];
    return animation;
}

//override

-(void)animationDidChangedFrameValue:(CGFloat)frameValue forObject:(id)object
{
    id value = self.caculateValueFunction(frameValue,self.fromValue,self.toValue);
    [object setValue:value forKeyPath:self.keyPath];
}

-(CaculateValueFunction)getCaculateFunctionWithKeyPath:(NSString *)keyPath
{
    if (keyPath == kFishViewAlpha) {
        return FishAlphaFunc;
    }else if (keyPath == kFishViewBackgroundColor){
        return FishColorFunc;
    }else if (keyPath == kFishViewCenter){
        return FishCenterFunc;
    }
    
    return nil;
}

@end
