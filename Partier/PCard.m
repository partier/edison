//
//  PCard.m
//  Partier
//
//  Created by Zachary Lewis on 9/10/14.
//  Copyright (c) 2014 The Game Studio. All rights reserved.
//

#import "PCard.h"

@implementation PCard
@synthesize title, body, help, type;

- (id)init
{
	self = [super init];
	if (self)
	{
		// Default constructor.
		// Create dummy values.
		static uint count = 1;
		title = [NSString stringWithFormat:@"Card %d", count];
		body = [NSString stringWithFormat:@"Body text for card %d.", count];
		help = [NSString stringWithFormat:@"Help text for card %d.", count];
		count++;
	}
	
	return self;
}

@end


