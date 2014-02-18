//
//  ViewController.h
//  Deneme_Yemek
//
//  Created by Egemen AYHAN on 15.02.2014.
//  Copyright (c) 2014 Egemen AYHAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property NSMutableArray *soups;
@property NSMutableArray *appetizers;
@property NSMutableArray *meals;
@property NSMutableArray *desserts;

-(IBAction)buttonPressed:(id)sender;

@end
