//
//  HEFacebookLoginView.h
//  PMCapp
//
//  Created by Roberto Silva on 18/02/14.
//  Copyright (c) 2014 HE:mobile. All rights reserved.
//

#import "FBLoginView.h"

@interface HEFacebookLoginView : FBLoginView

@property (nonatomic, strong) UIButton* button;
@property (nonatomic, strong) UILabel* label;

@property (nonatomic, strong) NSArray *concurrentButtons;

- (void)stopActivityIndicator;
- (void)login;
@end
