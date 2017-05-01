//
//  MyUIViewController.h
//  ToDoManager
//
//  Created by Priyanshu Bhatnagar on 18/07/16.
//  Copyright © 2016 Priyanshu Bhatnagar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPHandlesMOC.h"
#import "DPHandlesToDoEntity.h"
#import "ToDoEntity.h"

@interface MyUIViewController : UIViewController <DPHandlesMOC, DPHandlesToDoEntity>

-(void) receiveMOC: (NSManagedObjectContext *)incomingMOC;
-(void) receiveToDoEntity:(ToDoEntity *)incomingToDoEntity;

@end
