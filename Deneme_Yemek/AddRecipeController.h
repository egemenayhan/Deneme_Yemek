//
//  AddRecipeController.h
//  Deneme_Yemek
//
//  Created by Egemen on 07/03/14.
//  Copyright (c) 2014 Egemen AYHAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "Tarif.h"
#import "DBOperations.h"

@interface AddRecipeController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UITextViewDelegate>
@property (strong, nonatomic) NSArray *RecipeTypes;
@property (strong, nonatomic) IBOutlet UIPickerView *types;
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *time;
@property (strong, nonatomic) IBOutlet UITextField *ingredients;
@property (strong, nonatomic) IBOutlet UITextView *preparation;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

-(IBAction)AddRecipePressed;

@end
