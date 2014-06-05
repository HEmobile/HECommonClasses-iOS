//
//  HEBasicTableViewController.h
//  EmailMarketing
//
//  Created by Roberto Silva on 11/09/13.
//  Copyright (c) 2013 Locaweb. All rights reserved.
//

#import <UIKit/UIKit.h>

#if __has_include("GAITrackedViewController.h") && __has_include(<GAITrackedViewController.h>)
#import <GAITrackedViewController.h>
@interface HEBasicTableViewController : GAITrackedViewController<UITableViewDataSource, UITableViewDelegate>
#else
@interface HEBasicTableViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
#endif

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (weak,nonatomic) NSString *blankImageName;
@property (strong, nonatomic) UIImageView *blankImage;

- (void)useRefreshControl;
- (void)toogleBlankScreen;
@end
