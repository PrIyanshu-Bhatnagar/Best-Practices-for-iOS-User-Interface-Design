//
//  MyTableViewController.m
//  ToDoManager
//
//  Created by Priyanshu Bhatnagar on 18/07/16.
//  Copyright © 2016 Priyanshu Bhatnagar. All rights reserved.
//

#import "MyTableViewController.h"
#import <CoreData/CoreData.h>
#import "ToDoEntity.h"
#import "DPHandlesMOC.h"
#import "DPHandlesToDoEntity.h"
#import "MyUITableViewCell.h"

@interface MyTableViewController ()<NSFetchedResultsControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong,nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong,nonatomic) NSFetchedResultsController *resultController;

@end

@implementation MyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeNSFetchedResultsControllerDelegate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete implementation, return the number of rows
    return self.resultController.sections[section].numberOfObjects;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ToDoEntity *item = self.resultController.sections[indexPath.section].objects[indexPath.row];
    MyUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableCellIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    
    [cell setInternalFields:item];
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    id<DPHandlesMOC,DPHandlesToDoEntity> child=(id<DPHandlesMOC,DPHandlesToDoEntity>)[segue destinationViewController];
    
    [child receiveMOC:self.managedObjectContext];
    ToDoEntity *item;
    if([sender isMemberOfClass:[UIBarButtonItem class]]){
        item = [NSEntityDescription insertNewObjectForEntityForName:@"ToDoEntity" inManagedObjectContext:self.managedObjectContext];
    }
    else{
        MyUITableViewCell *source = (MyUITableViewCell *) sender;
        item = source.localToDoEntity;
    }
    
    [child receiveToDoEntity:item];
}


-(void) receiveMOC:(NSManagedObjectContext *)incomingMOC{
    self.managedObjectContext = incomingMOC;
    
}


#pragma mark - NSFetchedResultsControllerDelegate

-(void) initializeNSFetchedResultsControllerDelegate{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    
    fetchRequest.entity = [NSEntityDescription entityForName:@"ToDoEntity" inManagedObjectContext:self.managedObjectContext];
    
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"TRUEPREDICATE"];
    
    fetchRequest.sortDescriptors = @[[[NSSortDescriptor alloc]initWithKey:@"toDoTitle" ascending:YES]];
    
    self.resultController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    self.resultController.delegate = self;
    
    NSError *err;
    
    BOOL fetchSucceed = [self.resultController performFetch:&err];
    
    if(!fetchSucceed){
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Couldn't fetch" userInfo:nil];
        
    }
}

-(void) controllerWillChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView beginUpdates];
}


-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [[self tableView] insertRowsAtIndexPaths:[NSArray arrayWithObjects:newIndexPath,nil] withRowAnimation:UITableViewRowAnimationRight];
            break;
            
        case NSFetchedResultsChangeDelete:
            [[self tableView] deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            break;
            
        case NSFetchedResultsChangeMove:
            [[self tableView] deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            [[self tableView] insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
            break;
            
        case NSFetchedResultsChangeUpdate:{
            
            MyUITableViewCell *cell =[[self tableView] cellForRowAtIndexPath:indexPath];
            ToDoEntity *item = [controller objectAtIndexPath:indexPath];
            [cell setInternalFields:item];
            break;
        }
    }
}

-(void) controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView endUpdates];
}



@end
