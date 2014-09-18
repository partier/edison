//
//  PViewController.m
//  Partier
//
//  Created by Zachary Lewis on 9/10/14.
//  Copyright (c) 2014 The Game Studio. All rights reserved.
//

#import "PViewController.h"
#import "PCard.h"
#import "Constants.h"

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
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)newCardPressed:(id)sender
{
	// TODO: Replace default constructor of PCard with one that accepts a JSON object.

    [self requestNewCard];
    
    /*
	
    PCard *newCard = [[PCard alloc] init];
	
	[cardTitle setText:newCard.title];
	[cardBody setText:newCard.body];
	[cardHelp setText:newCard.help];
     
    */
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
        NSDictionary *cardParsedJSON = [NSJSONSerialization JSONObjectWithData:cardData
                                                         options:0
                                                           error:NULL];
        
        [cardTitle setText:[cardParsedJSON objectForKey:@"title"]];
        [cardBody  setText:[cardParsedJSON objectForKey:@"body"]];
        [cardHelp  setText:[cardParsedJSON objectForKey:@"help"]];
        
        // Re-Enable request button
        requestButton.enabled = YES;
    }
}
// end NSURLConnectionDelegate implementation

@end
