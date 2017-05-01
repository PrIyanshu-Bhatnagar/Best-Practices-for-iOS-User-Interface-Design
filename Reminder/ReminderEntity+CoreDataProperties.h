//
//  ReminderEntity+CoreDataProperties.h
//  Reminder
//
//  Created by Priyanshu Bhatnagar on 20/07/16.
//  Copyright © 2016 Priyanshu Bhatnagar. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ReminderEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReminderEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *remindTitle;
@property (nullable, nonatomic, retain) NSString *remindStatus;
@property (nullable, nonatomic, retain) NSString *remindWritePad;
@property (nullable, nonatomic, retain) NSDate *remindDate;
@property (nullable, nonatomic, retain) NSString *remindWebURL;

@end

NS_ASSUME_NONNULL_END
