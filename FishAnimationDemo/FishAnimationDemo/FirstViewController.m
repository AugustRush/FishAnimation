//
//  FirstViewController.m
//  FishAnimationDemo
//
//  Created by August on 15/6/25.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "FirstViewController.h"
#import "Fish.h"
#import <math.h>

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UILabel *FirstView;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    CAAnimation
    
//    [UIView animateWithDuration:<#(NSTimeInterval)#> delay:<#(NSTimeInterval)#> usingSpringWithDamping:<#(CGFloat)#> initialSpringVelocity:<#(CGFloat)#> options:<#(UIViewAnimationOptions)#> animations:<#^(void)animations#> completion:<#^(BOOL finished)completion#>];

  
    //test chainable
    self.view.moveCenter(CGPointMake(231, 100),FishAnimationTimingFunctionTypeCubic).moveCenter(CGPointMake(10, 10),FishAnimationTimingFunctionTypeLinear);
}

- (IBAction)testAnimation:(id)sender {
    
    FishSpringAnimation *animation = [FishSpringAnimation animationWithKeyPath:kFishViewCenter];
    animation.duration = 1;
    animation.fromValue = [NSValue valueWithCGPoint:self.FirstView.center];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(100+arc4random()%200, 100+arc4random()%400)];
    
    FishSpringAnimation *animation1 = [FishSpringAnimation animationWithKeyPath:kFishViewBackgroundColor];
    animation1.duration = 1.5;
    animation1.damping = 60;
    animation1.mass = 2;
    animation1.velocity = 50;
    animation1.fromValue = self.FirstView.backgroundColor;
    animation1.toValue = [UIColor colorWithRed:(arc4random()%10)/10.0 green:(arc4random()%10)/10.0 blue:(arc4random()%10)/10.0 alpha:1];

//    FishSpringAnimation *animation2 = [FishSpringAnimation animationWithKeyPath:kFishViewSize];
//    animation2.duration = 0.5;
//    animation2.mass = 1;
//    animation2.damping = 40;
//    animation2.velocity = 40;
//    animation2.fromValue = [NSValue valueWithCGSize:self.FirstView.bounds.size];
//    animation2.toValue = [NSValue valueWithCGSize:CGSizeMake(10+arc4random()%200, 10+arc4random()%400)];
    
//    FishPropertyAnimation *animation3 = [FishPropertyAnimation animationWithKeyPath:kFishViewTransform];
//    animation3.timingFunction = [FishTimingFunction timingFunctionWithType:FishAnimationTimingFunctionTypeLinear];
//    animation3.duration = 1;
//    animation3.fromValue = [NSValue valueWithCGAffineTransform:self.FirstView.transform];
//    animation3.toValue = [NSValue valueWithCGAffineTransform:CGAffineTransformRotate(self.FirstView.transform, M_PI/2)];
    
    FishSpringAnimation *animation4 = [FishSpringAnimation animationWithKeyPath:kFishLayerCornerRadius];
    animation4.duration = 1;
    animation4.fromValue = @(self.FirstView.layer.cornerRadius);
    animation4.toValue = @(MIN(CGRectGetWidth(self.FirstView.bounds), CGRectGetHeight(self.FirstView.bounds))/2);
    
    [self.FirstView fish_addAnimation:animation forKey:@"test"];
    [self.FirstView fish_addAnimation:animation1 forKey:@"test1"];
//    [self.FirstView fish_addAnimation:animation2 forKey:@"test2"];
    [self.FirstView fish_addAnimation:animation4 forKey:@"test4"];
    
//    FishAnimationGroup *group = [[FishAnimationGroup alloc] initWithAnimations:@[animation,animation1,animation2,animation4]];
//    [self.FirstView fish_addAnimation:group forKey:@"test3"];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
