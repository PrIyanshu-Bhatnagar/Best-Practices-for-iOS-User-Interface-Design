//
//  MyUITableViewCell.h
//  Reminder
//
//  Created by Priyanshu Bhatnagar on 20/07/16.
//  Copyright © 2016 Priyanshu Bhatnagar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReminderEntity.h"

@interface MyUITableViewCell : UITableViewCell

@property (strong
           ,nonatomic) ReminderEntity *localRemindEntity;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
-(void) setInternalFields: (ReminderEntity *)incomingReminderEntity;

@end
