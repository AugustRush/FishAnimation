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
    animation.fromValue = [NSValue valueWithCGPoint:self.FirstView.center];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(100+arc4random()%200, 100+arc4random()%400)];
    [self.FirstView fish_addAnimation:animation forKey:@"test"];

    
    FishPropertyAnimation *animation1 = [FishPropertyAnimation animationWithKeyPath:kFishViewBackgroundColor];
    animation1.timingFunction = [FishTimingFunction timingFunctionWithType:FishAnimationTimingFunctionTypeCubic];
    animation1.duration = 1;

    animation1.fromValue = [UIColor colorWithWhite:(arc4random()%10)/10.0 alpha:1];
    animation1.toValue = [UIColor colorWithRed:(arc4random()%10)/10.0 green:(arc4random()%10)/10.0 blue:(arc4random()%10)/10.0 alpha:1];
    [self.FirstView fish_addAnimation:animation1 forKey:@"test1"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
