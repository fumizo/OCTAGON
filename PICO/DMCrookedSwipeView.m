//
//  DMCrookedSwipeView.m
//  DMCrookedSwiper
//
//  Created by Master on 2014/06/15.
//  Copyright (c) 2014年 jp.co.mappy. All rights reserved.
//

#import "DMCrookedSwipeView.h"

@implementation DMCrookedSwipeView

@synthesize torf;

@synthesize colorNum;

@synthesize score;
@synthesize plusScore;

 
#pragma mark - init
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        /* -- ビューの作成 -- */
        [self makeView];
    }
    return self;
}

#pragma mark - GestureView

- (void)makeView
{
    //動く速度
    moveX = 5;
    moveY = 5;
    
    /* 時計回りに45度回転 */
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI/4);
    [self setTransform:transform];
    
    /* 左上スワイプ */
    UISwipeGestureRecognizer *swipeLeftGesture =
    [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeLeft:)];
    swipeLeftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:swipeLeftGesture];
    
    /* 右上スワイプ */
    UISwipeGestureRecognizer *swipeUpwardGesture =
    [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeUpward:)];
    swipeUpwardGesture.direction = UISwipeGestureRecognizerDirectionUp;
    [self addGestureRecognizer:swipeUpwardGesture];
    
    /* 左下スワイプ */
    UISwipeGestureRecognizer *swipeDownwardGesture =
    [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeDownward:)];
    swipeDownwardGesture.direction = UISwipeGestureRecognizerDirectionDown;
    [self addGestureRecognizer:swipeDownwardGesture];
    
    
    /* 右下スワイプ */
    UISwipeGestureRecognizer *swipeRightGesture =
    [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRight:)];
    swipeRightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:swipeRightGesture];
}

#pragma mark - Gesture

/*----角の色----*/
//右上　yellow (3)
//右下　pink   (2)
//左上　green  (1)
//左下　blue   (0)

/*===notifivcationについて===*/
/*ここは、丸のためのUIImageViewクラスなので、ここで、合っているか間違っているかを判定して、UIViewControllerの方に通知しています*/

- (void)swipeUpward:(UISwipeGestureRecognizer *)sender
{
    NSLog(@"右上");
    if([_objestColor isEqual:@"yellow"]){
        torf = 1;
        
        //合ってたよっていう通知を送る
        NSNotification *s = [NSNotification notificationWithName:@"hoge" object:self userInfo:@{@"score": @"1"}];
        //@{@"score": @"a", @"key": @"aa"}
        [[NSNotificationCenter defaultCenter] postNotification:s];
        //[self atteruyo];
        
    }else{
        torf = 0;
        
        //まちがってたよっていう通知を送る
        NSNotification *s = [NSNotification notificationWithName:@"hoge" object:self userInfo:@{@"score": @"0"}];
        [[NSNotificationCenter defaultCenter] postNotification:s];
    }

    NSDictionary *dic = [NSDictionary dictionaryWithObject:sender.view forKey:@"view"];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(moveMarbles:) userInfo:dic repeats:YES];
    [timer fire];
    
    sender.view.tag = 1;
 

    // 通知の実行(通知名は"Position")
    // 通知先にデータを渡す場合はuserInfoにデータを指定
    //objectPositionはマーブルをつくるときにつけてる。あなたは左上さんですよ〜。
    // _ は self と同じ意味
    if([_objectPosition  isEqual: @"LeftUp"]){
        NSNotification *n = [NSNotification notificationWithName:@"hoge" object:self userInfo:@{@"key": @0}];
        [[NSNotificationCenter defaultCenter] postNotification:n];
    }else if ([_objectPosition  isEqual: @"RightUp"]){
        NSNotification *n = [NSNotification notificationWithName:@"hoge" object:self userInfo:@{@"key": @1}];
        [[NSNotificationCenter defaultCenter] postNotification:n];
    }else if ([_objectPosition  isEqual: @"LeftDown"]){
        NSNotification *n = [NSNotification notificationWithName:@"hoge" object:self userInfo:@{@"key": @2}];
        [[NSNotificationCenter defaultCenter] postNotification:n];
    }else if ([_objectPosition  isEqual: @"RightDown"]){
        NSNotification *n = [NSNotification notificationWithName:@"hoge" object:self userInfo:@{@"key": @3}];
        [[NSNotificationCenter defaultCenter] postNotification:n];
    }
}

/*======notification======*/
/*このクラスはUIImageView(丸たち)のクラスなので、合っているか間違っているかを、ここで判定して
 UIViewControllerのほうのクラスに通知しています。*/

- (void)swipeRight:(UISwipeGestureRecognizer *)sender
{
    
    NSLog(@"右下");
    
    if([_objestColor isEqual:@"pink"]){
        torf = 1;
        
        //合ってたよっていう通知を送る
        NSNotification *s = [NSNotification notificationWithName:@"hoge" object:self userInfo:@{@"score": @"1"}];
        [[NSNotificationCenter defaultCenter] postNotification:s];

    }else{
//        //間違えたっていう通知を送る
//        NSNotification *dame = [NSNotification notificationWithName:@"hoge" object:self userInfo:@{@"dame": @"1"}];
//        [[NSNotificationCenter defaultCenter] postNotification:dame];
//
        torf = 0;
    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:sender.view forKey:@"view"];
    NSLog(@"%@",dic);
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(moveMarbles:) userInfo:dic repeats:YES];
    [timer fire];
    
    sender.view.tag = 2;
    
    // 通知の実行(通知名は"Position")
    // 通知先にデータを渡す場合はuserInfoにデータを指定
    //objectPositionはマーブルをつくるときにつけてる。あなたは左上さんですよ〜。
    // _ は self と同じ意味
    if([_objectPosition  isEqual: @"LeftUp"]){
        NSNotification *n = [NSNotification notificationWithName:@"hoge" object:self userInfo:@{@"key": @0}];
        [[NSNotificationCenter defaultCenter] postNotification:n];
    }else if ([_objectPosition  isEqual: @"RightUp"]){
        NSNotification *n = [NSNotification notificationWithName:@"hoge" object:self userInfo:@{@"key": @1}];
        [[NSNotificationCenter defaultCenter] postNotification:n];
    }else if ([_objectPosition  isEqual: @"LeftDown"]){
        NSNotification *n = [NSNotification notificationWithName:@"hoge" object:self userInfo:@{@"key": @2}];
        [[NSNotificationCenter defaultCenter] postNotification:n];
    }else if ([_objectPosition  isEqual: @"RightDown"]){
        NSNotification *n = [NSNotification notificationWithName:@"hoge" object:self userInfo:@{@"key": @3}];
        [[NSNotificationCenter defaultCenter] postNotification:n];
    }

}

- (void)swipeDownward:(UISwipeGestureRecognizer *)sender
{
    NSLog(@"左下");

    if([_objestColor isEqual:@"blue"]){
        torf = 1;
        
        //合ってたよっていう通知を送る
        NSNotification *s = [NSNotification notificationWithName:@"hoge" object:self userInfo:@{@"score": @"1"}];
        [[NSNotificationCenter defaultCenter] postNotification:s];

    }else{
        torf = 0;
        //まちがってたよっていう通知を送る
        NSNotification *s = [NSNotification notificationWithName:@"hoge" object:self userInfo:@{@"score": @"0"}];
        [[NSNotificationCenter defaultCenter] postNotification:s];
    }
    NSDictionary *dic = [NSDictionary dictionaryWithObject:sender.view forKey:@"view"];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(moveMarbles:)
                                                    userInfo:dic repeats:YES];
    //0.01秒間隔で  //呼び出すよself  //「:」自分自身渡す  //moveMarblesっていうメソッドを呼び出してる
    [timer fire];
    
    sender.view.tag = 3;
    
    
    // 通知の実行(通知名は"Position")
    // 通知先にデータを渡す場合はuserInfoにデータを指定
    //objectPositionはマーブルをつくるときにつけてる。あなたは左上さんですよ〜。
    // _ は self と同じ意味
    if([_objectPosition  isEqual: @"LeftUp"]){
    NSNotification *n = [NSNotification notificationWithName:@"hoge" object:self userInfo:@{@"key": @0}];
        [[NSNotificationCenter defaultCenter] postNotification:n];
    }else if ([_objectPosition  isEqual: @"RightUp"]){
        NSNotification *n = [NSNotification notificationWithName:@"hoge" object:self userInfo:@{@"key": @1}];
        [[NSNotificationCenter defaultCenter] postNotification:n];
    }else if ([_objectPosition  isEqual: @"LeftDown"]){
        NSNotification *n = [NSNotification notificationWithName:@"hoge" object:self userInfo:@{@"key": @2}];
        [[NSNotificationCenter defaultCenter] postNotification:n];
    }else if ([_objectPosition  isEqual: @"RightDown"]){
        NSNotification *n = [NSNotification notificationWithName:@"hoge" object:self userInfo:@{@"key": @3}];
        [[NSNotificationCenter defaultCenter] postNotification:n];
    }
}


- (void)swipeLeft:(UISwipeGestureRecognizer *)sender
{
    NSLog(@"左上");
    
    if([_objestColor isEqual:@"green"]){
        
        torf = 1;
        //間違ってたら０、合ってたら１を通知する
        //合ってたよっていう通知を送る
        NSNotification *s = [NSNotification notificationWithName:@"hoge" object:self userInfo:@{@"score": @"1"}];
        [[NSNotificationCenter defaultCenter] postNotification:s];
        
    }else{
        torf = 0;
        //まちがってたよっていう通知を送る
        NSNotification *s = [NSNotification notificationWithName:@"hoge" object:self userInfo:@{@"score": @"0"}];
        [[NSNotificationCenter defaultCenter] postNotification:s];
    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:sender.view forKey:@"view"];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(moveMarbles:) userInfo:dic repeats:YES];
    [timer fire];
    
    sender.view.tag = 4;
    
    
    // 通知の実行(通知名は"Position")
    // 通知先にデータを渡す場合はuserInfoにデータを指定
    //objectPositionはマーブルをつくるときにつけてる。あなたは左上さんですよ〜。
    // _ は self と同じ意味
    if([_objectPosition  isEqual: @"LeftUp"]){
        NSNotification *n = [NSNotification notificationWithName:@"hoge" object:self userInfo:@{@"key": @0}];
        [[NSNotificationCenter defaultCenter] postNotification:n];
    }else if ([_objectPosition  isEqual: @"RightUp"]){
        NSNotification *n = [NSNotification notificationWithName:@"hoge" object:self userInfo:@{@"key": @1}];
        [[NSNotificationCenter defaultCenter] postNotification:n];
    }else if ([_objectPosition  isEqual: @"LeftDown"]){
        NSNotification *n = [NSNotification notificationWithName:@"hoge" object:self userInfo:@{@"key": @2}];
        [[NSNotificationCenter defaultCenter] postNotification:n];
    }else if ([_objectPosition  isEqual: @"RightDown"]){
        NSNotification *n = [NSNotification notificationWithName:@"hoge" object:self userInfo:@{@"key": @3}];
        [[NSNotificationCenter defaultCenter] postNotification:n];
    }
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    /* ジェスチャーの同時認識を可能に */
    return YES;
}


- (void)moveMarbles:(NSTimer *)timer
{
    NSDictionary *dic = [timer userInfo];
    
    swipedView = [dic objectForKey:@"view"];
    
    switch ( torf ) {
        case 0:
            self.userInteractionEnabled = NO;    //１回触ったものにはもうジェスチャーを許可しない
            
            if (swipedView.tag == 1) {
                swipedView.center = CGPointMake(swipedView.center.x + moveX, swipedView.center.y - moveY);
                // ballと横壁の当たり判定
                if(swipedView.center.x - swipedView.bounds.size.width / 2 < 10) moveX = - moveX;
                if(swipedView.center.x + swipedView.bounds.size.width / 2 > 310) moveX = - moveX;
                
                //上下の壁との当たり判定
                if(swipedView.center.y - swipedView.bounds.size.height / 2 < 167) moveY = - moveY;
                if(swipedView.center.y + swipedView.bounds.size.height / 2 > 467) moveY = - moveY;
                
            }else if (swipedView.tag == 2){
                swipedView.center = CGPointMake(swipedView.center.x + moveX, swipedView.center.y + moveY);
                // ballと横壁の当たり判定
                if(swipedView.center.x - swipedView.bounds.size.width / 2 < 10) moveX = - moveX;
                if(swipedView.center.x + swipedView.bounds.size.width / 2 > 310) moveX = - moveX;
                
                //上下の壁との当たり判定
                if(swipedView.center.y - swipedView.bounds.size.height / 2 < 167) moveY = - moveY;
                if(swipedView.center.y + swipedView.bounds.size.height / 2 > 467) moveY = - moveY;
                
            }else if (swipedView.tag == 3){
                swipedView.center = CGPointMake(swipedView.center.x - moveX, swipedView.center.y + moveY);
                // ballと横壁の当たり判定
                if(swipedView.center.x - swipedView.bounds.size.width / 2 < 10) moveX = - moveX;
                if(swipedView.center.x + swipedView.bounds.size.width / 2 > 310) moveX = - moveX;
                
                //上下の壁との当たり判定
                if(swipedView.center.y - swipedView.bounds.size.height / 2 < 167) moveY = - moveY;
                if(swipedView.center.y + swipedView.bounds.size.height / 2 > 467) moveY = - moveY;
                
            }else if (swipedView.tag == 4){
                swipedView.center = CGPointMake(swipedView.center.x - moveX, swipedView.center.y - moveY);
                // ballと横壁の当たり判定
                if(swipedView.center.x - swipedView.bounds.size.width / 2 < 10) moveX = - moveX;
                if(swipedView.center.x + swipedView.bounds.size.width / 2 > 310) moveX = - moveX;
                
                //上下の壁との当たり判定
                if(swipedView.center.y - swipedView.bounds.size.height / 2 < 167) moveY = - moveY;
                if(swipedView.center.y + swipedView.bounds.size.height / 2 > 467) moveY = - moveY;
            }
            
            break;
        
        case 1:
            self.userInteractionEnabled = NO;    //１回触ったものにはもうジェスチャーを許可しない
            
            if (swipedView.tag == 1) {
               
                [UIView animateWithDuration:0.7f animations:^{
                    //animateWithDurationがアニメーションの速度
                    // アニメーションをする処理
                    swipedView.alpha = 0;

                    swipedView.center = CGPointMake(310, 134);
                                 }
                                 completion:^(BOOL finished){
                                     // アニメーションが終わった後実行する処理
                                    //  NSLog(@"hoge1");
                                     //[swipedView removeFromSuperview];
                                 }];
                
            }else if (swipedView.tag == 2){
                [UIView animateWithDuration:0.7f animations:^{
                    //animateWithDurationがアニメーションの速度
                    swipedView.alpha = 0;

                    // アニメーションをする処理
                    swipedView.center = CGPointMake(310, 467);
                }
                                 completion:^(BOOL finished){
                                     // アニメーションが終わった後実行する処理
                                     // NSLog(@"hoge2");
                                     //[swipedView removeFromSuperview];
                                 }];
                
            }else if (swipedView.tag == 3){
                [UIView animateWithDuration:0.7f animations:^{
                    //animateWithDurationがアニメーションの速度
                    // アニメーションをする処理
                    swipedView.alpha = 0;

                    swipedView.center = CGPointMake(10, 467);
                }
                                 completion:^(BOOL finished){
                                     // アニメーションが終わった後実行する処理
                                   //   NSLog(@"hoge3");
                                     //[swipedView removeFromSuperview];
                                 }];
                
            }else if (swipedView.tag == 4){
                [UIView animateWithDuration:0.7f animations:^{
                    //animateWithDurationがアニメーションの速度
                    // アニメーションをする処理
                    swipedView.alpha = 0;

                    swipedView.center = CGPointMake(10, 167);
                }
                                 completion:^(BOOL finished){
                                     // アニメーションが終わった後実行する処理
                                     // NSLog(@"hoge4");
                                     //[swipedView removeFromSuperview];
                                 }];
            
            }
            break;
            
        default:
            break;
    }
}

@end