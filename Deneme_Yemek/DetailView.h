//
//  DetailView.h
//  Deneme_Yemek
//
//  Created by Egemen AYHAN on 15.02.2014.
//  Copyright (c) 2014 Egemen AYHAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tarif.h"

@interface DetailView : UIViewController
{
 IBOutlet UIScrollView *scroller;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *prepTimeLbl;
@property (weak, nonatomic) IBOutlet UITextView *ingredientsTV1;
@property (weak, nonatomic) IBOutlet UITextView *ingredientsTV2;
@property (weak, nonatomic) IBOutlet UITextView *preparationtTV;
@property (strong, nonatomic) Tarif *tarif;
@property (weak, nonatomic) IBOutlet UILabel *malzemelerLbl;
@property (weak, nonatomic) IBOutlet UILabel *hazirlanisLbl;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *likeButton;

-(IBAction)likeButtonPressed:(id)sender;

@end
