//
//  DPHandlesToDoEntity.h
//  ToDoManager
//
//  Created by Priyanshu Bhatnagar on 18/07/16.
//  Copyright © 2016 Priyanshu Bhatnagar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ToDoEntity.h"

@protocol DPHandlesToDoEntity <NSObject>
-(void) receiveToDoEntity: (ToDoEntity *) incomingToDoEntity;

@end
