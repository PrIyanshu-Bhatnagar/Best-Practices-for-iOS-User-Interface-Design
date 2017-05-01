//
//  ViewController.m
//  Demo2
//
//  Created by OSX on 04/07/16.
//  Copyright © 2016 OSX. All rights reserved.
//

#import "ViewController.h"
#import "MapKit/MapKit.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //initialize webpage
    NSString *webURL = @"https://www.facebook.com/westmontinspiredcomputinglab";
    NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:[NSURL URLWithString:webURL]];
    [self.webView loadRequest:request];
    
    //center the map
    double longitude = 72.831061;
    double latitude = 21.170240;
    
    MKPointAnnotation *wiclAnno = [[MKPointAnnotation alloc]init];
    wiclAnno.coordinate = CLLocationCoordinate2DMake(latitude,longitude);
    wiclAnno.title = @"Westmont Inspired Computing Lab";
    
    [self.mapView addAnnotation:wiclAnno];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(wiclAnno.coordinate, 100000, 100000);
    MKCoordinateRegion adjusted = [self.mapView regionThatFits:region];
    [self.mapView setRegion:adjusted animated:YES];
}


@end
