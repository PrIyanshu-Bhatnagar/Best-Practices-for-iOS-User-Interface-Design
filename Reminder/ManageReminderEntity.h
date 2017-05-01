//
//  ManageReminderEntity.h
//  Reminder
//
//  Created by Priyanshu Bhatnagar on 20/07/16.
//  Copyright © 2016 Priyanshu Bhatnagar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReminderEntity.h"

@protocol ManageReminderEntity <NSObject>
-(void) receiveReminderEntity: (ReminderEntity *) incomingReminderEntity;
@end
