//
//  DPHandlesMOC.h
//  ToDoManager
//
//  Created by Priyanshu Bhatnagar on 18/07/16.
//  Copyright © 2016 Priyanshu Bhatnagar. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DPHandlesMOC <NSObject>
-(void) receiveMOC: (NSManagedObjectContext *) incomingMOC;

@end
