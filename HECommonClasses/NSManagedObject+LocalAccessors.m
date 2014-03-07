//
//  NSManagedObject+LocalAccessors.m
//  BandTemplate
//
//  Created by Roberto Silva on 25/07/13.
//  Copyright (c) 2013 Felloway. All rights reserved.
//

#import "NSManagedObject+LocalAccessors.h"

@implementation NSManagedObject (LocalAccessors)

+ (NSString *)entityName
{
    //NSLog(@"entityName:%@",NSStringFromClass([self class]));
    return NSStringFromClass([self class]);
}

+ (NSManagedObjectContext *)sharedManagedObjectContext
{
    NSManagedObjectContext *managedObjectContext = nil;
    
    id appDelegate = [[UIApplication sharedApplication] delegate];
    if ([appDelegate respondsToSelector:@selector(managedObjectContext)]) {
        managedObjectContext = [appDelegate performSelector:@selector(managedObjectContext)];
    }
    
    return managedObjectContext;
}

+ (void)saveContext
{
    id appDelegate = [[UIApplication sharedApplication] delegate];
    if ([appDelegate respondsToSelector:@selector(saveContext)]) {
        [appDelegate performSelector:@selector(saveContext)];
    }
}

+ (id)createInstance
{
    /*
    id appDelegate = [[UIApplication sharedApplication] delegate];
    id instance;
    if ([appDelegate respondsToSelector:@selector(managedObjectContext)]) {
        instance = [NSEntityDescription insertNewObjectForEntityForName:[self entityName]
                                                 inManagedObjectContext:[appDelegate performSelector:@selector(managedObjectContext)]];
    }
    */
    id instance = nil;
    NSManagedObjectContext *moc = [self sharedManagedObjectContext];
    if (moc != nil) {
        instance = [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:moc];
    }
    return instance;
}

- (void)setAttribute:(NSString *)attributeName withObject:(id)object
{
    NSString *setSelectorName = [NSString stringWithFormat:@"set%@%@:",[[attributeName substringToIndex:1] uppercaseString],[attributeName substringFromIndex:1] ];
    //[[@"set" stringByAppendingString:[attributeName capitalizedString]] stringByAppendingString:@":"];
    //NSLog(@"selector:%@->obj:%@",setSelectorName,object);
    if ([self respondsToSelector:NSSelectorFromString(setSelectorName)]) {
        //NSLog(@"found selector");
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:NSSelectorFromString(setSelectorName) withObject:object];
        #pragma clang diagnostic pop
        
    }
}

+ (NSUInteger)importAllFromArray:(NSArray *)listOfDictionaries
{
    NSUInteger rowsImported = 0;
    
    for (NSDictionary* item in listOfDictionaries) {
        [self importFromDictionary:item];
        rowsImported++;
    }
    
    return rowsImported;
}

+ (BOOL)importFromDictionary:(NSDictionary *)dictionary
{
    id myInstance = [self createInstance];
    
    for (NSString* attributeName in dictionary.allKeys) {
        [myInstance setAttribute:attributeName withObject:[dictionary objectForKey:attributeName]];
    }
    return YES;
}

+ (NSArray *)fetchAllWithPredicate:(NSPredicate *)predicate andSortDescriptor:(NSSortDescriptor *)sortDescriptor
{
    NSArray *results = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:[self entityName]];
    if (predicate) request.predicate = predicate;
    if (sortDescriptor) request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error;
    results = [[self sharedManagedObjectContext] executeFetchRequest:request error:&error];
    
    if (error != nil) {
        NSLog(@"%@.fetchAllWithPredicate:andSortDescriptor ERROR: %@, %@", NSStringFromClass([self class]), error, [error userInfo]);
    }
    
    return results;
}

+ (NSArray *)fetchAllWithPredicate:(NSPredicate *)predicate
{
    return [self fetchAllWithPredicate:predicate andSortDescriptor:nil];
}

+ (NSArray *)fetchAllWithSortDescriptor:(NSSortDescriptor *)sortDescriptor
{
    return [self fetchAllWithPredicate:nil andSortDescriptor:sortDescriptor];
}

+ (NSArray *)fetchAllWithSortDescriptors:(NSArray *)sortDescriptors
{
    return [self fetchAllWithPredicate:nil andSortDescriptors:sortDescriptors];
}

+ (NSArray *)fetchAllWithPredicate:(NSPredicate *)predicate andSortDescriptors:(NSArray *)sortDescriptors
{
    NSArray *results = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:[self entityName]];
    if (predicate) request.predicate = predicate;
    if (sortDescriptors) request.sortDescriptors = sortDescriptors;
    
    NSError *error;
    results = [[self sharedManagedObjectContext] executeFetchRequest:request error:&error];
    
    if (error != nil) {
        NSLog(@"%@.fetchAllWithPredicate:andSortDescriptor ERROR: %@, %@", NSStringFromClass([self class]), error, [error userInfo]);
    }
    
    return results;
}

@end
