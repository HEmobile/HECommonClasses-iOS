//
//  HEBasicCollectionViewController.h
//  HECommonClasses
//
//  Created by Roberto Silva on 13/05/14.
//  Copyright (c) 2014 HE:mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

#if __has_include("GAITrackedViewController.h") && __has_include(<GAITrackedViewController.h>)
#import <GAITrackedViewController.h>
@interface HEBasicCollectionViewController : GAITrackedViewController<UICollectionViewDataSource, UICollectionViewDelegate>
#else
@interface HEBasicCollectionViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>
#endif
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *dataArray;
@property (weak,nonatomic) NSString *blankImageName;

- (void)toogleBlankScreen;
@end
