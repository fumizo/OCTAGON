//
//  OptionViewController.m
//  PICO
//
//  Created by 山本文子 on 2014/07/04.
//  Copyright (c) 2014年 山本文子. All rights reserved.
//

#import "OptionViewController.h"
//#import "ViewController.h"

@interface OptionViewController ()

@end

@implementation OptionViewController

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
    // Do any additional setup after loading the view.
    // AVAudioPlayerオブジェクトのボリュームは0.0〜1.0の間で指定する
    userDefaultSounds = [NSUserDefaults standardUserDefaults];
    // int型で取得
    isSound = [userDefaultSounds integerForKey:@"sound"];
    NSLog(@"bool sounds %d",isSound);
    
    if(isSound == YES){
        buttonImg = [UIImage imageNamed:@"octagon_sound_on.png"];  // ボタンにする画像を生成する
        [soundButtonOFF setBackgroundImage:buttonImg forState:UIControlStateNormal];  // 画像をセットする
    }else{
        buttonImg = [UIImage imageNamed:@"octagon_sound_off.png"];  // ボタンにする画像を生成する
        [soundButtonOFF setBackgroundImage:buttonImg forState:UIControlStateNormal];  // 画像をセットする
    }
    
    soundButtonOFF = [UIButton buttonWithType:UIButtonTypeCustom];
    [soundButtonOFF setBackgroundImage:buttonImg forState:UIControlStateNormal];  // 画像をセットする
    [soundButtonOFF addTarget:self
                     action:@selector(sound:) forControlEvents:UIControlEventTouchUpInside];
        soundButtonOFF.frame = CGRectMake(200, 71, 84, 84);   //位置、大きさ
    [self.view addSubview:soundButtonOFF];
    
    
    NSString *donPath = [[NSBundle mainBundle] pathForResource:@"N_don01" ofType:@"mp3"] ;
    NSURL *donUrl = [NSURL fileURLWithPath:donPath] ;
    don = [[AVAudioPlayer alloc] initWithContentsOfURL:donUrl error:nil] ;
}

//-(void)viewWillAppear:(BOOL)animated{
//    
//    // int型で取得
//    sounds =[userDefaultSounds integerForKey:@"sound"];
//    
//    if(sounds == NO){
//        buttonImg = [UIImage imageNamed:@"octagon_sound_on.png"];  // ボタンにする画像を生成する
//        [soundButtonOFF setBackgroundImage:buttonImg forState:UIControlStateNormal];  // 画像をセットする
//    }else{
//        buttonImg = [UIImage imageNamed:@"octagon_sound_off.png"];  // ボタンにする画像を生成する
//        [soundButtonOFF setBackgroundImage:buttonImg forState:UIControlStateNormal];  // 画像をセットする
//    }
//}


-(void)sound:(UIButton *)button{
    
    userDefaultSounds = [NSUserDefaults standardUserDefaults];
    
    
    //音がONになってたら押したときボリュームを０に。YESだったら逆。
    if (isSound == YES) {
        // Bool型で保存
        [userDefaultSounds setBool:NO forKey:@"sound"];
        // 保存する
        [userDefaultSounds synchronize];
        
        buttonImg = [UIImage imageNamed:@"octagon_sound_off.png"];  // ボタンにする画像を生成する
        [soundButtonOFF setBackgroundImage:buttonImg forState:UIControlStateNormal];  // 画像をセットする
//        [self.delegate volumeDown:volume];
        isSound = NO;
        
    }else if (isSound == NO){
        // Bool型で保存
        [userDefaultSounds setBool:YES forKey:@"sound"];
        // 保存する
        [userDefaultSounds synchronize];
        
        buttonImg = [UIImage imageNamed:@"octagon_sound_on.png"];  // ボタンにする画像を生成する
        [soundButtonOFF setBackgroundImage:buttonImg forState:UIControlStateNormal];  // 画像をセットする
//        [self.delegate volumeDown:volume];
        isSound = YES;
        [don play];
    }
}

- (IBAction)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//http://kesin.hatenablog.com/entry/20120908/1347079921
//画面遷移の直前に呼ばれる
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
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
