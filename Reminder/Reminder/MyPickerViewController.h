//
//  MyPickerViewController.h
//  Reminder
//
//  Created by Priyanshu Bhatnagar on 21/07/16.
//  Copyright © 2016 Priyanshu Bhatnagar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPickerViewController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource>
-(void) setArray;
-(NSArray *) getArray;
@end
