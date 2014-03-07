//
//  HEFacebookLoginView.m
//  PMCapp
//
//  Created by Roberto Silva on 18/02/14.
//  Copyright (c) 2014 HE:mobile. All rights reserved.
//

#import "HEFacebookLoginView.h"

@implementation HEFacebookLoginView {
    UIActivityIndicatorView *_activityIndicator;
}

- (id)init {
    if (self = [super init]) {
        [self getReferences];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame: frame]) {
        [self getReferences];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder: aDecoder]) {
        [self getReferences];
    }
    return self;
}


- (void) getReferences {
    
    for (id obj in self.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            self.button = obj;
        }
        
        if ([obj isKindOfClass:[UILabel class]]) {
            self.label =  obj;
        }
    }
    
    [self.button addTarget:self
                    action:@selector(buttonPressedAction:)
          forControlEvents:UIControlEventTouchUpInside];
}

//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wundeclared-selector"
- (void)buttonPressedAction:(id)sender {
    NSLog(@"button clicked");
    [self startActivityIndicator];
    /*
    if ([super respondsToSelector:@selector(buttonPressed:)]) {
        [super performSelector:@selector(buttonPressed:) withObject:sender];
    }
    */
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
- (void)login
{
    [self startActivityIndicator];
    if ([super respondsToSelector:@selector(buttonPressed:)]) {
        [super performSelector:@selector(buttonPressed:) withObject:self.button];
    }
}
#pragma clang diagnostic pop

- (NSString *)logInText {
    return NSLocalizedString(@"FACEBOOK_LOGIN_BUTTON",nil);
    //return [FBUtility localizedStringForKey:@"FBLV:LogInButton" withDefault:@"Log in with Facebook"];
}

- (NSString *)logOutText {
    return NSLocalizedString(@"FACEBOOK_LOGOUT_BUTTON",nil);
    //return [FBUtility localizedStringForKey:@"FBLV:LogOutButton" withDefault:@"Log out"];
}

- (void)startActivityIndicator
{
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityIndicator.hidesWhenStopped = YES;
        _activityIndicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    }
    
    [self addSubview:_activityIndicator];
    //[self setTitle:@"" forState:UIControlStateDisabled];
    [self.button setEnabled:NO];
    
    _activityIndicator.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    [_activityIndicator startAnimating];
    
    self.label.hidden = YES;
    [self disableConcurrentButtons];
}

- (void)stopActivityIndicator
{
    if (_activityIndicator) {
        [_activityIndicator stopAnimating];
        [_activityIndicator removeFromSuperview];
        _activityIndicator = nil;
        [self.button setEnabled:YES];
        self.label.hidden = NO;
        [self enableConcurrentButtons];
    }
}

- (void)disableConcurrentButtons
{
    for (UIButton *button in self.concurrentButtons) {
        button.enabled = NO;
    }
}

- (void)enableConcurrentButtons
{
    for (UIButton *button in self.concurrentButtons) {
        button.enabled = YES;
    }
}

@end
