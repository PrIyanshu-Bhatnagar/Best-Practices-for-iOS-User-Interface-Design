//
//  MyUITableViewController.m
//  Reminder
//
//  Created by Priyanshu Bhatnagar on 20/07/16.
//  Copyright © 2016 Priyanshu Bhatnagar. All rights reserved.
//

#import "MyUITableViewController.h"
#import <CoreData/CoreData.h>
#import "ReminderEntity.h"
#import "MyUITableViewCell.h"
#import "ManageReminderEntity.h"

@interface MyUITableViewController ()<NSFetchedResultsControllerDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) NSFetchedResultsController *resultsController;
@property(strong,nonatomic) NSManagedObjectContext *managedObjectContext;
@end

@implementation MyUITableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeNSFetchedResultsControllerDelegate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return self.resultsController.sections[section].numberOfObjects;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ReminderEntity *item = self.resultsController.sections[indexPath.section].objects[indexPath.row];
    
   MyUITableViewCell *cell = (MyUITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TableViewCellIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    [cell setInternalFields:item];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    id<ManageMOC,ManageReminderEntity> child = (id<ManageMOC,ManageReminderEntity>)[segue destinationViewController];
    [child receiveManageMOC:self.managedObjectContext];
    ReminderEntity *item;
    if([sender isMemberOfClass:[UIBarButtonItem class]]){
    item = [NSEntityDescription insertNewObjectForEntityForName:@"ReminderEntity" inManagedObjectContext:self.managedObjectContext];
    }else{
        MyUITableViewCell *source = (MyUITableViewCell *) sender;
        item = source.localRemindEntity;
    }
    [child receiveReminderEntity:item];
}

-(void) receiveManageMOC:(NSManagedObjectContext *)incomingMOC{
    self.managedObjectContext = incomingMOC;
}

-(void)initializeNSFetchedResultsControllerDelegate{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"ReminderEntity" inManagedObjectContext:self.managedObjectContext];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"TRUEPREDICATE"];
    fetchRequest.sortDescriptors = @[[[NSSortDescriptor alloc]initWithKey:@"remindStatus" ascending:YES]];
    
    self.resultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    self.resultsController.delegate = self;
    
    
    NSError *err;
    BOOL fetchSucceed = [self.resultsController performFetch:&err];
    if(!fetchSucceed){
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Couldn't fetch" userInfo:nil];
    }
}

-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView beginUpdates];
}

-(void) controller:(NSFetchedResultsController *) controller didChangeObject:(nonnull id)anObject atIndexPath:(nullable NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(nullable NSIndexPath *)newIndexPath{

    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [[self tableView]insertRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationRight];
            break;
            
        case NSFetchedResultsChangeDelete:
            [[self tableView]deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationLeft];
            break;
        case NSFetchedResultsChangeUpdate:{
            MyUITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            ReminderEntity *item = [controller objectAtIndexPath:indexPath];
            [cell setInternalFields:item];
            break;
        }

        case NSFetchedResultsChangeMove:
            [[self tableView]deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil]  withRowAnimation:UITableViewRowAnimationLeft];
            [[self tableView]insertRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil]  withRowAnimation:UITableViewRowAnimationRight];
            break;
        default:
            break;
    }
}
-(void) controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView endUpdates];
}


@end
