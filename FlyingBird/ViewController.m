//
//  ViewController.m
//  FlyingBird
//
//  Created by admin on 8/1/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
{
    UIImageView* bird;
    AVAudioPlayer* player;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self drawJungle];
    [self addBird];
    [self flyUpAndDown];
    NSURL* urlSound = [[NSBundle mainBundle] URLForResource:@"ChaoMao" withExtension:@"mp3"];
    [self soundFlyingBird:urlSound];
}

- (void) soundFlyingBird:(NSURL*) url{
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    player.numberOfLoops = -1;
    [player play];
}

- (void) drawJungle{
    UIImageView* background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jungle.jpg"]];
    background.frame = self.view.bounds;
    background.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:background];
}

- (void) addBird{
    bird = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 110, 68)];
    bird.animationImages = @[[UIImage imageNamed:@"bird0.png"],
                             [UIImage imageNamed:@"bird1.png"],
                             [UIImage imageNamed:@"bird2.png"],
                             [UIImage imageNamed:@"bird3.png"],
                             [UIImage imageNamed:@"bird4.png"],
                             [UIImage imageNamed:@"bird5.png"]
                             ];
    bird.animationRepeatCount = -1; //forever loop
    bird.animationDuration = 1; // khoảng thời gian chạy animation
    [self.view addSubview:bird];
    [bird startAnimating];
}

- (void) flyUpAndDown{
    bird.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:5 animations:^{
        bird.center = CGPointMake(self.view.bounds.size.width, self.view.bounds.size.height);
    }completion:^(BOOL finished){
        bird.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(-1, 1),
                                                 CGAffineTransformMakeRotation(M_PI_4));
        [UIView animateWithDuration:5 animations:^{
            bird.center = CGPointMake(0, 0);
        }completion:^(BOOL finished){
            [self flyUpAndDown];
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
