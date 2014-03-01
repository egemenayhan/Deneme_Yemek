//
//  FavoritesViewController.h
//  Deneme_Yemek
//
//  Created by Egemen AYHAN on 1.03.2014.
//  Copyright (c) 2014 Egemen AYHAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoritesViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) NSMutableArray *favorites;
@end
