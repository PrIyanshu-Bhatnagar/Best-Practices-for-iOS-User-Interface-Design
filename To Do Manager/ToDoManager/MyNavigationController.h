//
//  MyNavigationController.h
//  ToDoManager
//
//  Created by Priyanshu Bhatnagar on 18/07/16.
//  Copyright © 2016 Priyanshu Bhatnagar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPHandlesMOC.h"

@interface MyNavigationController : UINavigationController <DPHandlesMOC>

-(void) receiveMOC:(NSManagedObjectContext *)incomingMOC;

@end
