//
//  FishAnimator.m
//  FishAnimationDemo
//
//  Created by August on 15/6/26.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "FishAnimator.h"
#import <QuartzCore/QuartzCore.h>

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
    NSLog(@"render %@ %@",_animationDict,_animateList.allObjects);
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
        CFDictionarySetValue(_animationDict, (__bridge void *)object, (__bridge void *)[NSMutableDictionary dictionaryWithObject:animation forKey:key]);
    }else{
        dict[key] = animation;
    }
    [_animateList addObject:animation];
    [self updateDisplayLinkState];
}

-(void)removeAnimationForObject:(id)object Key:(NSString *)key
{
    if (!key || !object) {
        return;
    }
    NSMutableDictionary *dict = CFDictionaryGetValue(_animationDict, (__bridge void *)object);
    [dict removeObjectForKey:key];
    [self updateDisplayLinkState];
}

-(void)removeAllAnimationsForObject:(id)object
{

}

@end
