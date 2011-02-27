//
//  BrowserViewController.h
//  DealFork
//
//  Created by Sheehan Alam on 2/20/11.
//  Copyright 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BrowserViewController : UIViewController {
	IBOutlet	UIBarButtonItem*	closeButton;
	IBOutlet	UIWebView*			webView;
				NSString*			url;
}

@property(nonatomic,retain)UIBarButtonItem*	closeButton;
@property(nonatomic,retain)UIWebView*	webView;
@property(nonatomic,retain)NSString*			url;

-(IBAction)closeBrowser:(id)sender;

@end
