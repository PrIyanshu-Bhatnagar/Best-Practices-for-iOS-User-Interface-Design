//
//  ViewController.m
//  coreDataTableView
//
//  Created by Priyanshu Bhatnagar on 16/07/16.
//  Copyright © 2016 Priyanshu Bhatnagar. All rights reserved.
//

#import "ViewController.h"
#import "ToDoEntity.h"
#import "TableViewCell.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource, NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong,nonatomic) NSFetchedResultsController *resultsController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"ToDoEntity" inManagedObjectContext:self.context];
    
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"TRUEPREDICATE"];
    
    fetchRequest.sortDescriptors = @[[[NSSortDescriptor alloc]initWithKey:@"title" ascending:YES]];
    
    self.resultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:self.context sectionNameKeyPath:nil cacheName:nil];
    self.resultsController.delegate = self;
    
    
    NSError *err;
    BOOL fetchSucceeded = [self.resultsController performFetch:&err];
    if(!fetchSucceeded){
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Couldn't Fetch" userInfo:nil];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)todoTapped:(id)sender {
    //Get the Text
    //Store the text in coredata
    //save coredata
    
    NSString *text = self.textField.text;
    NSManagedObjectContext *ctx = self.context;
    
    
    ToDoEntity *item =[NSEntityDescription insertNewObjectForEntityForName:@"ToDoEntity" inManagedObjectContext:ctx];
    item.title = text;
    
    NSError *err;
    BOOL saveSuccess =[ctx save:&err];
    if(!saveSuccess){
        @throw [NSException exceptionWithName:NSGenericException reason:@"Couldn't save" userInfo:@{NSUnderlyingErrorKey:err}];
                }
    else{
        self.textField.text = nil;
    }
    
}


#pragma mark - TableViewDelegates


-(NSInteger) numberOfSectionsInTableView: (UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section{
    return self.resultsController.sections[section].numberOfObjects;
            
}


-(UITableViewCell *) tableView:(UITableView *) tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    ToDoEntity *item = self.resultsController.sections[indexPath.section].objects[indexPath.row];
    
    TableViewCell *cell = (TableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"TableCell" forIndexPath:indexPath];
    
    [cell setTitle:item];
    
    return cell;
}


-(void) controllerWillChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView beginUpdates];
}

-(void) controller: (NSFetchedResultsController *) controller didChangeObject:(nonnull id)anObject atIndexPath:(nullable NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(nullable NSIndexPath *)newIndexPath{
   
    switch(type){
        case NSFetchedResultsChangeInsert: [[self tableView] insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete: [[self tableView] deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate: TableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            
            ToDoEntity *item = [controller objectAtIndexPath:indexPath];
            
            [cell setTitle:item];
            
            break;
            
        case NSFetchedResultsChangeMove:
            
            [[self tableView]deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            [[self tableView] insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

-(void) controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView endUpdates];
}






@end
