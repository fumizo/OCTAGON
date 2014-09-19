//
//  OptionViewController.h
//  PICO
//
//  Created by 山本文子 on 2014/07/04.
//  Copyright (c) 2014年 山本文子. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol  OptionViewControllerDelegate

-(void)volumeDown:(int)volume2;  //

@end

@interface OptionViewController : UIViewController{
    
//    int volume ;
    BOOL isSound;
    
    UIButton *soundButtonOFF;
    UIImage *buttonImg;
    
    AVAudioPlayer *don;
    
    NSUserDefaults *userDefaultSounds;
    BOOL sounds;
    
}

@property (nonatomic,assign) id<OptionViewControllerDelegate> delegate;  //ここにかわりにやってくれる人をいれてね

- (IBAction)back;

@end
