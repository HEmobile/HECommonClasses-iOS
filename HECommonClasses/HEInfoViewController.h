//
//  HEInfoViewController.h
//  PMCapp
//
//  Created by Roberto Silva on 19/12/13.
//  Copyright (c) 2013 HE:mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HEInfoViewControllerProtocol
- (void)closeInfoVC;
@end

@interface HEInfoViewController : UIViewController
@property (weak, nonatomic) id<HEInfoViewControllerProtocol> delegate;
@end
