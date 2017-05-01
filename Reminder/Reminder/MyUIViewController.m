//
//  MyUIViewController.m
//  Reminder
//
//  Created by Priyanshu Bhatnagar on 20/07/16.
//  Copyright © 2016 Priyanshu Bhatnagar. All rights reserved.
//

#import "MyUIViewController.h"
#import "ManageReminderEntity.h"
#import "MyPickerViewController.h"
@interface MyUIViewController ()
@property (strong,nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *writePadField;
@property (weak, nonatomic) IBOutlet UIDatePicker *dateField;
@property (weak, nonatomic) IBOutlet UIPickerView *statusField;
@property (weak, nonatomic) IBOutlet UITextField *webField;
@property (strong,nonnull) ReminderEntity *localReminderEntity;
@property (nonatomic) MyPickerViewController *pickerRollerHelper;

@property (nonatomic,assign) BOOL state;
@end

@implementation MyUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pickerRollerHelper = [[MyPickerViewController alloc]init];
    
    [self.statusField setDelegate:self.pickerRollerHelper];
    [self.statusField setDataSource:self.pickerRollerHelper];
    [self.pickerRollerHelper setArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    id<ManageMOC,ManageReminderEntity> child = (id<ManageMOC,ManageReminderEntity>)[segue destinationViewController];
    
    [child receiveManageMOC:self.managedObjectContext];
    ReminderEntity *item = [NSEntityDescription insertNewObjectForEntityForName:@"ReminderEntity" inManagedObjectContext:self.managedObjectContext];
    
    [child receiveReminderEntity:item];

}

-(void) receiveManageMOC:(NSManagedObjectContext *)incomingMOC{
    self.managedObjectContext = incomingMOC;
}

-(void) receiveReminderEntity:(ReminderEntity *)incomingReminderEntity{
    self.localReminderEntity = incomingReminderEntity;
}
- (IBAction)trashTrapped:(id)sender {
    
    [self.managedObjectContext deleteObject:self.localReminderEntity];
    [self saveReminderEntity];
    [self.navigationController popViewControllerAnimated:YES];
    self.state = YES;
}

-(void) viewWillAppear:(BOOL)animated{
    
    self.state = NO;
    self.titleField.text = self.localReminderEntity.remindTitle;
    self.webField.text = self.localReminderEntity.remindWebURL;
    self.writePadField.text = self.localReminderEntity.remindWritePad;
    
    NSString *status = self.localReminderEntity.remindStatus;
    if(status){
        [self.statusField selectRow:[[self.pickerRollerHelper getArray] indexOfObject:status] inComponent:0 animated:NO];
        
    }else{
        [self.statusField selectRow:1 inComponent:0 animated:NO];
    }
   
    NSDate *dueDate = self.localReminderEntity.remindDate;
    if(!dueDate){
        [self.dateField setDate:dueDate];
    }
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector (textViewDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:self];
}

-(void) viewWillDisappear:(BOOL)animated{

    if(self.state == NO) {
    self.localReminderEntity.remindTitle = self.titleField.text;
    self.localReminderEntity.remindWritePad = self.writePadField.text;
    self.localReminderEntity.remindDate = self.dateField.date;
    self.localReminderEntity.remindWebURL = self.webField.text;
    self.localReminderEntity.remindStatus = self.statusField.description;
        
    }
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidEndEditingNotification object:self];
    
}

-(void)textViewDidEndEnditing:(NSNotification *)notification{
    if([notification object] == self){
        self.localReminderEntity.remindWritePad = self.writePadField.text;
        
        [self saveReminderEntity];
    }
}

-(void) saveReminderEntity{
    NSError *err;
    BOOL saveSuccess = [self.managedObjectContext save:&err];
    
    if(!saveSuccess){
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Couldn't Save" userInfo:nil];
    }
}
- (IBAction)titleFieldEdited:(id)sender {
    self.localReminderEntity.remindTitle = self.titleField.text;
    
    [self saveReminderEntity];
}


@end
