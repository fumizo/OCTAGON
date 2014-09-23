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
    [self volume];
    [gooon play];
    if (sounds == true) {
        [gooon play];
    }
    

}

- (void)makeGamecenterButton{
    /*--ゲームセンターのボタン--*/
    //生成
    gamecenterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *img = [UIImage imageNamed:@"king2.png"];  // ボタンにする画像を生成する
    gamecenterButton.frame = CGRectMake(43, 19, 66, 52);
    [gamecenterButton setBackgroundImage:img forState:UIControlStateNormal];  // 画像をセットする
    // ボタンが押された時にhogeメソッドを呼び出す
    [gamecenterButton addTarget:self
                         action:@selector(authenticateLocalPlayer:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:gamecenterButton];

}

- (void) highScore{
    
    //スコアが今までのハイスコアよりも大きかったら、ハイスコアに保存する。
    if (score > highScore){
        
        [self makeGamecenterButton];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"congratulation!!" message:@"王冠をタップしてハイスコアをゲームセンターに登録しよう！" delegate:nil cancelButtonTitle:@"OK!" otherButtonTitles: nil];
        [alert show];
        
        
        NSLog(@"ハイスコアが更新されたよ");
        highScore = score;
        //high scoreの入れ物
        userDefaultsHighScore = [NSUserDefaults standardUserDefaults];
        // Int型で保存
        [userDefaultsHighScore setInteger:highScore forKey:@"HIGHSCORE"];
        // 保存する
        [userDefaultsHighScore synchronize];

//        //ハイスコアだったら、ハイスコアのラベルをぽんと大きくする
//        [UIView animateWithDuration:3.0f animations:^ {
//            //0.35秒かけてアニメーション。
//            highScoreLabel.transform =CGAffineTransformMakeScale(1.5,1.5);
//            highScoreImage.transform =CGAffineTransformMakeScale(1.5,1.5);//x方向に2倍拡大y方向に2拡大
//        } completion:^(BOOL finished){
//            //完了時のコールバック
//        }];
        
        
        //game centerに登録
        [self showRanking];

    }
    highScoreLabel.text = [NSString stringWithFormat:@"%d",highScore];
}


-(void)viewWillAppear:(BOOL)animated{
    userDefaultsHighScore = [NSUserDefaults standardUserDefaults];
    // int型で取得
    highScore = (int)[userDefaultsHighScore integerForKey:@"HIGHSCORE"];
    NSLog(@"high score is...%d",highScore);
    [self highScore];
    
    /*
    if (score < 10 ) {
    }else if (score >= 10 && score <=20) {
        coment = @"ふっ";
    }else if (score >= 20 && score <= 30){
        coment = @"まだまだじゃ";
    }else if (score >= 30 && score <= 45){
        coment = @"ほう...";
    }else if (score >= 45 && score <= 65){
        coment = @"ほほう！！";
    }else if (score >= 85 && score <= 100){
        coment = @"よいよい！よいぞ！";
    }else if(score >= 100){
        coment = @"ファンタスティック素晴らしい！！！！";
    }
     */
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
    CGRect rect = CGRectMake(0, 0, 320, 251);
    
    UIGraphicsBeginImageContext(rect.size);
    
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    capture = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    //    キャプチャした画像の範囲
    UIImageWriteToSavedPhotosAlbum(capture, nil, nil, nil);
    UIGraphicsEndImageContext();

    
    SLComposeViewController *twitterPostVC = [ SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
//    //投稿する文章
//    [twitterPostVC setInitialText:[NSString stringWithFormat:@"I WAS %dしゅ! #OCTAGON_JP \n %@ \n https://itunes.apple.com/jp/app/octagon-wanwo-shi-fenkerushuttingugemu/id913077665?mt=8",score,coment]];
//    [twitterPostVC addImage:capture];
    //投稿する文章
    [twitterPostVC setInitialText:[NSString stringWithFormat:@"I WAS %dしゅ! #OCTAGON_JP  \n https://itunes.apple.com/jp/app/octagon-wanwo-shi-fenkerushuttingugemu/id913077665?mt=8",score]];
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

- (IBAction)home{
    
    //gameoverになったことを通知
    NSNotification *s = [NSNotification notificationWithName:@"gameOver" object:self userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:s];

    //最初のview欲しいよっていう通知を送っとく
    NSNotification *home = [NSNotification notificationWithName:@"home" object:self userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:home];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



-(void) showRanking{
    
    //if文でGameCenterにログインしているかどうか確認してログインしていればハイスコアを送信する
    if ([GKLocalPlayer localPlayer].isAuthenticated ) {
        GKScore* score2 = [[GKScore alloc] initWithLeaderboardIdentifier:@"octagonjp"];
        score2.value = score;
        NSLog(@"%d",score);
        [GKScore reportScores:@[score2] withCompletionHandler:^(NSError *error) {
            if (error) {
                // エラーの場合
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"失敗しました。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
            }
        }];
    }
    
    GKGameCenterViewController *gcView = [GKGameCenterViewController new];
    if (gcView != nil)
    {
        gcView.gameCenterDelegate = self;
        gcView.viewState = GKGameCenterViewControllerStateLeaderboards;
        [self presentViewController:gcView animated:YES completion:nil];
    }
    
    
}

/* リーダーボードで完了タップ時の処理。前の画面に戻る。*/
- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*GameCenterにログインしているか確認処理
 * ログインしていなければログイン画面を表示*/
 -(void)authenticateLocalPlayer:(UIButton*)button
 {
 GKLocalPlayer* player = [GKLocalPlayer localPlayer];
 player.authenticateHandler = ^(UIViewController* ui, NSError* error )
 {
 if( nil != ui )
 {
 [self presentViewController:ui animated:YES completion:nil];
 }
 };
     [self showRanking];
     
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
