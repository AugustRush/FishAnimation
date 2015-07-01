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
    
}

- (IBAction)testAnimation:(id)sender {
    FishPropertyAnimation *animation = [FishPropertyAnimation animationWithKeyPath:kFishViewCenter];
    animation.timingFunction = [FishTimingFunction timingFunctionWithType:FishAnimationTimingFunctionTypeQuarticEaseInOut];
    animation.duration = 1;
    //    animation.fromValue = @(1);
    //    animation.toValue = @(0.5);
//    animation.fromValue = [UIColor greenColor];
//    animation.toValue = [UIColor redColor];
    animation.fromValue = [NSValue valueWithCGPoint:self.FirstView.center];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(100+arc4random()%200, 100+arc4random()%400)];
    //[self.FirstView fish_addAnimation:animation forKey:@"test"];
    [self.FirstView fish_addAnimation:animation forKey:@"test" completed:^{
        NSLog(@"the first animation is completed");
    }];
 
    
    FishPropertyAnimation *animation1 = [FishPropertyAnimation animationWithKeyPath:kFishViewBackgroundColor];
    animation1.timingFunction = [FishTimingFunction timingFunctionWithType:FishAnimationTimingFunctionTypeCubic];
    animation1.duration = 1;
    //    animation.fromValue = @(1);
    //    animation.toValue = @(0.5);
        animation1.fromValue = [UIColor greenColor];
        animation1.toValue = [UIColor redColor];
    //[self.FirstView fish_addAnimation:animation1 forKey:@"test1"];
    [self.FirstView fish_addAnimation:animation1 forKey:@"test1" completed:^{
        NSLog(@"the second animation is completed");
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
