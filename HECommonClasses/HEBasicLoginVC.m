//
//  CCMLoginVC.m
//  ControlCanvasPM
//
//  Created by Roberto Silva on 06/05/14.
//  Copyright (c) 2014 PM20. All rights reserved.
//

#import "HEBasicLoginVC.h"
#import "HEActivityIndicatorButton.h"
#import "NSString+Helper.h"
#import "NSManagedObject+LocalAccessors.h"

//CGFloat const CCMBottomSpaceDefault = 276;
float const HEKeyboardMargin = 8.0;

@interface HEBasicLoginVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet HEActivityIndicatorButton *enterButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpaceConstraint;

@end

@implementation HEBasicLoginVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    self.startBottomSpace = self.bottomSpaceConstraint.constant;
    self.keyboardMargin = HEKeyboardMargin;
    
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.warningsLabel.hidden = YES;
    [self observeKeyboard];
}

#pragma mark KEYBOARD

- (void)observeKeyboard {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    NSValue *kbFrame = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [kbFrame CGRectValue];
    
    CGFloat height = keyboardFrame.size.height;
    if (keyboardFrame.size.width < height) {
        height = keyboardFrame.size.width;
    }

    self.bottomSpaceConstraint.constant = height + self.keyboardMargin;
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    self.bottomSpaceConstraint.constant = self.startBottomSpace;
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)dismissKeyboard
{
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.view endEditing:YES];
}

#pragma mark TextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.usernameTextField) {
        [self.passwordTextField becomeFirstResponder];
    } else if (textField == self.passwordTextField) {
        [self dismissKeyboard];
        [self login:self.enterButton];
    }
    
    return YES;
}

- (IBAction)login:(HEActivityIndicatorButton *)sender {
    [sender startActivityIndicator];
    self.warningsLabel.hidden = YES;
    
}

@end
