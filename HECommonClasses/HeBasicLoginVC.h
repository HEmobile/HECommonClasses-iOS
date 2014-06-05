//
//  CCMLoginVC.h
//  ControlCanvasPM
//
//  Created by Roberto Silva on 06/05/14.
//  Copyright (c) 2014 PM20. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HEActivityIndicatorButton;

@interface HeBasicLoginVC : UIViewController
@property (nonatomic) float startBottomSpace;
@property (nonatomic) float keyboardMargin;

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UILabel *warningsLabel;

- (IBAction)login:(HEActivityIndicatorButton *)sender;
@end
