//
//  GameOverViewController.m
//  PICO
//
//  Created by 山本文子 on 2014/08/13.
//  Copyright (c) 2014年 山本文子. All rights reserved.
//

#import "GameOverViewController.h"

@interface GameOverViewController ()


@end

@implementation GameOverViewController
{
    UIImage *capture;

}

@synthesize score;
@synthesize level;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self volume]; //音
    
    // Do any additional setup after loading the view.
    NSLog(@"受け渡されたscoreは%d",score);
    NSLog(@"level is %d幕",level);

    gameScoreLabel.text = [NSString stringWithFormat:@"%d",score];
    
    NSError *error = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
    
    //ぽん！
    NSString *ponPath = [[NSBundle mainBundle] pathForResource:@"pon_octagon" ofType:@"mp3"] ;
    NSURL *ponUrl = [NSURL fileURLWithPath:ponPath] ;
    pon = [[AVAudioPlayer alloc] initWithContentsOfURL:ponUrl error:nil] ;
    //ふりーーー
    NSString *fleePath = [[NSBundle mainBundle] pathForResource:@"flee1" ofType:@"mp3"] ;
    NSURL *fleeUrl = [NSURL fileURLWithPath:fleePath] ;
    flee = [[AVAudioPlayer alloc] initWithContentsOfURL:fleeUrl error:nil] ;
    //ごおおおん
    NSString *gooonPath = [[NSBundle mainBundle] pathForResource:@"gooon" ofType:@"mp3"] ;
    NSURL *gooonUrl = [NSURL fileURLWithPath:gooonPath] ;
    gooon = [[AVAudioPlayer alloc] initWithContentsOfURL:gooonUrl error:nil] ;
    
    /*
    //音についての通知
    NSNotificationCenter *sound = [NSNotificationCenter defaultCenter];
    [sound addObserver:self selector:@selector(sound:) name:@"sound" object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:sound];

     */
    [self volume];[gooon play];
    if (sounds == true) {
        [gooon play];
    }
   
    
}

- (void) highScore{
    
    //スコアが今までのハイスコアよりも大きかったら、ハイスコアに保存する。
    if (score > highScore){
        
        NSLog(@"ハイスコアが更新されたよ");
        
        highScore = score;
        
        
        //high scoreの入れ物
        userDefaultsHighScore = [NSUserDefaults standardUserDefaults];
        // Int型で保存
        [userDefaultsHighScore setInteger:highScore forKey:@"HIGHSCORE"];
        
        // 保存する
        [userDefaultsHighScore synchronize];
    }
    highScoreLabel.text = [NSString stringWithFormat:@"%d",highScore];
}


-(void)viewWillAppear:(BOOL)animated{
    userDefaultsHighScore = [NSUserDefaults standardUserDefaults];
    // int型で取得
    highScore = (int)[userDefaultsHighScore integerForKey:@"HIGHSCORE"];
    NSLog(@"high score is...%d",highScore);
    [self highScore];
    
    
    if (score < 10 ) {
    }else if (score >= 10 && score <=20) {
        coment = @"";
    }else if (score >= 20 && score <= 30){
        coment = @"";
    }else if (score >= 30 && score <= 45){
        coment = @"";
    }else if (score >= 45 && score <= 65){
        coment = @"";
    }else if (score >= 85 && score <= 100){
        coment = @"";
    }else if(score >= 100){
        coment = @"";
    }

}

- (void)volume{
    
    NSUserDefaults *userDefaultSounds= [NSUserDefaults standardUserDefaults];

    // BOOL型で取得
    sounds = [userDefaultSounds boolForKey:@"sound"];
    NSLog(@"結果画面でvolume is...%d",sounds);
    if(sounds == YES){
        pon.volume *= 1;
        flee.volume *= 1;
        gooon.volume *= 1;
    }else{
        pon.volume *= 0;
        flee.volume *= 0;
        gooon.volume *= 0;
    }
}

-(IBAction)backToStart{
//    if(isSound == NO ) pon.volume = 0;
    
    [pon play];
    
    //gameoverになったことを通知
    NSNotification *s = [NSNotification notificationWithName:@"gameOver" object:self userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:s];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)twitter{
//    if(isSound == NO ) flee.volume = 0;
    
    [flee play];
    
    //    キャプチャする範囲の指定
    CGRect rect = CGRectMake(0, 287, 320, 226);
    
    UIGraphicsBeginImageContext(rect.size);
    
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    capture = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    //    キャプチャした画像の範囲
    UIImageWriteToSavedPhotosAlbum(capture, nil, nil, nil);
    UIGraphicsEndImageContext();

    
    SLComposeViewController *twitterPostVC = [ SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    //投稿する文章
    [twitterPostVC setInitialText:[NSString stringWithFormat:@"I WAS %dしゅ! #OCTAGON_JP \n %@ \n https://itunes.apple.com/jp/app/octagon-wanwo-shi-fenkerushuttingugemu/id913077665?mt=8",score,coment]];
    [twitterPostVC addImage:capture];

    //アラート
    [twitterPostVC setCompletionHandler:^ (SLComposeViewControllerResult result) {
        if(result == SLComposeViewControllerResultDone ){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"投稿を完了しました！" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"投稿に失敗しました。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];

        }
        }];
    
    //tweetする
    [self presentViewController:twitterPostVC animated:YES completion:nil];
    
}

/**
 * GameCenterにログインしているか確認処理
 * ログインしていなければログイン画面を表示*/
- (void)authenticateLocalPlayer
{
    GKLocalPlayer* player = [GKLocalPlayer localPlayer];
    player.authenticateHandler = ^(UIViewController* ui, NSError* error )
    {
        if( nil != ui )
        {
            [self presentViewController:ui animated:YES completion:nil];
        }
    };
}

- (IBAction)signinToGameCenter{
    //gamecenter 画面を読み込む
    [self authenticateLocalPlayer];
    
    //if文でGameCenterにログインしているかどうか確認してログインしていればハイスコアを送信する
    if ([GKLocalPlayer localPlayer].isAuthenticated ) {
        GKScore* score2 = [[GKScore alloc] initWithLeaderboardIdentifier:@"octagonjp"];
        score2.value = highScore;
        [GKScore reportScores:@[score2] withCompletionHandler:^(NSError *error) {
            if (error) {
                // エラーの場合
            }
        }];
    }
}

-(IBAction) showRanking{
        
    GKGameCenterViewController *gcView = [GKGameCenterViewController new];
    if (gcView != nil)
    {
        gcView.gameCenterDelegate = self;
        gcView.viewState = GKGameCenterViewControllerStateLeaderboards;
        [self presentViewController:gcView animated:YES completion:nil];
    }
}
/**
 * リーダーボードで完了タップ時の処理
 * 前の画面に戻る
 */
- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
