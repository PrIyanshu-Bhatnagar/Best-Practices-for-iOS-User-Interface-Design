//
//  MyNavigationController.m
//  ToDoManager
//
//  Created by Priyanshu Bhatnagar on 18/07/16.
//  Copyright © 2016 Priyanshu Bhatnagar. All rights reserved.
//

#import "MyNavigationController.h"
#import "DPHandlesMOC.h"
@interface MyNavigationController ()
@property (strong,nonatomic) NSManagedObjectContext *managedObjectContext;
@end

@implementation MyNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) receiveMOC:(NSManagedObjectContext *)incomingMOC{
    self.managedObjectContext = incomingMOC;
    id<DPHandlesMOC> child = (id<DPHandlesMOC>) self.viewControllers[0];
    [child receiveMOC:self.managedObjectContext];
}

@end
