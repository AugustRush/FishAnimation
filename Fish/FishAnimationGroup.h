//
//  FishAnimationGroup.h
//  FishAnimationDemo
//
//  Created by August on 15/6/26.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "FishAnimation.h"

@interface FishAnimationGroup : FishAnimation

@property (nonatomic, strong, readonly) NSArray *animations;

//
//delay can be a section animation control, so group animation deley is invalidate
///
//@property (nonatomic, assign) CFTimeInterval delay;

-(instancetype)initWithAnimations:(NSArray *)animations;

@end
