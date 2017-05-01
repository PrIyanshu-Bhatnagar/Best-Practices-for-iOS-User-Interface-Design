//
//  MyUIViewController.h
//  Reminder
//
//  Created by Priyanshu Bhatnagar on 20/07/16.
//  Copyright © 2016 Priyanshu Bhatnagar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManageMOC.h"
#import "ManageReminderEntity.h"
#import "ReminderEntity.h"

@interface MyUIViewController : UIViewController <ManageMOC>
-(void) receiveManageMOC:(NSManagedObjectContext *)incomingMOC;
-(void) receiveReminderEntity:(ReminderEntity *)incomingReminderEntity;
@end
