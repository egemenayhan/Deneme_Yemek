//
//  DBOperations.h
//  Deneme_Yemek
//
//  Created by Egemen AYHAN on 21.02.2014.
//  Copyright (c) 2014 Egemen AYHAN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "Tarif.h"
extern sqlite3* database;
@interface DBOperations : NSObject

+(DBOperations*) sharedDb;
-(void) CloseDatabase;
-(NSMutableArray*) readRecipe;
-(NSMutableArray*) readFavorites;
-(void) updateFavorite:(NSNumber *)recipeId isFavorite:(NSNumber *)isLiked;
-(NSMutableArray*) readSoups;
-(NSMutableArray*) readAppetizers;
-(NSMutableArray*) readMeals;
-(NSMutableArray*) readDesserts;
-(BOOL) ItemExistsinTable:(NSString*)tableName andColon:(NSString*)colonName andValue:(NSString*)val;
-(BOOL) addRecipe:(Tarif *)recipe andIngredients:(NSString *)ingredients;

@end
