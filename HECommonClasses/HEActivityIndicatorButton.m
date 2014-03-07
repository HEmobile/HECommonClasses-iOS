//
//  HEActivityIndicatorButton.m
//  PMCapp
//
//  Created by Roberto Silva on 20/12/13.
//  Copyright (c) 2013 HE:mobile. All rights reserved.
//

#import "HEActivityIndicatorButton.h"

@interface HEActivityIndicatorButton ()
@property UIActivityIndicatorView *activityIndicator;
@end

@implementation HEActivityIndicatorButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)startActivityIndicator
{
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicator.hidesWhenStopped = YES;
    _activityIndicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    [self addSubview:_activityIndicator];
    [self setTitle:@"" forState:UIControlStateDisabled];
    [self setEnabled:NO];
    
    _activityIndicator.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    [_activityIndicator startAnimating];
}

- (void)stopActivityIndicator
{
    if (_activityIndicator) {
        [_activityIndicator stopAnimating];
        [_activityIndicator removeFromSuperview];
        [self setEnabled:YES];
    }
}

@end
