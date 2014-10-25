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
    
    // Generate sample card
	self.cards = [[NSMutableArray alloc] init];
	PCard* c = [[PCard alloc] init];
	c.title = @"High Five Robot";
	c.body = @"You are a model HI-5 party enhancement robot. Your enhancement subroutines dictates that you identify targets in your proximity and enhance their experience by delivering a high five. The subroutine ends after you've high-fived all eligible targets.";
	c.help = @"While all robots are governed by Asimov's three laws of robotics, the HI-5 is governed by an additional fourth law which states, \"A robot must keep the party going as long as doing so doesn't conflict with the First, Second or Third law.\" Also, here's a bunch of extra text to make sure that card scrolling works properly and feels correct. The user should be able to scroll the card so card text doesn't have to be limited at all.";
	[self.cards addObject:[[PCard alloc] initSample]];
	[self.cards addObject:[[PCard alloc] initSample]];
	[self.cards addObject:c];
	
	// Create page view controller
	self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
	self.pageViewController.dataSource = self;
	
	self.currentIndex = 0;
	PCardViewController *startingViewController = [self viewControllerAtIndex:0];
	NSArray *viewControllers = @[startingViewController];
	[self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
	
	// Change the size of page view controller
	self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
	
	[self addChildViewController:_pageViewController];
	[self.view addSubview:_pageViewController.view];
	[self.pageViewController didMoveToParentViewController:self];
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
            // Add new card to the front of the list and jump to it.
			PCard* newCard = [[PCard alloc] initFromNSDictionary:cardParsedJSON];
			[self.cards insertObject:newCard atIndex:0];
			
			if ([self.cards count] > kMaximumCardCount)
			{
				[self.cards removeLastObject];
			}
			
			PCardViewController *startingViewController = [self viewControllerAtIndex:0];
			NSArray *viewControllers = @[startingViewController];
			[self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        
            // Re-Enable request button
            requestButton.enabled = YES;
        }
    }
}
// end NSURLConnectionDelegate implementation

#pragma mark - Page View Controller Data Source
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
	NSUInteger index = ((PCardViewController*) viewController).cardIndex;
	if ((index == 0) || (index == NSNotFound)) {
		return nil;
	}
	
	index--;
	
	return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
	NSUInteger index = ((PCardViewController*) viewController).cardIndex;
	
	if (index == NSNotFound) {
		return nil;
	}
	
	index++;
	if (index == [self.cards count]) {
		return nil;
	}
	return [self viewControllerAtIndex:index];
}

- (PCardViewController *)viewControllerAtIndex:(NSUInteger)index
{
	if (([self.cards count] == 0) || (index >= [self.cards count])) {
		return nil;
	}
	
	// Create a new view controller and pass suitable data.
	PCardViewController *cardViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PCardViewController"];
	cardViewController.card = (PCard*)[self.cards objectAtIndex:index];
	cardViewController.cardIndex = index;
	self.currentIndex = index;
	
	return cardViewController;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
	return [self.cards count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
	return 0;
}
@end
