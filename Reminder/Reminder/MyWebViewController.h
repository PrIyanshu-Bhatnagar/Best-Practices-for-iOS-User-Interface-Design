//
//  MyWebViewController.h
//  Reminder
//
//  Created by Priyanshu Bhatnagar on 20/07/16.
//  Copyright © 2016 Priyanshu Bhatnagar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManageMOC.h"
#import "ManageReminderEntity.h"
@interface MyWebViewController : UIViewController <ManageMOC,ManageReminderEntity>
-(void) receiveManageMOC:(NSManagedObjectContext *)incomingMOC;
-(void) receiveReminderEntity:(id)incomingReminderEntity;
@end
