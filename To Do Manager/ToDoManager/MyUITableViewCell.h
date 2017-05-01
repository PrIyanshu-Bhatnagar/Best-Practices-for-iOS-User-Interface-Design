//
//  MyUITableViewCell.h
//  ToDoManager
//
//  Created by Priyanshu Bhatnagar on 18/07/16.
//  Copyright © 2016 Priyanshu Bhatnagar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoEntity.h"
@interface MyUITableViewCell : UITableViewCell

@property(strong,nonatomic) ToDoEntity *localToDoEntity;
@property (weak, nonatomic) IBOutlet UILabel *toDoTitle;
@property (weak, nonatomic) IBOutlet UILabel *toDoDate;
-(void) setInternalFields: (ToDoEntity *) incomingToDoEntity;

@end
