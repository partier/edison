//
//  PCardViewController.m
//  Partier
//
//  Created by Zachary Lewis on 10/22/14.
//  Copyright (c) 2014 The Game Studio. All rights reserved.
//

#import "PCardViewController.h"

@interface PCardViewController ()

@end

@implementation PCardViewController
@synthesize cardIndex, card;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Populate the card based on the data object.
	if (!card)
	{
		card = [[PCard alloc] initSample];
	}
	
	self.titleLabel.text = self.card.title;
	self.bodyTextView.text = self.card.body;
	self.helpTextView.text = self.card.help;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
