//
//  MyNavigationController.m
//  Reminder
//
//  Created by Priyanshu Bhatnagar on 20/07/16.
//  Copyright © 2016 Priyanshu Bhatnagar. All rights reserved.
//

#import "MyNavigationController.h"

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

-(void) receiveManageMOC:(NSManagedObjectContext *)incomingMOC{
    self.managedObjectContext = incomingMOC;
    
    id<ManageMOC> child = (id<ManageMOC>) self.viewControllers[0];
    [child receiveManageMOC:self.managedObjectContext];
}

@end
