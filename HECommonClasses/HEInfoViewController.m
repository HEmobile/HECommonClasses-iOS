//
//  HEInfoViewController.m
//  PMCapp
//
//  Created by Roberto Silva on 19/12/13.
//  Copyright (c) 2013 HE:mobile. All rights reserved.
//

#import "HEInfoViewController.h"

@interface HEInfoViewController ()

@end

@implementation HEInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)close:(id)sender {
    [self.delegate closeInfoVC];
}

@end
