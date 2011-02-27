//
//  RootViewController.h
//  DealFork
//
//  Created by Sheehan Alam on 2/20/11.
//  Copyright 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationGetter.h"

@interface RootViewController : UIViewController {
	IBOutlet UIActivityIndicatorView	*spinner;
	CLLocation *lastKnownLocation;
}

@property(nonatomic,retain)	IBOutlet UIActivityIndicatorView	*spinner;
@property (nonatomic, retain) CLLocation *lastKnownLocation;

@end
