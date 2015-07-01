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

+(instancetype)animationWithKeyPath:(NSString *)path;

@end
