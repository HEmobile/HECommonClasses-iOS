//
//  HEFacebookLoginView.h
//  PMCapp
//
//  Created by Roberto Silva on 18/02/14.
//  Copyright (c) 2014 HE:mobile. All rights reserved.
//
#if defined(__has_include)
    #if __has_include("FBLoginView.h") && __has_include(<FBLoginView.h>)
        #import "FBLoginView.h"
        @interface HEFacebookLoginView : FBLoginView
    #else
        #import <UIKit/UIKit.h>
        @interface HEFacebookLoginView : UIView
    #endif
#else
#import <UIKit/UIKit.h>
@interface HEFacebookLoginView : UIView
#endif

@property (nonatomic, strong) UIButton* button;
@property (nonatomic, strong) UILabel* label;

@property (nonatomic, strong) NSArray *concurrentButtons;

- (void)stopActivityIndicator;
- (void)login;
@end
