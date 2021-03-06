//
//  PCard.h
//  Partier
//
//  Created by Zachary Lewis on 9/10/14.
//  Copyright (c) 2014 The Game Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCard : NSObject
{
	NSString *title;
	NSString *body;
	NSString *help;
	NSString *type;
	NSString *cardId;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *help;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *cardId;
@property (nonatomic, readonly) Boolean isViewed;

- (id)initFromNSDictionary:(NSDictionary*)dict;
- (id)initSample;
- (void)setCardViewed;

@end
