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
    
    Tarif *obj= [Tarif new];
    Tarif *obj2= [Tarif new];
    Tarif *obj3= [Tarif new];
    Tarif *obj4= [Tarif new];
	
    obj.name = @"Çorba Çorbası";
    obj.prepTime = @"30 Dakika";
    obj.preparation = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";
    obj.ingredients = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque cæiviuda.";
    obj.image = @"corba.jpg";
    
    obj2.name = @"Haydari";
    obj2.prepTime = @"5 Dakika";
    obj2.preparation = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";
    obj2.ingredients = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque cæiviuda.";
    obj2.image = @"corba.jpg";
    
    obj3.name = @"Kızarmış Alabalık";
    obj3.prepTime = @"1 Saat";
    obj3.preparation = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";
    obj3.ingredients = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque cæiviuda.";
    obj3.image = @"corba.jpg";
    
    obj4.name = @"Puding";
    obj4.prepTime = @"10 Dakika";
    obj4.preparation = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";
    obj4.ingredients = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque cæiviuda.";
    obj4.image = @"corba.jpg";
    
    soups = [NSMutableArray arrayWithObjects:obj,obj,obj,obj, nil];
    appetizers = [NSMutableArray arrayWithObjects:obj2,obj2,obj2,obj2, nil];
    meals = [NSMutableArray arrayWithObjects:obj3,obj3,obj3,obj3, nil];
    desserts = [NSMutableArray arrayWithObjects:obj4,obj4,obj4,obj4, nil];
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
