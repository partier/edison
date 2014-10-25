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
	
	// Create font descriptors to apply to card text.
	UIFont* defaultFont = [UIFont systemFontOfSize:14.0];
	UIFont* italicFont = [UIFont italicSystemFontOfSize:14.0];
	
	// Create the string and calculate some metrics.
	NSString* cardText = [NSString stringWithFormat:@"%@\n\n%@", self.card.body, self.card.help];
	NSUInteger bodyLength = self.card.body.length;
	NSUInteger helpLength = self.card.help.length;
	NSUInteger spacingLength = cardText.length - bodyLength - helpLength;
	
	NSMutableAttributedString* attributedCardText = [[NSMutableAttributedString alloc] initWithString:cardText];
	// Apply italics to the range of characters starting from the first letter in the help text, counting two characters for the newlines.
	[attributedCardText addAttribute:NSFontAttributeName value:defaultFont range:NSMakeRange(0, bodyLength)];
	[attributedCardText addAttribute:NSFontAttributeName value:italicFont range:NSMakeRange(bodyLength + spacingLength, helpLength)];
	
	self.textView.attributedText = attributedCardText;
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
