//
//  PCardViewController.h
//  Partier
//
//  Created by Zachary Lewis on 10/22/14.
//  Copyright (c) 2014 The Game Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "PCard.h"
#include "PCardViewController.h"

@interface PCardViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property NSUInteger cardIndex;
@property PCard *card;
@end
