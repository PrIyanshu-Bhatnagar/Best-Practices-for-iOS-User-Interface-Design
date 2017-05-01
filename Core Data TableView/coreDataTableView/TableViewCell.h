//
//  TableViewCell.h
//  coreDataTableView
//
//  Created by Priyanshu Bhatnagar on 17/07/16.
//  Copyright © 2016 Priyanshu Bhatnagar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoEntity.h"
@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cellLabel;
-(void) setTitle:(ToDoEntity *)incoming;

@end
