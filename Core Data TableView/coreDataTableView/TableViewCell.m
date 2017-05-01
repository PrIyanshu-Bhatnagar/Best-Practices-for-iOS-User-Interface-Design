//
//  TableViewCell.m
//  coreDataTableView
//
//  Created by Priyanshu Bhatnagar on 17/07/16.
//  Copyright © 2016 Priyanshu Bhatnagar. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setTitle:(ToDoEntity *)incoming{
    self.cellLabel.text = incoming.title;
}

@end
