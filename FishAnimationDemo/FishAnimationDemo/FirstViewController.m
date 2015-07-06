//
//  FirstViewController.m
//  FishAnimationDemo
//
//  Created by August on 15/6/25.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "FirstViewController.h"
#import "Fish.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UILabel *FirstView;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    CAAnimation
//    CAMediaTimingFunction
}

- (IBAction)testAnimation:(id)sender {
    
    FishPropertyAnimation *animation = [FishPropertyAnimation animationWithKeyPath:kFishViewCenter];
    animation.timingFunction = [FishTimingFunction timingFunctionWithType:FishAnimationTimingFunctionTypeBackEaseInOut];
    animation.duration = 1;
    animation.fromValue = [NSValue valueWithCGPoint:self.FirstView.center];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(100+arc4random()%200, 100+arc4random()%400)];
    
    FishPropertyAnimation *animation1 = [FishPropertyAnimation animationWithKeyPath:kFishViewBackgroundColor];
    animation1.timingFunction = [FishTimingFunction timingFunctionWithType:FishAnimationTimingFunctionTypeCubic];
    animation1.duration = 1;
    animation1.fromValue = self.FirstView.backgroundColor;
    animation1.toValue = [UIColor colorWithRed:(arc4random()%10)/10.0 green:(arc4random()%10)/10.0 blue:(arc4random()%10)/10.0 alpha:1];

    FishPropertyAnimation *animation2 = [FishPropertyAnimation animationWithKeyPath:kFishViewSize];
    animation2.timingFunction = [FishTimingFunction timingFunctionWithType:FishAnimationTimingFunctionTypeBounceEaseOut];
    animation2.duration = 0.5;
    animation2.fromValue = [NSValue valueWithCGSize:self.FirstView.bounds.size];
    animation2.toValue = [NSValue valueWithCGSize:CGSizeMake(10+arc4random()%200, 10+arc4random()%400)];
    
//    [self.FirstView fish_addAnimation:animation forKey:@"test"];
//    [self.FirstView fish_addAnimation:animation1 forKey:@"test1"];
//    [self.FirstView fish_addAnimation:animation2 forKey:@"test2"];
    
    FishAnimationGroup *group = [[FishAnimationGroup alloc] initWithAnimations:@[animation,animation1,animation2]];
    [self.FirstView fish_addAnimation:group forKey:@"test3"];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
