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
@synthesize malzemelerLbl;
@synthesize hazirlanisLbl;
@synthesize tarif;

-(void)viewDidLoad
{
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 1001)];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.view.backgroundColor = [UIColor orangeColor];
    
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 1000)];
    
    nameLbl.text = tarif.name;
    prepTimeLbl.text = tarif.prepTime;
    imageView.image = [UIImage imageNamed:tarif.image];
    preparationtTV.text = tarif.preparation;
    //NSString *asd = [NSString str]
    for (int i = 0; i < [tarif.ingredients count]; i++)
    {
        if (i % 2 == 0)
        {
            if (i == 0) {
                ingredientsTV1.text = [ingredientsTV1.text stringByAppendingString:[tarif.ingredients objectAtIndex:i]];
            }
            else
                ingredientsTV1.text = [ingredientsTV1.text stringByAppendingString:[NSString stringWithFormat:@"\n%@",[tarif.ingredients objectAtIndex:i]]];
        }
        else
        {
            if (i == 1) {
                ingredientsTV2.text = [ingredientsTV2.text stringByAppendingString:[tarif.ingredients objectAtIndex:i]];
            }
            else
                ingredientsTV2.text = [ingredientsTV2.text stringByAppendingString:[NSString stringWithFormat:@"\n%@",[tarif.ingredients objectAtIndex:i]]];
        }
    }
    
    [ingredientsTV1 setFrame:CGRectMake(ingredientsTV1.frame.origin.x, ingredientsTV1.frame.origin.y, ingredientsTV1.frame.size.width, [self getContentSize:ingredientsTV1].height)];
    [ingredientsTV2 setFrame:CGRectMake(ingredientsTV2.frame.origin.x, ingredientsTV2.frame.origin.y, ingredientsTV2.frame.size.width, [self getContentSize:ingredientsTV2].height)];
    [hazirlanisLbl setFrame:CGRectMake(hazirlanisLbl.frame.origin.x, ingredientsTV1.frame.origin.y + ingredientsTV1.frame.size.height +
                                        5, hazirlanisLbl.frame.size.width, hazirlanisLbl.frame.size.height)];
    [preparationtTV setFrame:CGRectMake(preparationtTV.frame.origin.x, hazirlanisLbl.frame.origin.y + hazirlanisLbl.frame.size.height +
                                        5, preparationtTV.frame.size.width, [self getContentSize:preparationtTV].height)];
    [scroller setContentSize:CGSizeMake(scroller.contentSize.width, self.preparationtTV.frame.size.height+self.preparationtTV.frame.origin.y+5)];
    
    [super viewWillAppear:animated];
    
}
-(CGSize) getContentSize:(UITextView*) myTextView{
    return [myTextView sizeThatFits:CGSizeMake(myTextView.frame.size.width, FLT_MAX)];
}


@end
