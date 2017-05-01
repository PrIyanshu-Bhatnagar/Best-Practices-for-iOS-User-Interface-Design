//
//  MyNavigationController.h
//  Reminder
//
//  Created by Priyanshu Bhatnagar on 20/07/16.
//  Copyright © 2016 Priyanshu Bhatnagar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManageMOC.h"

@interface MyNavigationController : UINavigationController <ManageMOC>
-(void) receiveManageMOC:(NSManagedObjectContext *)incomingMOC;
@end
