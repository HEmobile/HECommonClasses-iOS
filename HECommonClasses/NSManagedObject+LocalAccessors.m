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

+ (NSManagedObjectContext *)newChildManagedObjectContext
{
    NSManagedObjectContext *childManagedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    childManagedObjectContext.parentContext = [self sharedManagedObjectContext];
    
    return childManagedObjectContext;
    /*
    NSManagedObjectContext *managedObjectContext = nil;
     
     
    id appDelegate = [[UIApplication sharedApplication] delegate];
    if ([appDelegate respondsToSelector:@selector(childManagedObjectContext)]) {
        managedObjectContext = [appDelegate performSelector:@selector(childManagedObjectContext)];
    }
    
    return managedObjectContext;
    */
}

+ (void)saveContext
{
    id appDelegate = [[UIApplication sharedApplication] delegate];
    if ([appDelegate respondsToSelector:@selector(saveContext)]) {
        [appDelegate performSelector:@selector(saveContext)];
    }
}

+ (void)saveChildContext:(NSManagedObjectContext *)childManagedObjCxt
{
    NSError *error = nil;
    if (childManagedObjCxt != nil) {
        if ([childManagedObjCxt hasChanges]) {
            if ([childManagedObjCxt save:&error]) {
                [self saveContext];
            } else {
                if (error != nil) NSLog(@"NSManagedObject.saveChildContext : Unresolved error %@, %@", error, [error userInfo]);
            }
        }
    }
}

+ (id)createInstance
{
    id instance = nil;
    NSManagedObjectContext *moc = [self sharedManagedObjectContext];
    if (moc != nil) {
        instance = [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:moc];
    }
    return instance;
}

+ (id)createInstanceInContext:(NSManagedObjectContext *)moc
{
    id instance = nil;
    if (moc != nil) {
        instance = [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:moc];
    }
    return instance;
}

- (id)objectInContext:(NSManagedObjectContext *)context
{
    NSManagedObjectID *mid = [self objectID];
    id instance = [context objectWithID:mid];
    
    return instance;
}

- (id)mainContextObject
{
    id instance;
    if (self.managedObjectContext != [NSManagedObject sharedManagedObjectContext]) {
        NSManagedObjectID *mid = [self objectID];
        instance = [[NSManagedObject sharedManagedObjectContext] objectWithID:mid];
    } else {
        instance = self;
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

+ (NSArray *)fetchAllFromContext:(NSManagedObjectContext *)context withPredicate:(NSPredicate *)predicate andSortDescriptor:(NSSortDescriptor *)sortDescriptor
{
    NSArray *results = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:[self entityName]];
    if (predicate) request.predicate = predicate;
    if (sortDescriptor) request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error;
    results = [context executeFetchRequest:request error:&error];
    
    if (error != nil) {
        NSLog(@"%@.fetchAllFromContext:WithPredicate:andSortDescriptor ERROR: %@, %@", NSStringFromClass([self class]), error, [error userInfo]);
    }
    
    return results;
}


+ (NSArray *)fetchAllWithPredicate:(NSPredicate *)predicate andSortDescriptor:(NSSortDescriptor *)sortDescriptor
{
    return [self fetchAllFromContext:[self sharedManagedObjectContext] withPredicate:predicate andSortDescriptor:sortDescriptor];
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

- (BOOL)isNew {
    NSDictionary *vals = [self committedValuesForKeys:nil];
    return [vals count] == 0;
}

@end
