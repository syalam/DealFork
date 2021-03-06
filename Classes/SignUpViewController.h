//
//  SignUpViewController.h
//  DealFork
//
//  Created by Sheehan Alam on 3/13/11.
//  Copyright 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SignUpViewController : UIViewController <UITextFieldDelegate> {
    IBOutlet UIBarButtonItem *CloseButton;
    IBOutlet UIButton *signUpButton;
    IBOutlet UITextField *signUpTextField;
}

- (IBAction)closeButtonClicked:(id)sender;
- (IBAction)signUpButtonClicked:(id)sender;

@end
