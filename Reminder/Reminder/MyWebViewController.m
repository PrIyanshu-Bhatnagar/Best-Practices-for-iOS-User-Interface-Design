//
//  MyWebViewController.m
//  Reminder
//
//  Created by Priyanshu Bhatnagar on 20/07/16.
//  Copyright © 2016 Priyanshu Bhatnagar. All rights reserved.
//

#import "MyWebViewController.h"
#import "ReminderEntity.h"

@interface MyWebViewController ()
@property (strong,nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong,nonatomic) ReminderEntity *localReminderEntity;
@end

@implementation MyWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) receiveManageMOC:(NSManagedObjectContext *)incomingMOC{
    self.managedObjectContext = incomingMOC;
}

-(void) receiveReminderEntity:(id)incomingReminderEntity{
    self.localReminderEntity = incomingReminderEntity;
}
-(void) viewWillAppear:(BOOL)animated{
//webView
}

@end
