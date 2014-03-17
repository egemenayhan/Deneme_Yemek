//
//  AddRecipeController.m
//  Deneme_Yemek
//
//  Created by Egemen on 07/03/14.
//  Copyright (c) 2014 Egemen AYHAN. All rights reserved.
//

#import "AddRecipeController.h"

@interface AddRecipeController ()

@end

@implementation AddRecipeController
{
    int Type;
    Tarif *addRecipe;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    self.RecipeTypes = 	@[@"Soup",@"Appetizer",@"Meal",@"Dessert"];

}

- (void)textViewDidBeginEditing:(UITextField *)textField
{
    [self animateTextView: textField up: YES];
}


- (void)textViewDidEndEditing:(UITextField *)textField
{
    [self animateTextView: textField up: NO];
}

- (void) animateTextView: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 210; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}


-(void)viewWillAppear:(BOOL)animated
{
    if (Type == 0)
    {
        Type = 1;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dismissKeyboard
{
    [_name resignFirstResponder];
    [_time resignFirstResponder];
    [_ingredients resignFirstResponder];
    [_preparation resignFirstResponder];
}

-(NSInteger ) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_RecipeTypes count];
}
-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_RecipeTypes objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    Type = row + 1;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

-(IBAction)AddRecipePressed
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please fill all fields!"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    if ([_name.text isEqualToString: @""] || [_time.text isEqualToString: @""] || [_preparation.text isEqualToString: @""] || [_ingredients.text isEqualToString: @""]) {
        
        [alert show];
    }
    else
    {
        BOOL isExist = [[DBOperations sharedDb] ItemExistsinTable:@"TblRecipe" andColon:@"name" andValue:_name.text];
        if (isExist)
        {
            alert = [[UIAlertView alloc] initWithTitle:@"Warning!" message:@"This recipe is already exist!"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
            addRecipe = [[Tarif alloc] init];
            addRecipe.name = _name.text;
            addRecipe.prepTime = _time.text;
            addRecipe.ingredients = [_ingredients.text componentsSeparatedByString:@","];
            addRecipe.preparation = _preparation.text;
            addRecipe.type = [NSNumber numberWithInt:(Type)];
            addRecipe.image = @"default.png";
            if ([[DBOperations sharedDb] addRecipe:addRecipe andIngredients:_ingredients.text])
            {
                alert = [[UIAlertView alloc] initWithTitle:@"Great!" message:@"Recipe created successfully!"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                _name.text = @"";
                _time.text = @"";
                _ingredients.text = @"";
                _preparation.text = @"Please write preparation process here...";
                
                [alert show];
            }
            else
            {
                alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"We couldn't create your recipe :("  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                _name.text = @"";
                _time.text = @"";
                _ingredients.text = @"";
                _preparation.text = @"Please write preparation process here...";
                [alert show];
            }
        }
    }

}


@end
