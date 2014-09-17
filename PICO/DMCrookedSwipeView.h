//
//  DMCrookedSwipeView.h
//  DMCrookedSwiper
//
//  Created by Master on 2014/06/15.
//  Copyright (c) 2014年 jp.co.mappy. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ViewController.h"

@protocol DMCrookedSwipeViewDelegate; //何を助けてほしいか

@interface DMCrookedSwipeView : UIImageView
<UIGestureRecognizerDelegate>
{
    float moveX;
    float moveY;
    
    int torf;   //合ってたら１、間違ってたら２
    
    int colorNum;  //色に番号つけといて、すみからーと合わせる    
    
    /*---SCORE---*/
    int score;        //スコア
    int plusScore;    //連続で成功したときプラスするスコア
    
    UIImageView *swipedView ;
}

@property (nonatomic, assign) id<DMCrookedSwipeViewDelegate> delegate;  //かわりにやってくれるマン


@property(nonatomic) int torf;

@property(nonatomic) int colorNum;

@property(nonatomic) int score;
@property(nonatomic) int plusScore;


@property(nonatomic, copy) NSString *objectPosition;
@property(nonatomic, copy) NSString *objestColor;


@end


@protocol DMCrookedSwipeViewDelegate<NSObject>  //何を助けてほしいか
- (void) hanteiWithMarble:(UIImageView *)swipeView;
@end
