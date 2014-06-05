//
//  HEBasicTableViewController.m
//  EmailMarketing
//
//  Created by Roberto Silva on 11/09/13.
//  Copyright (c) 2013 Locaweb. All rights reserved.
//

#import "HEBasicTableViewController.h"

@interface HEBasicTableViewController ()

@end

@implementation HEBasicTableViewController
@synthesize blankImageView = _blankImageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.blankImageViewXPos = 64;
}

- (void)useRefreshControl
{
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    [refreshControl endRefreshing];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSIndexPath*    selection = [self.tableView indexPathForSelectedRow];
    if (selection) {
        [self.tableView deselectRowAtIndexPath:selection animated:YES];
    }
}

- (void)toogleBlankScreen
{
    if ([self.dataArray count]==0 && self.blankImageName){
        if (!_blankImageView) {
            _blankImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.blankImageViewXPos, self.view.bounds.size.width, self.view.bounds.size.height-self.blankImageViewXPos)];
            _blankImageView.backgroundColor = [UIColor clearColor];
            [_blankImageView setContentMode:UIViewContentModeCenter];
            _blankImageView.image = [UIImage imageNamed:self.blankImageName];
            //_blankImageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [self.view addSubview:_blankImageView];
        }
        _blankImageView.hidden = NO;
        self.tableView.hidden = YES;
    } else {
        _blankImageView.hidden = YES;
        self.tableView.hidden = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self toogleBlankScreen];
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
