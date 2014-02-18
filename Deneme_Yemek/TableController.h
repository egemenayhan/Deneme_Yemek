//
//  TableController.h
//  Deneme_Yemek
//
//  Created by Egemen AYHAN on 15.02.2014.
//  Copyright (c) 2014 Egemen AYHAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property(weak, nonatomic) NSMutableArray *recipes;
@property (weak, nonatomic) IBOutlet UINavigationItem *pageTitle;

@end
