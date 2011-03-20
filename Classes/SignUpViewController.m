//
//  SignUpViewController.m
//  DealFork
//
//  Created by Sheehan Alam on 3/13/11.
//  Copyright 2011 Home. All rights reserved.
//

#import "SignUpViewController.h"
#import "FlurryAPI.h"

@implementation SignUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [signUpButton release];
    [CloseButton release];
    [signUpButton release];
    [signUpTextField release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //TODO: make textfield first responder
    [signUpTextField becomeFirstResponder];
}

- (void)viewDidUnload
{
    [signUpButton release];
    signUpButton = nil;
    [CloseButton release];
    CloseButton = nil;
    [signUpTextField release];
    signUpTextField = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)closeButtonClicked:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)signUpButtonClicked:(id)sender {
    NSLog(@"do mailchimp stuff here");
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:signUpTextField.text, @"email-address", nil];
	[FlurryAPI logEvent:@"SIGN_UP_BUTTON_CLICKED" withParameters:params];
}

@end
