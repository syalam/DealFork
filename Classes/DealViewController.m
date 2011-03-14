//
//  DealView.m
//  DealFork
//
//  Created by Sheehan Alam on 2/20/11.
//  Copyright 2011 Home. All rights reserved.
//

#import "DealViewController.h"
#import "BrowserViewController.h"
#import "JSON.h"
#import "TCImageView.h"
#include <stdlib.h>
#import "FlurryAPI.h"
#import "SignUpViewController.h"

@implementation DealViewController
@synthesize buyButton, dislikeButton, likeButton, items, receivedData, lastKnownLocation, dealImageView;
@synthesize businessLabel;
@synthesize phoneLabel;
@synthesize addressLabel;
@synthesize descriptionLabel;
@synthesize aDeal;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

#pragma mark Application Lifecycle Methods
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	//self.title = @"DealFork";
	dealIndex = 0;
	[self loadDeals];
    
    UIImageView* img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"toplogo.png"]];
    self.navigationItem.titleView = img;
    [img release];
}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	self.navigationItem.hidesBackButton = YES;
}

-(void) viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[buyButton release];
	[dislikeButton release];
	[likeButton release];
	[items release];items=nil;
	[receivedData release];receivedData=nil;
	[lastKnownLocation release];
	[dealImageView release];
	[businessLabel release];
	[phoneLabel release];
	[addressLabel release];
	[descriptionLabel release];
	[aDeal release];
	
    [super dealloc];
}

#pragma mark Deal Methods
-(void)displayDeal:(int) index
{	
	//RANDOMIZER CODE
    /*
    //int r = rand() % [items count];
	//int r = ((int)rand() / (int)RAND_MAX) * [items count];
	int r = arc4random() % ([items count]);
    
	NSLog(@"Random Number: %d",r);
	NSLog(@"Items Count: %d", [items count]);
    */
    
    if(index < [items count])
        aDeal = [items objectAtIndex:index];
    else
    {
        NSLog(@"SHOW DEAL FORK SIGNUP HERE!");
        SignUpViewController* svc = [[SignUpViewController alloc] initWithNibName:@"SignUpViewController" bundle:nil];
        [self.navigationController setNavigationBarHidden:NO];
        [self.navigationController presentModalViewController:svc animated:YES];
    }
	
	//Populate the Labels
	NSArray *locations = [[aDeal objectForKey:@"business"] valueForKey:@"locations"];
	
	for(NSDictionary* location in locations)
	{
		NSLog(@"Address: %@", [location valueForKey:@"address"]);
		NSLog(@"Phone: %@", [location valueForKey:@"phone"]);
		
		if([location valueForKey:@"phone"] == nil || [[location valueForKey:@"phone"] isKindOfClass:[NSNull class]])
		   phoneLabel.text = @"N/A";
		else
		   phoneLabel.text = [location valueForKey:@"phone"];
		   
		addressLabel.text = [location valueForKey:@"address"];
	}
	
	businessLabel.text = [[aDeal valueForKey:@"business"] valueForKey:@"name"];
	descriptionLabel.text = [aDeal valueForKey:@"title"];
	
	//Load the image
	/*NSString* dealImageURL = [[aDeal valueForKey:@"images"] valueForKey:@"image_small"];
	dealImageView = [[TCImageView alloc] initWithURL:[NSURL URLWithString:dealImageURL] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    dealImageView.frame = CGRectMake(19.0, 20.0, 100.0, 80.0);
	[dealImageView loadImage];
	[self.view addSubview:dealImageView];*/
    
    dealIndex++;
}

-(void)loadDeals
{
	//JSON URL
	//NSString* url = [NSString stringWithFormat:@"http://api.yipit.com/v1/deals/?key=a4p2ZB3R5ByDtHGk&lat=%f&lon=%f&tag=restaurants", 
	//lastKnownLocation.coordinate.latitude, lastKnownLocation.coordinate.longitude];	
	
	NSString* url = @"http://api.yipit.com/v1/deals/?key=a4p2ZB3R5ByDtHGk&division=new-york&tag=restaurants";

		
	// Prepare URL request to download statuses from StockTwits
	NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
	conn=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if (conn) {
		self.receivedData = [NSMutableData data];
	} else {
		NSLog(@"Connection Failed!");
	}			
}

#pragma mark IBActions
-(IBAction)buyButtonClicked:(id)sender{
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[aDeal valueForKey:@"title"], @"deal", nil];
	[FlurryAPI logEvent:@"ORDER_BUTTON_CLICKED" withParameters:params];
	
	BrowserViewController* bvc = [[BrowserViewController alloc] initWithNibName:@"BrowserViewController" bundle:nil];
	bvc.url = [aDeal valueForKey:@"url"];
	[self.navigationController setNavigationBarHidden:NO];
	[self.navigationController presentModalViewController:bvc animated:YES];
}

-(IBAction)likeButtonClicked:(id)sender{
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[aDeal valueForKey:@"title"], @"deal", nil];
	[FlurryAPI logEvent:@"NEXT_BUTTON_CLICKED" withParameters:params];

	[self displayDeal:dealIndex];
}

-(IBAction)dislikeButtonClicked:(id)sender
{
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[aDeal valueForKey:@"title"], @"deal", nil];
	[FlurryAPI logEvent:@"DISLIKE_BUTTON_CLICKED" withParameters:params];
	
}

#pragma mark NSURLConnection delegate methods
- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{		
    // inform the user
    NSLog(@"Connection failed! Error - %@",
          [error localizedDescription]);
	
	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
	[alertView release];
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {  
	// this method is called when the server has determined that it
    // has enough information to create the NSURLResponse
	
    // it can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    // receivedData is declared as a method instance elsewhere
	
	[receivedData setLength:0];  
}  

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[receivedData appendData:data];  
}  

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSLog(@"RECEIVED DATA SIZE IS: %d",[receivedData length]);
	
	items = [[NSMutableArray alloc]init];
	
	// Get JSON as a NSString from NSData response
	NSString *json_string = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
	
	//Build dictionary out of JSON value
	NSDictionary *results = [json_string JSONValue];
	[json_string release];
	
	//Pull out the deals block
	NSArray *deals = [[results objectForKey:@"response"] valueForKey:@"deals"];
	NSLog(@"%@",[[results objectForKey:@"response"] valueForKey:@"deals"]);
	
	for(NSDictionary* deal in deals)
	{
		NSLog(@"Title: %@", [deal valueForKey:@"title"]);
		NSLog(@"URL: %@", [deal valueForKey:@"url"]);
		NSLog(@"Value: %@", [[deal valueForKey:@"value"] valueForKey:@"formatted"]);
		NSLog(@"Picture URL: %@", [[deal valueForKey:@"images"] valueForKey:@"image_small"]);
		NSLog(@"Business: %@", [[deal valueForKey:@"business"] valueForKey:@"name"]);
		[items addObject:deal];
	}
	
	NSLog(@"Items Count: %d", [items count]);
	[self displayDeal:dealIndex];
}

#pragma mark Motion Methods
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {	
    if (motion == UIEventSubtypeMotionShake) {
        NSLog(@"BOOM SHAKA LAKA!");
        [self displayDeal:dealIndex];
    }
    else {
        NSLog(@"{not shaken state ");           
    }
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

@end
