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
NSString *const kFishViewSize = @"bounds";
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

struct FishMathStruct {
    CGFloat first,second,third,fouth,fifth,sixth;
};

NS_INLINE struct FishMathStruct FishMath(struct FishMathStruct start,struct FishMathStruct to,CGFloat frame){
    
    struct FishMathStruct last;
    last.first = start.first + (to.first - start.first)*frame;
    last.second = start.second + (to.second - start.second)*frame;
    last.third = start.third + (to.third - start.third)*frame;
    last.fouth = start.fouth + (to.fouth - start.fouth)*frame;
    last.fifth = start.fifth + (to.fifth - start.fifth)*frame;
    last.sixth = start.sixth + (to.sixth - start.fifth)*frame;
    return last;
};

static CaculateValueFunction FishAlphaFunc = CaculateValueFunction(f, s, t){
    struct FishMathStruct start,to,last;
    start.first = [s floatValue];
    to.first = [t floatValue];
    last = FishMath(start, to, f);
    return [NSNumber numberWithFloat:last.first];
};

static CaculateValueFunction FishColorFunc = CaculateValueFunction(f, s, t){
    
    CGColorRef sCGColor = [s CGColor];
    CGColorRef tCGColor = [t CGColor];
    const CGFloat * sColor = CGColorGetComponents(sCGColor);
    const CGFloat * tColor = CGColorGetComponents(tCGColor);
    
    size_t scount = CGColorGetNumberOfComponents(sCGColor);
    size_t tcount = CGColorGetNumberOfComponents(tCGColor);
    struct FishMathStruct start,to,last;
    if(scount == 4){
        start.first = sColor[0];
        start.second = sColor[1];
        start.third = sColor[2];
        start.fouth = sColor[3];
    }else{
        start.first = sColor[0];
        start.second = sColor[0];
        start.third = sColor[0];
        start.fouth = sColor[1];
    }
    
    if(tcount){
        to.first = tColor[0];
        to.second = tColor[1];
        to.third = tColor[2];
        to.fouth = tColor[3];
    }else{
        to.first = tColor[0];
        to.second = tColor[0];
        to.third = tColor[0];
        to.fouth = tColor[1];
    }
    
    last = FishMath(start, to, f);
    return [UIColor colorWithRed:last.first green:last.second blue:last.third alpha:last.fouth];
};

static CaculateValueFunction FishCenterFunc = CaculateValueFunction(f, s, t){
    CGPoint sp = [s CGPointValue];
    CGPoint tp = [t CGPointValue];
    struct FishMathStruct start,to,last;
    start.first = sp.x;
    start.second = sp.y;
    to.first = tp.x;
    to.second = tp.y;
    last = FishMath(start, to, f);
    return [NSValue valueWithCGPoint:CGPointMake(last.first, last.second)];
};

static CaculateValueFunction FishBoundsSizeFunc = CaculateValueFunction(f, s, t){
    CGSize sp = [s CGSizeValue];
    CGSize tp = [t CGSizeValue];
    struct FishMathStruct start,to,last;
    start.first = sp.width;
    start.second = sp.height;
    to.first = tp.width;
    to.second = tp.height;
    last = FishMath(start, to, f);
    return [NSValue valueWithCGRect:CGRectMake(0, 0, last.first, last.second)];
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
    }else if (keyPath == kFishViewSize){
        return FishBoundsSizeFunc;
    }
    
    return nil;
}

@end
