//
//  TableCell.h
//  Deneme_Yemek
//
//  Created by Egemen AYHAN on 15.02.2014.
//  Copyright (c) 2014 Egemen AYHAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *prepTimeLbl;

@end
