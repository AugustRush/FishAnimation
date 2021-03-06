//
//  FishAnimator.m
//  FishAnimationDemo
//
//  Created by August on 15/6/26.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "FishAnimator.h"
#import <QuartzCore/QuartzCore.h>

@class FishAnimation;
@interface FishAnimationItem : NSObject

@property (nonatomic, weak) id object;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, strong) FishAnimation *animation;

@end

@implementation FishAnimationItem

@end

static CFHashCode pointerHash(const void *object){
    return (CFHashCode)(object);
}

static Boolean pointerEqual(const void *object1,const void *object2){
    return object1 == object2;
}

/**
 *  animator
 */
@implementation FishAnimator
{
    CADisplayLink *_displayLink;
    CFMutableDictionaryRef _animationDict;
    NSHashTable *_animateList;
}

+(instancetype)shareAnimator
{
    static FishAnimator *_animator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _animator = [[FishAnimator alloc] init];
    });
    return _animator;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

#pragma mark - private methods

-(void)setUp
{
    CFDictionaryKeyCallBacks keyCallBacks = kCFTypeDictionaryKeyCallBacks;
    keyCallBacks.retain = NULL;
    keyCallBacks.release = NULL;
    keyCallBacks.hash = pointerHash;
    keyCallBacks.equal = pointerEqual;
    
     CFDictionaryValueCallBacks valueCallBacks = kCFTypeDictionaryValueCallBacks;
    _animationDict = CFDictionaryCreateMutable(NULL, 5, &keyCallBacks, &valueCallBacks);
    
    _animateList = [NSHashTable weakObjectsHashTable];
    
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(render)];
    _displayLink.paused = YES;
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

-(void)render
{
    NSLog(@"all niamtions is %@",_animateList.allObjects);
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    if (_animateList.allObjects.count > 0) {
        for (FishAnimationItem *item in _animateList.allObjects) {
            if (![item.animation isCompleted]) {
                [item.animation renderforObject:item.object];
            }else{
                [self removeAnimationForObject:item.object Key:item.key];
            }
        }
    }
    
    [CATransaction commit];
}

-(void)updateDisplayLinkState
{
    _displayLink.paused = _animateList.allObjects.count > 0?NO:YES;
}

#pragma mark - public methods

-(void)addAnimation:(FishAnimation *)animation forObject:(id)object key:(NSString *)key
{
    if (!animation && !object) {
        return;
    }
    if (!key) {
        key = [[NSUUID UUID] UUIDString];
    }
    NSMutableDictionary *dict = CFDictionaryGetValue(_animationDict, (__bridge void *)object);
    if (dict == nil) {
        dict = @{}.mutableCopy;
        CFDictionarySetValue(_animationDict, (__bridge void *)object, (__bridge void *)dict);
    }else{
        FishAnimationItem *item = dict[key];
        if (item.object == object) {
            [self removeAnimationForObject:object Key:key];
        }
    }
    FishAnimationItem *item = [FishAnimationItem new];
    item.object = object;
    item.key = key;
    item.animation = animation;
    
    dict[key] = item;
    
    [_animateList addObject:item];
    [self updateDisplayLinkState];
}

-(void)removeAnimationForObject:(id)object Key:(NSString *)key
{
    if (!key || !object) {
        return;
    }
    NSMutableDictionary *dict = CFDictionaryGetValue(_animationDict, (__bridge void *)object);
    FishAnimationItem *item = [dict objectForKey:key];
    [_animateList removeObject:item];
    [dict removeObjectForKey:key];
    [self updateDisplayLinkState];
}

-(void)removeAllAnimationsForObject:(id)object
{
    if (object != nil) {
        NSMutableDictionary *dict = CFDictionaryGetValue(_animationDict, (__bridge void *)object);
        [dict removeAllObjects];
        [self updateDisplayLinkState];
    }
}

@end
