//
//  DealView.h
//  DealFork
//
//  Created by Sheehan Alam on 2/20/11.
//  Copyright 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationGetter.h"
#import "TCImageView.h"

@interface DealViewController : UIViewController {
	IBOutlet UIBarButtonItem*	buyButton;
	IBOutlet UIBarButtonItem*	dislikeButton;
	IBOutlet UIBarButtonItem*	likeButton;
	IBOutlet UILabel*			businessLabel;
	IBOutlet UILabel*			phoneLabel;
	IBOutlet UILabel*			addressLabel;
	IBOutlet UILabel*			descriptionLabel;
	
	NSMutableArray*		items;
	NSMutableData*		receivedData;
	NSURLConnection*	conn;
	NSDictionary*		aDeal;
    int                 dealIndex;
	
	TCImageView*	dealImageView;
	
	CLLocation *lastKnownLocation;
}

@property(nonatomic,retain)	IBOutlet UIBarButtonItem*	buyButton;
@property(nonatomic,retain)	IBOutlet UIBarButtonItem*	dislikeButton;
@property(nonatomic,retain)	IBOutlet UIBarButtonItem*	likeButton;
@property(nonatomic, retain) CLLocation*				lastKnownLocation;
@property(nonatomic,retain)	NSMutableArray*				items;
@property(nonatomic,retain)	NSMutableData*				receivedData;
@property(nonatomic,retain)	TCImageView*				dealImageView;
@property(nonatomic,retain)	IBOutlet UILabel*			businessLabel;
@property(nonatomic,retain)	IBOutlet UILabel*			phoneLabel;
@property(nonatomic,retain)	IBOutlet UILabel*			addressLabel;
@property(nonatomic,retain)	IBOutlet UILabel*			descriptionLabel;
@property(nonatomic,retain) NSDictionary*				aDeal;

-(IBAction)buyButtonClicked:(id)sender;
-(IBAction)likeButtonClicked:(id)sender;
-(IBAction)dislikeButtonClicked:(id)sender;
-(void)loadDeals;
-(void)displayDeal:(int)index;
@end
