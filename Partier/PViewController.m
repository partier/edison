//
//  PViewController.m
//  Partier
//
//  Created by Zachary Lewis on 9/10/14.
//  Copyright (c) 2014 The Game Studio. All rights reserved.
//

#import "PViewController.h"

@interface PViewController () <NSURLConnectionDelegate>
{
    NSURLConnection *cardConnection;
    NSMutableData *cardData;
}
@end

@implementation PViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    
    // Generate sample card
    if (_card == nil)
    {
        _card = [[PCard alloc] initSample];
        [self renderCurrentCard];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)newCardPressed:(id)sender
{
    [self requestNewCard];
}

- (void)requestNewCard
{
    // TODO: separate object to handle webservice calls?
    NSURL *requestURL = [NSURL URLWithString: kWebEndpointGetCard];
    NSURLRequest *request = [NSURLRequest requestWithURL:requestURL];
    
    cardData = [NSMutableData new];
    cardConnection = [NSURLConnection connectionWithRequest:request
                                                   delegate:self];
    
    // Disable request button until request is finished
    requestButton.enabled = NO;
}

//NSURLConnectionDelegate implementation
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // TODO: Handle failed requests
    NSLog(@"Request Failed");
    
    // Re-Enable request button
    requestButton.enabled = YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [cardData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (cardData.length > 0)
    {
        // Generate dictionary from JSON
        NSError *e = nil;
        NSDictionary *cardParsedJSON = [NSJSONSerialization JSONObjectWithData:cardData
                                                         options:0
                                                           error:NULL];
        if (!cardParsedJSON)
        {
            NSLog(@"Error parsing card JSON: %@", e);
        }
        else
        {
            // Set card, render
            _card = [[PCard alloc] initFromNSDictionary:cardParsedJSON];
            [self renderCurrentCard];
        
            // Re-Enable request button
            requestButton.enabled = YES;
        }
    }
}
// end NSURLConnectionDelegate implementation

- (void)renderCurrentCard
{
    if (_card != nil)
    {
        [cardTitle setText:_card.title];
        [cardBody setText:_card.body];
        [cardHelp setText:_card.help];
        
        [_card setCardViewed];
    }
}
@end
