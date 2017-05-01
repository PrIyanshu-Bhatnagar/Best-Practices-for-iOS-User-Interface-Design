//
//  ManageMOC.h
//  Reminder
//
//  Created by Priyanshu Bhatnagar on 20/07/16.
//  Copyright © 2016 Priyanshu Bhatnagar. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ManageMOC <NSObject>
-(void) receiveManageMOC:(NSManagedObjectContext *) incomingMOC;
@end
