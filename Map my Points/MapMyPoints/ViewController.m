//
//  ViewController.m
//  MapMyPoints
//
//  Created by OSX on 10/07/16.
//  Copyright © 2016 OSX. All rights reserved.
//

#import "ViewController.h"
#import "MapKit/MapKit.h"

@interface ViewController () <MKMapViewDelegate ,CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property(strong,nonatomic) MKPointAnnotation *luciAnnno;
@property(strong,nonatomic) MKPointAnnotation *wiclAnnno;
@property(strong,nonatomic) MKPointAnnotation *gradientAnnno;
@property (weak, nonatomic) IBOutlet UISwitch *switchField;
@property (strong,nonatomic) CLLocationManager *locationManger;
@property (strong,nonatomic) MKPointAnnotation *current;
@property (nonatomic,assign) BOOL mapIsMoving;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManger = [[CLLocationManager alloc]init];
    self.locationManger.delegate = self;
    [self.locationManger requestWhenInUseAuthorization];
    
    self.mapIsMoving = NO;
    
    [self addAnnotations];
    
}
- (IBAction)switchChanged:(id)sender {
    if(self.switchField.isOn){
    self.mapView.showsUserLocation = YES;
    [self.locationManger startUpdatingLocation];
    }
    else{
        self.mapView.showsUserLocation = NO;
        [self.locationManger stopUpdatingLocation];
    }
    
}
-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    self.current.coordinate = locations.lastObject.coordinate;
   
    if(self.mapIsMoving == NO){
    [self centerMap:self.current];
   }
}

- (IBAction)luciTappef:(id)sender {
    [self centerMap:self.luciAnnno];
    
}
- (IBAction)wiclTapped:(id)sender {
    [self centerMap:self.wiclAnnno];
 
}

- (IBAction)gradientTappef:(id)sender {
    [self centerMap:self.gradientAnnno];
    
}
-(void) centerMap: (MKPointAnnotation *)centerPoint{
 
    [self.mapView setCenterCoordinate:centerPoint.coordinate animated:YES];
    
}

-(void) addAnnotations{
    self.luciAnnno = [[MKPointAnnotation alloc]init];
    self.luciAnnno.coordinate = CLLocationCoordinate2DMake(33.6432094,-117.8439953 );
    self.luciAnnno.title = @"Laboratory for Ubiquitous Computing and Interaction";
   
    self.wiclAnnno = [[MKPointAnnotation alloc]init];
    self.wiclAnnno.coordinate = CLLocationCoordinate2DMake(34.448795,-119.6646337 );
    self.wiclAnnno.title = @"Westmont Inspired Computing Lab";
   
    self.gradientAnnno = [[MKPointAnnotation alloc]init];
    self.gradientAnnno.coordinate = CLLocationCoordinate2DMake(48.677623,-73.993583 );
    self.gradientAnnno.title = @"Gradient LLC";
   
    self.current = [[MKPointAnnotation alloc]init];
    self.current.coordinate = CLLocationCoordinate2DMake(0.0,0.0 );
    self.current.title = @"My Location";
    
    
    [self.mapView addAnnotation:self.luciAnnno];
        [self.mapView addAnnotation:self.wiclAnnno];
        [self.mapView addAnnotation:self.gradientAnnno];
    [self.mapView addAnnotation:self.current];

    
}

-(void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    self.mapIsMoving = YES;
}
-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    self.mapIsMoving = NO;
}

@end
