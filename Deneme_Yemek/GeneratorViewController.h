//
//  GeneratorViewController.h
//  Deneme_Yemek
//
//  Created by Egemen AYHAN on 6.03.2014.
//  Copyright (c) 2014 Egemen AYHAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tarif.h"
#import "DBOperations.h"
#import "DetailView.h"
#import "SWRevealViewController.h"

@interface GeneratorViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
@property (strong,nonatomic) NSMutableArray *soups;
@property (strong,nonatomic) NSMutableArray *appetizers;
@property (strong,nonatomic) NSMutableArray *meals;
@property (strong,nonatomic) NSMutableArray *desserts;
@property (strong,nonatomic) NSArray *pickerTitles;
@property (strong,nonatomic) Tarif *soup;
@property (strong,nonatomic) Tarif *appetizer;
@property (strong,nonatomic) Tarif *meal;
@property (strong,nonatomic) Tarif *dessert;
@property (strong,nonatomic) Tarif *random;
@property (weak, nonatomic) IBOutlet UILabel *soupNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *soupPrepTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *appetizerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *appetizerPrepTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *mealNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mealPrepTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dessertNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dessertPrepTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *randomNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *randomPrepTimeLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIPickerView *typePicker;

-(IBAction)generateButtonPressed;
-(IBAction)detailButtonPressed;
-(IBAction)detailButtonPressed:(id)sender;
-(IBAction)getRandomRecipe;

@end
