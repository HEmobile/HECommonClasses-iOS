//
//  HEBasicCollectionViewController.m
//  HECommonClasses
//
//  Created by Roberto Silva on 13/05/14.
//  Copyright (c) 2014 HE:mobile. All rights reserved.
//

#import "HEBasicCollectionViewController.h"

@interface HEBasicCollectionViewController ()

@end

@implementation HEBasicCollectionViewController {
    UIImageView *_blankImageView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSArray*    selectedItems = [self.collectionView indexPathsForSelectedItems];
    for (NSIndexPath *indexPath in selectedItems) {
        [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
    }
}

- (void)toogleBlankScreen
{
    if ([self.dataArray count]==0 && self.blankImageName){
        if (!_blankImageView) {
            _blankImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64)];
            [_blankImageView setContentMode:UIViewContentModeCenter];
            _blankImageView.image = [UIImage imageNamed:self.blankImageName];
            _blankImageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [self.view addSubview:_blankImageView];
        }
        _blankImageView.hidden = NO;
    } else {
        _blankImageView.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //NSLog(@"data count :%i",(int)[self.dataArray count]);
    [self toogleBlankScreen];
    return [self.dataArray count];
}

// The cell that is returned must be retrieved from a call to - dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
