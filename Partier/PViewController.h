//
//  PViewController.h
//  Partier
//
//  Created by Zachary Lewis on 9/10/14.
//  Copyright (c) 2014 The Game Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PViewController : UIViewController {
	IBOutlet UILabel *cardTitle;
	IBOutlet UITextView *cardBody;
	IBOutlet UITextView *cardHelp;
    IBOutlet UIButton *requestButton;
}

- (IBAction)newCardPressed:(id)sender;

@end
