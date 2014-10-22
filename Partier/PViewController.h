//
//  PViewController.h
//  Partier
//
//  Created by Zachary Lewis on 9/10/14.
//  Copyright (c) 2014 The Game Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCard.h"
#import "PCardViewController.h"
#import "Constants.h"

@interface PViewController : UIViewController <UIPageViewControllerDataSource>
{
	IBOutlet UIButton *requestButton;
}

- (IBAction)newCardPressed:(id)sender;

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSMutableArray *cards;
@property NSUInteger currentIndex;

@end
