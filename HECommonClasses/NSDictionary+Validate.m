//
//  NSDictionary+Validate.m
//  EmailMarketing
//
//  Created by Roberto Silva on 11/09/13.
//  Copyright (c) 2013 Locaweb. All rights reserved.
//

#import "NSDictionary+Validate.h"

@implementation NSDictionary (Validate)

- (id)validObjectForKey:(NSString *)key
{
    id object = [self objectForKey:key];
    
    if ([object isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return object;
    
}

@end
