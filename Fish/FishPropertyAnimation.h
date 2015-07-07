//
//  FishPropertyAnimation.h
//  FishAnimationDemo
//
//  Created by August on 15/7/1.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "FishAnimation.h"

@interface FishPropertyAnimation : FishAnimation

@property (nonatomic, copy) NSString *keyPath;
@property id fromValue;
@property id toValue;

//use the provided constants to refrence.
+(instancetype)animationWithKeyPath:(NSString *)path;
-(instancetype)initWithKeyPath:(NSString *)path;

@end


//////view animate key path constants

extern NSString *const kFishViewAlpha;
extern NSString *const kFishViewBackgroundColor;
extern NSString *const kFishViewCenter;
extern NSString *const kFishViewSize;
extern NSString *const kFishViewTransform;

/////////layer animate key path constants

extern NSString *const kFishLayerCornerRadius;