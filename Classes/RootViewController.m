//
//  RootViewController.m
//  DealFork
//
//  Created by Sheehan Alam on 2/20/11.
//  Copyright 2011 Home. All rights reserved.
//

#import "RootViewController.h"
#import "DealViewController.h"

@implementation RootViewController
@synthesize spinner;
@synthesize lastKnownLocation;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
	// get our physical location
    LocationGetter *locationGetter = [[LocationGetter alloc] init];
    locationGetter.delegate = self;
    [locationGetter startUpdates]; 
	 
	 // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	//hide the navbar, because this is our splash screen
	[self.navigationController.navigationBar setHidden:YES];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */



#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[spinner dealloc];
	[lastKnownLocation release];
    [super dealloc];
}

# pragma mark -
# pragma mark LocationGetter Delegate Methods

- (void)newPhysicalLocation:(CLLocation *)location {
    
    // Store for later use
    self.lastKnownLocation = location;
	
	[spinner stopAnimating];
	
    // Alert user
    /*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location Found" message:[NSString stringWithFormat:@"Found physical location.  %f %f", self.lastKnownLocation.coordinate.latitude, self.lastKnownLocation.coordinate.longitude] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    [alert release]; */
	
	//Show the deals
	DealViewController *dvc = [[DealViewController alloc] initWithNibName:@"DealViewController" bundle:nil];
	dvc.lastKnownLocation = self.lastKnownLocation;
	
	[self.navigationController.navigationBar setHidden:NO];
	self.navigationItem.hidesBackButton = YES;
	[self.navigationController pushViewController:dvc animated:YES];
}


@end

