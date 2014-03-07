//
//  HEFacebookLoginView.h
//  PMCapp
//
//  Created by Roberto Silva on 18/02/14.
//  Copyright (c) 2014 HE:mobile. All rights reserved.
//


#if __has_include("GAITrackedViewController.h")
#import "FBLoginView.h"
@interface HEFacebookLoginView : FBLoginView
#else
#pragma message("HEFacebookLoginView requires the Facebook API")
#import <UIKit/UIKit.h>
@interface HEFacebookLoginView : UIView
#endif

@property (nonatomic, strong) UIButton* button;
@property (nonatomic, strong) UILabel* label;

@property (nonatomic, strong) NSArray *concurrentButtons;

- (void)stopActivityIndicator;
- (void)login;
@end
