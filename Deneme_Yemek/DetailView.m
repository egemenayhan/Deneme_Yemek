//
//  DetailView.m
//  Deneme_Yemek
//
//  Created by Egemen AYHAN on 15.02.2014.
//  Copyright (c) 2014 Egemen AYHAN. All rights reserved.
//

#import "DetailView.h"

@implementation DetailView

@synthesize imageView;
@synthesize nameLbl;
@synthesize prepTimeLbl;
@synthesize ingredientsTV1;
@synthesize ingredientsTV2;
@synthesize preparationtTV;
@synthesize tarif;

-(void)viewDidLoad
{
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 1001)];
    nameLbl.text = tarif.name;
    prepTimeLbl.text = tarif.prepTime;
    imageView.image = [UIImage imageNamed:tarif.image];
    preparationtTV.text = tarif.preparation;
    ingredientsTV1.text = tarif.ingredients;
    ingredientsTV2.text = tarif.ingredients;
}

@end
