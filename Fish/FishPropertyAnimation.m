//
//  FishPropertyAnimation.m
//  FishAnimationDemo
//
//  Created by August on 15/7/1.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "FishPropertyAnimation.h"
#import <QuartzCore/QuartzCore.h>

#pragma mark - animated keypath constants

//view
NSString *const kFishViewAlpha = @"alpha";
NSString *const kFishViewBackgroundColor = @"backgroundColor";
NSString *const kFishViewCenter = @"center";
NSString *const kFishViewSize = @"bounds";
NSString *const kFishViewTransform = @"transform";


//layer
NSString *const kFishLayerCornerRadius = @"layer.cornerRadius";
NSString *const kFishLayerOpacity = @"layer.opacity";
NSString *const kFishLayerScale = @"layer.transform";
NSString *const kFishLayerBackgroundColor = @"layer.backgroundColor";
NSString *const kFishLayerBorderWidth = @"layer.borderWidth";
NSString *const kFishLayerRotationX = @"layerRotationX.transform";
NSString *const kFishLayerRotationY = @"layerRotationY.transform";
NSString *const kFishLayerRotationZ = @"layerRotationZ.transform";
NSString *const kFishLayerRotationXY = @"layerRotationXY.transform";

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
    last.sixth = start.sixth + (to.sixth - start.sixth)*frame;
    return last;
};

static CaculateValueFunction FishOneDimentionalFunc = CaculateValueFunction(f, s, t){
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

static CaculateValueFunction FishViewRatationFunc = CaculateValueFunction(f, s, t){
    CGAffineTransform sp = [s CGAffineTransformValue];
    CGAffineTransform tp = [t CGAffineTransformValue];
    
    struct FishMathStruct start,to,last;
    start.first = sp.a;
    start.second = sp.b;
    start.third = sp.c;
    start.fouth = sp.d;
    start.fifth = sp.tx;
    start.sixth = sp.ty;
    
    to.first = tp.a;
    to.second = tp.b;
    to.third = tp.c;
    to.fouth = tp.d;
    to.fifth = tp.tx;
    to.sixth = tp.ty;
    
    last = FishMath(start, to, f);
    return [NSValue valueWithCGAffineTransform:CGAffineTransformMake(last.first, last.second, last.third, last.fouth, last.fifth, last.sixth)] ;
};

static CaculateValueFunction FishLayerScaleFunc = CaculateValueFunction(f, s, t){
    CATransform3D sp= [s CATransform3DValue];
    CATransform3D tp = [t CATransform3DValue];
    
    struct FishMathStruct start,to,last;
    start.first = sp.m11;
    start.second = sp.m22;
    start.third = sp.m33;
    
    to.first = tp.m11;
    to.second = tp.m22;
    to.third = tp.m33;
    
    last = FishMath(start, to, f);
    CATransform3D scale = CATransform3DMakeScale(last.first, last.second, last.third);
    return [NSValue valueWithCATransform3D:scale];
};

static CaculateValueFunction FishLayerRotationXFunc = CaculateValueFunction(f, s, t){
    CGFloat sp = [s floatValue];
    CGFloat tp = [t floatValue];
    
    struct FishMathStruct start,to,last;
    start.first = sp;
    to.first = tp;
    
    last = FishMath(start, to, f);
    CATransform3D scale = CATransform3DMakeRotation(last.first, 1.0, 0, 0);
    return [NSValue valueWithCATransform3D:scale];
};

static CaculateValueFunction FishLayerRotationYFunc = CaculateValueFunction(f, s, t){
    CGFloat sp = [s floatValue];
    CGFloat tp = [t floatValue];
    
    struct FishMathStruct start,to,last;
    start.first = sp;
    to.first = tp;
    
    last = FishMath(start, to, f);
    CATransform3D scale = CATransform3DMakeRotation(last.first, 0, 1.0, 0);
    return [NSValue valueWithCATransform3D:scale];
};

static CaculateValueFunction FishLayerRotationZFunc = CaculateValueFunction(f, s, t){
    CGFloat sp = [s floatValue];
    CGFloat tp = [t floatValue];
    
    struct FishMathStruct start,to,last;
    start.first = sp;
    to.first = tp;
    
    last = FishMath(start, to, f);
    CATransform3D scale = CATransform3DMakeRotation(last.first, 0.0, 0.0, 1.0);
    return [NSValue valueWithCATransform3D:scale];
};


static CaculateValueFunction FishLayerRotationXYFunc = CaculateValueFunction(f, s, t){
    CGFloat sp = [s floatValue];
    CGFloat tp = [t floatValue];
    
    struct FishMathStruct start,to,last;
    start.first = sp;
    to.first = tp;
    
    last = FishMath(start, to, f);
    CATransform3D scale = CATransform3DMakeRotation(last.first, 1.0, 1.0, 0);
    return [NSValue valueWithCATransform3D:scale];
};



//
//  property animation implementation
//
@interface FishPropertyAnimation ()

@property (nonatomic, copy) CaculateValueFunction caculateValueFunction;
@property (nonatomic, copy) NSString *realPath;

@end

@implementation FishPropertyAnimation

+(instancetype)animationWithKeyPath:(NSString *)path
{
    FishPropertyAnimation *animation = [[FishPropertyAnimation alloc] initWithKeyPath:path];
    return animation;
}

-(instancetype)initWithKeyPath:(NSString *)path
{
    self = [super init];
    if (self) {
        self.keyPath = path;
        self.realPath = [[path componentsSeparatedByString:@"."] lastObject];
        self.caculateValueFunction = [self getCaculateFunctionWithKeyPath:path];
    }
    return self;
}

//override

-(void)animationDidChangedFrameValue:(CGFloat)frameValue forObject:(id)object
{
    id value = self.caculateValueFunction(frameValue,self.fromValue,self.toValue);
    [object setValue:value forKeyPath:self.realPath];
}

-(CaculateValueFunction)getCaculateFunctionWithKeyPath:(NSString *)keyPath
{
    if (keyPath == kFishViewAlpha) {
        return FishOneDimentionalFunc;
    }else if (keyPath == kFishViewBackgroundColor){
        return FishColorFunc;
    }else if (keyPath == kFishViewCenter){
        return FishCenterFunc;
    }else if (keyPath == kFishViewSize){
        return FishBoundsSizeFunc;
    }else if (keyPath == kFishViewTransform){
        return FishViewRatationFunc;
    }else if (keyPath == kFishLayerCornerRadius){
        return FishOneDimentionalFunc;
    }else if (keyPath == kFishLayerOpacity){
        return FishOneDimentionalFunc;
    }else if (keyPath == kFishLayerScale){
        return FishLayerScaleFunc;
    }else if (keyPath == kFishLayerBorderWidth){
        return FishOneDimentionalFunc;
    }else if (keyPath == kFishLayerBackgroundColor){
        return FishOneDimentionalFunc;
    }else if (keyPath == kFishLayerRotationX){
        return FishLayerRotationXFunc;
    }else if (keyPath == kFishLayerRotationY){
        return FishLayerRotationYFunc;
    }else if (keyPath == kFishLayerRotationXY){
        return FishLayerRotationXYFunc;
    }else if (keyPath == kFishLayerRotationZ){
        return FishLayerRotationZFunc;
    }
    
    return nil;
}

@end
