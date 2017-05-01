//
//  ToDoEntity.h
//  coreDataTableView
//
//  Created by Priyanshu Bhatnagar on 16/07/16.
//  Copyright © 2016 Priyanshu Bhatnagar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToDoEntity : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

-(void) setTitle:(ToDoEntity *)incoming;
@end

NS_ASSUME_NONNULL_END

#import "ToDoEntity+CoreDataProperties.h"
