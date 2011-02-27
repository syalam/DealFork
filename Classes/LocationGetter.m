//
//  LocationGetter.m
//  CoreLocationExample
//
//  Created by Matt on 7/9/09.
//  Copyright 2009 iCodeBlog. All rights reserved.
//

#import "LocationGetter.h"
#import <CoreLocation/CoreLocation.h>

@implementation LocationGetter

@synthesize locationManager, delegate;

BOOL didUpdate = NO;

- (void)startUpdates
{
    NSLog(@"Starting Location Updates");
    
    if (locationManager == nil)
        locationManager = [[CLLocationManager alloc] init];
    
    locationManager.delegate = self;
    
    // You have some options here, though higher accuracy takes longer to resolve.
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;  
    [locationManager startUpdatingLocation];    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your location could not be determined." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    [alert release];      
}

// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manage didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if (didUpdate)
        return;
    
    didUpdate = YES;
    
	// Disable future updates to save power.
    [locationManager stopUpdatingLocation];
	        
    // let our delegate know we're done
    [delegate newPhysicalLocation:newLocation];
}

- (void)dealloc
{
    [locationManager release];

    [super dealloc];
}

@end
