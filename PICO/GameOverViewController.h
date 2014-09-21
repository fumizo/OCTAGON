//
//  GameOverViewController.h
//  PICO
//
//  Created by 山本文子 on 2014/08/13.
//  Copyright (c) 2014年 山本文子. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <AVFoundation/AVFoundation.h>
#import "ViewController.h"
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>

/*game center*/
#import <GameKit/GameKit.h>


@interface GameOverViewController : UIViewController<GKGameCenterControllerDelegate>{
    IBOutlet UILabel *gameScoreLabel;
    int score;
    int level;
    
    AVAudioPlayer *pon;
    AVAudioPlayer *flee;
    AVAudioPlayer *gooon;

    BOOL isSound;
    
    //ハイスコアの管理
    NSUserDefaults *userDefaultsHighScore;
    int highScore;
    
    NSString *coment;
    
    IBOutlet UILabel *highScoreLabel;
    IBOutlet UIImageView *highScoreImage;
    
    BOOL sounds; //optionで保存したBOOL
    UIButton *gamecenterButton;

}


-(IBAction)backToStart ;

- (IBAction)twitter ;
//- (IBAction)showRanking;
- (IBAction)home;

@property(nonatomic) int score;
@property(nonatomic) int level;

@end