//
//  HorizontalSeparator.m
//  Scene
//
//  Created by Roberto Silva on 14/03/13.
//  Copyright (c) 2013 Felloway. All rights reserved.
//

#import "HorizontalSeparator.h"

@implementation HorizontalSeparator

- (void)awakeFromNib
{
    if (self.image == nil) {
        UIImage *borderImage = [UIImage imageNamed:@"VeryLightGreyLine"];
        self.image = [borderImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
        
}

@end
