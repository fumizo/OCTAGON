//
//  ViewController.h
//  PICO
//
//  Created by 山本文子 on 2014/06/27.
//  Copyright (c) 2014年 山本文子. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "DMCrookedSwipeView.h"
#import "OptionViewController.h"
#import "GameOverViewController.h"
#import <GameKit/GameKit.h>
#define MARBLE_WIDTH 50
#define MARBLE_HEIGHT 50

#import "MYBlurIntroductionView.h"


#import "ChangeRGB.h"
//http://tryworks-design.com/?p=2260
//webのカラーコードをiOS用に変換してくれる

@interface ViewController : UIViewController <DMCrookedSwipeViewDelegate,OptionViewControllerDelegate,GKGameCenterControllerDelegate> {
    //代わりにできるマンだよ
    
    IBOutlet UIImageView *octagon;
    
    int colorNum;  //色に番号つけといて、すみからーと合わせる
    int torf; //すみと丸が合ってたら１、間違ってたら０
    
    /*--音--*/
    AVAudioPlayer *tirin;
    AVAudioPlayer *don;
    AVAudioPlayer *dodon;
    AVAudioPlayer *pon;
    AVAudioPlayer *kan;
    
    /*---SCORE---*/
    IBOutlet UILabel *scoreLabel;
    int score;        //スコア
    int plusScore;    //連続で成功したときプラスするスコア
    
    /*--time--*/
    IBOutlet UILabel *gameTimerLabel;
    NSTimer *gameoverTimer;
    float countDown;
    float time;
    //制限時間からtimeを引いたのがcountDown
    BOOL firstTapFlag;       //最初にタップした瞬間からゲームをはじめる(gameoverのためのtimerを動かす)

    /*--最初のタップで消える画面--*/
    UIImageView *firstView;  //最初の画面
    UIButton *optionButton;

    /*--gameOver--*/
    UIImageView *gameoverView;  //gameoverでういーーんってでてくるやつ
    BOOL isGameOver;  //gameoverしたら丸をたさないようにする

    
    NSNumber *position;      //position
    int *intposition;        //nsnunberをintに変換
    
    BOOL isOk;        //あってたらYESにする
    
    int level;
    IBOutlet UILabel *lebelLabel;
    
    BOOL sounds; //optionで保存したBOOL
    
    /*
    ゲームオーバーになったよっていうのをback to startで通知してゲームオーバーになったらisgameoverフラグをyesにして、１回丸をつくったらまたnoにして、
    view didload でisStartをyesにして、１回タップで消したらnoにして、
    isStartか、isGameoverか分けてる。
     isStartだったら、全部つくって、isgameoverflagだったら、最初のビューと歯車はつくらない
     */
    
    BOOL isStart;          //アプリを起動して１回目のゲームなのか、二回以降なのか
    BOOL isGameOverFlag ;
    
    BOOL isHome ;
}


-(void)add:(CGRect)rect;

- (void) hanteiWithMarble:(DMCrookedSwipeView *)marbleForhantei; //わしこれできるよ

//-(void)volumeDown:(int)volume2; //わしこれできるよ
//
//@property(nonatomic) int volume;


//@end
//@interface userDefaultSounds: NSUserDefaults;
//@property BOOL sounds;

@end
