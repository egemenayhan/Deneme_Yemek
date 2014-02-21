//
//  Tarif.h
//  Deneme_Yemek
//
//  Created by Egemen AYHAN on 15.02.2014.
//  Copyright (c) 2014 Egemen AYHAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tarif : NSObject

@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *prepTime;
@property (strong,nonatomic) NSString *image;
@property (strong,nonatomic) NSString *preparation;
@property (strong,nonatomic) NSArray *ingredients;
@property (strong,nonatomic) NSNumber *type;

@end
