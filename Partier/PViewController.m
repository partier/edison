//
//  PViewController.m
//  Partier
//
//  Created by Zachary Lewis on 9/10/14.
//  Copyright (c) 2014 The Game Studio. All rights reserved.
//

#import "PViewController.h"
#import "PCard.h"

@interface PViewController ()

@end

@implementation PViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)newCardPressed:(id)sender
{
	// TODO: Make a URL request to the server to obtain a JSON object of the card.
	// TODO: Replace default constructor of PCard with one that accepts a JSON object.

	PCard *newCard = [[PCard alloc] init];
	
	[cardTitle setText:newCard.title];
	[cardBody setText:newCard.body];
	[cardHelp setText:newCard.help];
}

@end
