//
//  MyPickerViewController.m
//  Reminder
//
//  Created by Priyanshu Bhatnagar on 21/07/16.
//  Copyright © 2016 Priyanshu Bhatnagar. All rights reserved.
//

#import "MyPickerViewController.h"

@interface MyPickerViewController ()
@property(nonatomic) NSArray *pickerData;
@end

@implementation MyPickerViewController

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

-(void) setArray{
    self.pickerData = [NSMutableArray arrayWithArray:@[@"Important",@"Normal",@"Trivial"]];
    }

-(NSInteger) pickerView: (UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.pickerData count];
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [[self.pickerData objectAtIndex:row]description];
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSArray *) getArray{
return self.pickerData;
}
@end
