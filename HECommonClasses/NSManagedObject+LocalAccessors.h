//
//  NSManagedObject+LocalAccessors.h
//  BandTemplate
//
//  Created by Roberto Silva on 25/07/13.
//  Copyright (c) 2013 Felloway. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (LocalAccessors)

+ (NSManagedObjectContext *)sharedManagedObjectContext;
+ (void)saveContext;

+ (NSManagedObjectContext *)newChildManagedObjectContext;
+ (void)saveChildContext:(NSManagedObjectContext *)childManagedObjCxt;

+ (NSString *)entityName;//NSStringFromClass([self class])

+ (id)createInstance;
+ (id)createInstanceInContext:(NSManagedObjectContext *)moc;

+ (BOOL)importFromDictionary:(NSDictionary *)dictionary;
+ (NSUInteger)importAllFromArray:(NSArray *)listOfDictionaries;

+ (NSArray *)fetchAllWithPredicate:(NSPredicate *)predicate andSortDescriptor:(NSSortDescriptor *)sortDescriptor;
+ (NSArray *)fetchAllWithPredicate:(NSPredicate *)predicate;
+ (NSArray *)fetchAllWithSortDescriptor:(NSSortDescriptor *)sortDescriptor;
+ (NSArray *)fetchAllWithSortDescriptors:(NSArray *)sortDescriptors;
+ (NSArray *)fetchAllWithPredicate:(NSPredicate *)predicate andSortDescriptors:(NSArray *)sortDescriptors;
+ (NSArray *)fetchAllFromContext:(NSManagedObjectContext *)context withPredicate:(NSPredicate *)predicate andSortDescriptor:(NSSortDescriptor *)sortDescriptor;

- (void)setAttribute:(NSString *)attributeName withObject:(id)object;
- (BOOL)isNew;
- (id)objectInContext:(NSManagedObjectContext *)context;
- (id)mainContextObject;
@end
