//
//  MyUITableViewCell.m
//  Reminder
//
//  Created by Priyanshu Bhatnagar on 20/07/16.
//  Copyright © 2016 Priyanshu Bhatnagar. All rights reserved.
//

#import "MyUITableViewCell.h"

@implementation MyUITableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void) setInternalFields:(ReminderEntity *)incomingReminderEntity{
    self.titleLabel.text = incomingReminderEntity.remindTitle;
    self.statusLabel.text = incomingReminderEntity.remindStatus;
    self.localRemindEntity = incomingReminderEntity;
    
    /*NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
      [dateformatter setDateStyle:NSDateFormatterStyle];
      [dateformatter setTimeStyle:NSDateFormatterStyle];*/
}
@end
