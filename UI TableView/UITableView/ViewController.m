//
//  ViewController.m
//  UITableView
//
//  Created by Priyanshu Bhatnagar on 16/07/16.
//  Copyright © 2016 Priyanshu Bhatnagar. All rights reserved.
//
#import "myCellTableViewCell.h"
#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong,nonatomic) NSMutableArray *ourStrings;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.ourStrings = [NSMutableArray arrayWithArray:@[@"The first row", @"More data"]];
    
}
- (IBAction)sortTapped:(id)sender {
    for(long i = self.ourStrings.count - 2; i>=0; i--){
        for(long j=i; j< self.ourStrings.count - 1; j++){
            if([self.ourStrings[j] compare:self.ourStrings[j+1]] > 0){
            //swap elements
                [self.tableView beginUpdates];
                
                [self.ourStrings exchangeObjectAtIndex:j withObjectAtIndex:j+1];
   
                NSIndexPath *firstIndex = [NSIndexPath indexPathForRow:j inSection:0];
                
                NSIndexPath *secondIndex = [NSIndexPath indexPathForRow:j+1 inSection:0];
   
                [self.tableView moveRowAtIndexPath:firstIndex toIndexPath:secondIndex];
                
                [self.tableView endUpdates];
            }
        }
    }
}

- (IBAction)addTapped:(id)sender {
    [self.tableView beginUpdates];
    
    [self.ourStrings addObject:self.textField.text];
    
    NSInteger newRow = [self.ourStrings count] -1;
    NSIndexPath *newIndex = [NSIndexPath indexPathForRow:newRow inSection:0];
    
    [self.tableView insertRowsAtIndexPaths:@[newIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self.tableView reloadData];
    [self.tableView endUpdates];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDatasource

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ourStrings.count;
    
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    myCellTableViewCell *cell = (myCellTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"ourCell" forIndexPath:indexPath];
    cell.ourCellLabel.text = self.ourStrings[indexPath.row];
    return  cell;
}

@end
