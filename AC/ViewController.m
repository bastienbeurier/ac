//
//  ViewController.m
//  AC
//
//  Created by Bastien Beurier on 5/4/16.
//  Copyright © 2016 Uber Technologies, Inc. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

#import "ViewController.h"

#import "BackgroundView.h"

static const float ImageSize = 200.0f;
static const float BorderWidth = 0.0f;

@interface ViewController ()

@property (nonatomic) AVAudioPlayer *player;
@property (nonatomic) UIButton *ac;
@property (nonatomic) BackgroundView *backgroundView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.backgroundView = ({
        BackgroundView *view = [[BackgroundView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - ImageSize / 2 - BorderWidth / 2, self.view.frame.size.height / 2 - ImageSize / 2 - BorderWidth / 2, ImageSize + BorderWidth, ImageSize + BorderWidth)];
        view.backgroundColor = [UIColor clearColor];
        view.layer.shadowColor = [UIColor blackColor].CGColor;
        view.layer.shadowOpacity = 0.4f;
        view.layer.shadowRadius = 3.0f;
        view.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
        view.alpha = 0.0f;
        view;
    });
    [self.view addSubview:self.backgroundView];
    
    self.ac = ({
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - ImageSize / 2, self.view.frame.size.height / 2 - ImageSize / 2, ImageSize, ImageSize)];
        [button setBackgroundImage:[UIImage imageNamed:@"ac"] forState:UIControlStateNormal];
        button.clipsToBounds = YES;
        button.layer.cornerRadius = ImageSize / 2;
        button.alpha = 0.0f;

        [button addTarget:self action:@selector(playSound) forControlEvents:UIControlEventTouchUpInside];
        
        button;
    });
    [self.view addSubview:self.ac];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:1.0f animations:^{
        self.backgroundView.alpha = 1.0f;
        self.ac.alpha = 1.0f;
    }];
}

- (IBAction)acTapped:(id)sender {
    [self playSound];
}

- (void)playSound
{
    if (self.player) {
        [self.player stop];
    }
    
    NSError* error;
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"ac" ofType:@".mp3"];
    NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:&error];
    if (error || ![self.player prepareToPlay]) {
        NSLog(@"%@",error);
    } else {
        [self.player play];
    }
}

@end
