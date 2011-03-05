//
//  BrowserViewController.m
//  DealFork
//
//  Created by Sheehan Alam on 2/20/11.
//  Copyright 2011 Home. All rights reserved.
//

#import "BrowserViewController.h"
#import "FlurryAPI.h"

@implementation BrowserViewController
@synthesize closeButton, webView, url;

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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	//Create a URL object.
	NSURL *dealURL = [NSURL URLWithString:url];
	
	//URL Requst Object
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:dealURL];
	
	//Load the request in the UIWebView.
	[webView loadRequest:requestObj];
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
	[closeButton release];
	[webView release];
	[url release];
    [super dealloc];
}

#pragma mark IBAction Methods
-(IBAction)closeBrowser:(id)sender
{
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:url, @"url", nil];
	[FlurryAPI logEvent:@"CLOSE_BUTTON_CLICKED" withParameters:params];
	
	[self dismissModalViewControllerAnimated:YES];
}

@end
