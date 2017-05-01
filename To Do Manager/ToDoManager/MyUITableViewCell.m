//
//  MyUITableViewCell.m
//  ToDoManager
//
//  Created by Priyanshu Bhatnagar on 18/07/16.
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
-(void) setInternalFields: (ToDoEntity *) incomingToDoEntity{
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc]init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
                      
    self.toDoTitle.text = incomingToDoEntity.toDoTitle;
    self.toDoDate.text = [dateFormatter stringFromDate:incomingToDoEntity.toDoDate];
    
    self.localToDoEntity = incomingToDoEntity;
    

}
@end
