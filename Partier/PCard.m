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

// Constructor from a dictionary populated via NSJSONSerialization
- (id)initFromNSDictionary:(NSDictionary*)dict
{
    self = [super init];
    if (self)
    {
        title = [dict objectForKey:@"title"];
        body  = [dict objectForKey:@"body"];
		if ([dict objectForKey:@"help"] == (id)[NSNull null])
		{
			help = @"";
		}
		else
		{
			help  = [dict objectForKey:@"help"];
		}
        type  = [[dict objectForKey:@"type"] lowercaseString];
        
        // TODO: de-serialize isViewed if the server ever knows/cares
        _isViewed = NO;
    }
    return self;
}

- (id)initSample
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
        type = @"Sample";
        _isViewed = NO;
		count++;
	}
	
	return self;
}

- (void)setCardViewed
{
    _isViewed = YES;
}

@end


