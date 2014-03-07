//
//  NSString+Helper.h
//  PMCapp
//
//  Created by Roberto Silva on 10/12/13.
//  Copyright (c) 2013 HE:mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Helper)
- (BOOL) isValidEmail;
- (void)presentAsAlertViewWithTitle:(NSString *)title;
@end
