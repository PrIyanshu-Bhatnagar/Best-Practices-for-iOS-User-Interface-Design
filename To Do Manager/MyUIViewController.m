//
//  MyUIViewController.m
//  ToDoManager
//
//  Created by Priyanshu Bhatnagar on 18/07/16.
//  Copyright © 2016 Priyanshu Bhatnagar. All rights reserved.
//

#import "MyUIViewController.h"

@interface MyUIViewController ()
@property (strong,nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *detailsField;
@property (weak, nonatomic) IBOutlet UIDatePicker *duedateField;
@property (nonatomic,assign) BOOL wasDeleted;
@property (strong, nonatomic) ToDoEntity *localToDoEntity;
@end

@implementation MyUIViewController

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

-(void) receiveMOC: (NSManagedObjectContext *)incomingMOC{
    self.managedObjectContext = incomingMOC;

}

-(void) receiveToDoEntity:(ToDoEntity *)incomingToDoEntity{
    self.localToDoEntity = incomingToDoEntity;
}

- (IBAction)trashTapped:(id)sender {
    self.wasDeleted = true;
    [self.managedObjectContext deleteObject:self.localToDoEntity];
    [self saveMyToDoEntity];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void) saveMyToDoEntity{

    NSError *err;
    BOOL saveSuccess = [self.managedObjectContext save:&err];
    if(!saveSuccess){
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Couldn't Save" userInfo:nil];
    }
}

- (IBAction)dueDateEdited:(id)sender {
    
    self.localToDoEntity.toDoDate = self.duedateField.date;
    
    [self saveMyToDoEntity];
}

- (IBAction)titleFieldEditted:(id)sender {
    self.localToDoEntity.toDoTitle = self.titleField.text;
    [self saveMyToDoEntity];
}

-(void) textViewDidEndEditing:(NSNotification *)notification{
    if([notification object] == self){
        self.localToDoEntity.toDoDetails = self.detailsField.text;
        [self saveMyToDoEntity];
    }
}

-(void) viewWillAppear:(BOOL)animated{

    self.wasDeleted = false;
    //setup Form
    self.titleField.text = self.localToDoEntity.toDoTitle;
    self.detailsField.text = self.localToDoEntity.toDoDetails;
    
    NSDate *dueDate = self.localToDoEntity.toDoDate;
    if(dueDate != nil){
        [self.duedateField setDate:dueDate];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:self];
    

}

-(void) viewWillDisappear:(BOOL)animated{
//Remove detection
    if(self.wasDeleted == true) return;
    
    
    self.localToDoEntity.toDoTitle = self.titleField.text;
    self.localToDoEntity.toDoDetails = self.detailsField.text;
    self.localToDoEntity.toDoDate = self.duedateField.date;
    
    [self saveMyToDoEntity];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextViewTextDidEndEditingNotification object:self];
    
}
@end
