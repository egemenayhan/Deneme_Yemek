//
//  GeneratorViewController.m
//  Deneme_Yemek
//
//  Created by Egemen AYHAN on 6.03.2014.
//  Copyright (c) 2014 Egemen AYHAN. All rights reserved.
//

#import "GeneratorViewController.h"



@interface GeneratorViewController ()
{
    int type;
}

@end

@implementation GeneratorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    _soups = [[DBOperations sharedDb]readSoups];
    _appetizers = [[DBOperations sharedDb]readAppetizers];
    _meals = [[DBOperations sharedDb]readMeals];
    _desserts = [[DBOperations sharedDb]readDesserts];
    [self generateButtonPressed];
}

-(IBAction)generateButtonPressed
{
    Tarif *rnd = [self randomRecipe:1];
    _soup = rnd;
    _soupNameLabel.text = rnd.name;
    _soupPrepTimeLabel.text = rnd.prepTime;

    rnd = [self randomRecipe:2];
    _appetizer = rnd;
    _appetizerNameLabel.text = rnd.name;
    _appetizerPrepTimeLabel.text = rnd.prepTime;

    rnd = [self randomRecipe:3];
    _meal = rnd;
    _mealNameLabel.text = rnd.name;
    _mealPrepTimeLabel.text = rnd.prepTime;

    rnd = [self randomRecipe:4];
    _dessert = rnd;
    _dessertNameLabel.text = rnd.name;
    _dessertPrepTimeLabel.text = rnd.prepTime;
}

-(IBAction)getRandomRecipe
{
    if (type == 0)
    {
        type = 1;
    }
    _random = [self randomRecipe:type];
    _randomNameLabel.text = _random.name;
    _randomPrepTimeLabel.text = _random.prepTime;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    type = row + 1;
}

-(IBAction)detailButtonPressed
{
    if (_random == nil) {
        return;
    }
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailView *dt = [sb instantiateViewControllerWithIdentifier:@"Detail"];
    dt.tarif = _random;
    [self.navigationController pushViewController:dt animated:YES];
}

-(IBAction)detailButtonPressed:(id)sender
{
    if ([sender tag] == 1)
    {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        DetailView *dt = [sb instantiateViewControllerWithIdentifier:@"Detail"];
        dt.tarif = _soup;
        [self.navigationController pushViewController:dt animated:YES];
    }
    else if ([sender tag] == 2)
    {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        DetailView *dt = [sb instantiateViewControllerWithIdentifier:@"Detail"];
        dt.tarif = _appetizer;
        [self.navigationController pushViewController:dt animated:YES];
    }
    else if ([sender tag] == 3)
    {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        DetailView *dt = [sb instantiateViewControllerWithIdentifier:@"Detail"];
        dt.tarif = _meal;
        [self.navigationController pushViewController:dt animated:YES];
    }
    else if([sender tag] == 4)
    {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        DetailView *dt = [sb instantiateViewControllerWithIdentifier:@"Detail"];
        dt.tarif = _dessert;
        [self.navigationController pushViewController:dt animated:YES];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    _pickerTitles = @[@"Soup",@"Appetizer",@"Meal",@"Dessert"];
}

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return _pickerTitles.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return _pickerTitles[row];
}

-(Tarif*)randomRecipe:(int)recipeType
{
    Tarif *returnRecipe = [[Tarif alloc]init];
    if (recipeType == 1)
    {
        returnRecipe = [_soups objectAtIndex:[self getRandomNumberBetween:0 to:[_soups count]-1]];
    }
    else if (recipeType == 2)
    {
        returnRecipe = [_appetizers objectAtIndex:[self getRandomNumberBetween:0 to:[_appetizers count]-1]];
    }
    else if (recipeType == 3)
    {
        returnRecipe = [_meals objectAtIndex:[self getRandomNumberBetween:0 to:[_meals count]-1]];
    }
    else if (recipeType == 4)
    {
        returnRecipe = [_desserts objectAtIndex:[self getRandomNumberBetween:0 to:[_desserts count]-1]];
    }
    
    return returnRecipe;
}

-(int)getRandomNumberBetween:(int)from to:(int)to {
    
    return (int)from + arc4random() % (to-from+1);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
