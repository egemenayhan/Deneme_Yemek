//
//  ViewController.m
//  Deneme_Yemek
//
//  Created by Egemen AYHAN on 15.02.2014.
//  Copyright (c) 2014 Egemen AYHAN. All rights reserved.
//

#import "ViewController.h"
#import "TableController.h"
#import "Tarif.h"
#import "DBOperations.h"
#import "SWRevealViewController.h"
@interface ViewController ()

@end

@implementation ViewController

@synthesize soups;
@synthesize appetizers;
@synthesize meals;
@synthesize desserts;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    
    
    NSMutableArray *recipes=[[DBOperations sharedDb] readRecipe];
    soups = [[NSMutableArray alloc]init];
    appetizers = [[NSMutableArray alloc]init];
    meals = [[NSMutableArray alloc]init];
    desserts = [[NSMutableArray alloc]init];
    for (int i = 0; i < [recipes count]; i++)
    {
        Tarif *obj = [recipes objectAtIndex:i];
        if ( [obj.type intValue] == 1)
        {
            [soups addObject:obj];
        }
        else if ([obj.type intValue] == 2)
        {
            [appetizers addObject:obj];
        }
        else if ([obj.type intValue] == 3)
        {
            [meals addObject:obj];
        }
        else if ([obj.type intValue] == 4)
        {
            [desserts addObject:obj];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)buttonPressed:(id)sender
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TableController *tb = [sb instantiateViewControllerWithIdentifier:@"Table"];
    if ([sender tag] == 1)
    {
        tb.pageTitle.title = @"Çorbalar";
        tb.recipes = soups;
    }
    else if([sender tag]== 2)
    {
        tb.pageTitle.title = @"Mezeler";
        tb.recipes = appetizers;
    }
    else if([sender tag]== 3)
    {
        tb.pageTitle.title = @"Ana Yemekler";
        tb.recipes = meals;
    }
    else if([sender tag] == 4)
    {
        tb.pageTitle.title = @"Tatlılar";
        tb.recipes = desserts;
    }
    [self.navigationController pushViewController:tb animated:YES];
}



@end
