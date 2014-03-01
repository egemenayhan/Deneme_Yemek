//
//  DBOperations.m
//  Deneme_Yemek
//
//  Created by Egemen AYHAN on 21.02.2014.
//  Copyright (c) 2014 Egemen AYHAN. All rights reserved.
//

#import "DBOperations.h"

static DBOperations *db;
@implementation DBOperations

NSString* dbName = @"Recipe_List.sqlite"; //veritabanının tam adı
BOOL dataBaseIsOpen = false;
sqlite3* database;

+ (DBOperations*)sharedDb {
    @synchronized(self) {
        if(db == nil)
            db = [[DBOperations alloc]init];;
        
    }
    return db;
}

- (void)dealloc
{
    [self CloseDatabase];
}
- (id)init
{
    self = [super init];
    if (self) {
        BOOL val= [db CopyDbToDocumentsFolderOnceTime];
        if(!val)
            [db OpenDatabase];
    }
    return self;
}

-(BOOL)CopyDbToDocumentsFolderOnceTime{
    
    
    NSFileManager* fileManager1 = [NSFileManager defaultManager];
    NSString *DBPath1 = [db.GetDocumentDirectory stringByAppendingPathComponent:dbName];
    
    //verilen database adresinde belirtilen database'in olup olmadığını kontrol eder
    if([fileManager1 fileExistsAtPath:DBPath1]){
        return true;
    }
    
    
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSString *DBpath =  [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:dbName];
    NSString *copyDBPath = [db.GetDocumentDirectory stringByAppendingPathComponent:dbName];
    
    if(![fileManager fileExistsAtPath:copyDBPath]){
        NSError *err;
        [fileManager copyItemAtPath:DBpath toPath:copyDBPath error:&err];
        if(err){
            //NSLog(@"Fonskiyon:CopyDbToDocumentsFolderOnceTime Hata:veritabanı kopyalanamadı.");
            return false;
        }
    }
    return true;
}

//documents klasörünün yolunu döndürür
-(NSString*) GetDocumentDirectory {
    NSString* pszHomeDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    return pszHomeDir;
}

//veritabanını açar
-(void)OpenDatabase{
    @try{
        NSFileManager* fileManager = [NSFileManager defaultManager];
        NSString *DBPath = [db.GetDocumentDirectory stringByAppendingPathComponent:dbName];
        
        //verilen database adresinde belirtilen database'in olup olmadığını kontrol eder
        if(![db CopyDbToDocumentsFolderOnceTime]){
            
            
            NSException *exception = [NSException exceptionWithName: @"OpenDatabase" reason: @"Belirtilen yerde veritabanı yok" userInfo: nil];
            @throw exception;
        }
        //veritabanının sorunsuz açılıp açılmadığını kontrol eder
        if (sqlite3_open([DBPath UTF8String], &database) != SQLITE_OK){
            NSException *exception = [NSException exceptionWithName: @"OpenDatabase" reason: @"Veritabanı açılamadı." userInfo: nil];
            @throw exception;
        }
        dataBaseIsOpen = true;
    }
    @catch(NSException *exception){
        dataBaseIsOpen = false;
        database = nil;
        //NSLog(@"Fonskiyon:%@  Hata:%@", [exception name], [exception reason]);
    }
    @finally{
    }
}

//veritabanını kapatır
-(void)CloseDatabase{
    return;
    @try {
        if(database == nil && dataBaseIsOpen == false){
            NSException *exception = [NSException exceptionWithName: @"CloseDatabase" reason: @"veritabanı açık değil" userInfo: nil];
            @throw exception;
        }
        if(!sqlite3_close(database) == SQLITE_OK)
        {
            NSException *exception = [NSException exceptionWithName: @"CloseDatabase" reason: @"veritabanı kapatılamıyor" userInfo: nil];
            @throw exception;
        }
        database = nil;
    }
    @catch (NSException *exception) {
        dataBaseIsOpen = false;
        //NSLog(@"Fonskiyon:%@  Hata:%@", [exception name], [exception reason]);
    }
    @finally {
    }
}

-(NSMutableArray*)readRecipe
{
    NSMutableArray *returnArray=[[NSMutableArray alloc]init];
    sqlite3_stmt* sqlStmt;
    [db OpenDatabase];
    @try {
        if(database == nil && dataBaseIsOpen == false){
            NSException *exception = [NSException exceptionWithName: @"ReadRecipe" reason: @"Veritabanı açık değil." userInfo: nil];
            @throw exception;
        }
        
        NSString *sqlComment = [NSString stringWithFormat:@"SELECT * FROM TblRecipe"];
        
        
        //database gönderilen komutun çalışıp çalışmadığını kontrol eder
        int k=sqlite3_prepare_v2(database, [sqlComment cStringUsingEncoding:(NSUTF8StringEncoding)], -1, &sqlStmt, NULL) ;
        if(k!= SQLITE_OK) {
            NSException *exception = [NSException exceptionWithName: @"ReadRecipe" reason: [NSString stringWithFormat:@"sqlite3_prepare_v2'de hata :%d",k] userInfo: nil];
            @throw exception;
        }
        //int kp=sqlite3_step(sqlStmt) ;
        //satır satır database'den bilgileri okur
        while (sqlite3_step(sqlStmt) == SQLITE_ROW) {
            @try {
                Tarif *obj = [[Tarif alloc]init];
                //int değerler çekmek için
                int data = sqlite3_column_int(sqlStmt, 0);
                obj.id = [NSNumber numberWithInt:data];
                //string değerler çekmek için
                obj.name=[NSString stringWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 1)];
                obj.prepTime=[NSString stringWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 2)];
                NSString *txtIngredients = [NSString stringWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 3)];
                obj.ingredients = [txtIngredients componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
                obj.preparation=[NSString stringWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 4)];
                obj.image=[NSString stringWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 5)];
                data = sqlite3_column_int(sqlStmt, 6);
                obj.type = [NSNumber numberWithInt:data];
                data = sqlite3_column_int(sqlStmt, 7);
                obj.isFavorite = [NSNumber numberWithInt:data];
                //şey db'yi değiştirdikten sonra uygulamayı silin ve ardından product->clean yapın
                //yoksa eski database i kullanmaya devam eder
                
                
                [returnArray addObject:obj];
                // data= [(NSNumber*)[returnArray objectAtIndex:0] intValue];
                
            }
            @catch (NSException *exception) {
                //NSLog(@"%@",exception.description);
            }
        }
    }   @catch (NSException *exception) {
        //NSLog(@"Fonskiyon:%@  Hata:%@", [exception name], [exception reason]);
    }
    
    @finally {
        @try {
            sqlite3_finalize(sqlStmt);
        }
        @catch (NSException *exception) {
            
        }
        // [self CloseDatabase];
        return  returnArray;
    }
}

-(NSMutableArray*)readFavorites
{
    NSMutableArray *returnArray=[[NSMutableArray alloc]init];
    sqlite3_stmt* sqlStmt;
    [db OpenDatabase];
    @try {
        if(database == nil && dataBaseIsOpen == false){
            NSException *exception = [NSException exceptionWithName: @"ReadFavorites" reason: @"Veritabanı açık değil." userInfo: nil];
            @throw exception;
        }
        
        NSString* sqlComment = [NSString stringWithFormat:@"SELECT * FROM TblRecipe WHERE isFavorite = 1"];
        
        
        //database gönderilen komutun çalışıp çalışmadığını kontrol eder
        int k=sqlite3_prepare_v2(database, [sqlComment cStringUsingEncoding:(NSUTF8StringEncoding)], -1, &sqlStmt, NULL) ;
        if(k!= SQLITE_OK) {
            NSException *exception = [NSException exceptionWithName: @"ReadRecipe" reason: [NSString stringWithFormat:@"sqlite3_prepare_v2'de hata :%d",k] userInfo: nil];
            @throw exception;
        }
        //int kp=sqlite3_step(sqlStmt) ;
        //satır satır database'den bilgileri okur
        while (sqlite3_step(sqlStmt) == SQLITE_ROW) {
            @try {
                Tarif *obj = [[Tarif alloc]init];
                //int değerler çekmek için
                int data = sqlite3_column_int(sqlStmt, 0);
                obj.id = [NSNumber numberWithInt:data];
                //string değerler çekmek için
                obj.name=[NSString stringWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 1)];
                obj.prepTime=[NSString stringWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 2)];
                NSString *txtIngredients = [NSString stringWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 3)];
                obj.ingredients = [txtIngredients componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
                obj.preparation=[NSString stringWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 4)];
                obj.image=[NSString stringWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 5)];
                data = sqlite3_column_int(sqlStmt, 6);
                obj.type = [NSNumber numberWithInt:data];
                data = sqlite3_column_int(sqlStmt, 7);
                obj.isFavorite = [NSNumber numberWithInt:data];

                //db'yi değiştirdikten sonra uygulamayı silin ve ardından product->clean yapın
                //yoksa eski database i kullanmaya devam eder
                
                
                [returnArray addObject:obj];
                // data= [(NSNumber*)[returnArray objectAtIndex:0] intValue];
                
            }
            @catch (NSException *exception) {
                //NSLog(@"%@",exception.description);
            }
        }
    }   @catch (NSException *exception) {
        //NSLog(@"Fonskiyon:%@  Hata:%@", [exception name], [exception reason]);
    }
    
    @finally {
        @try {
            sqlite3_finalize(sqlStmt);
        }
        @catch (NSException *exception) {
            
        }
        // [self CloseDatabase];
        return  returnArray;
    }
}

-(void)updateFavorite:(NSNumber *)recipeId isFavorite:(NSNumber *)isLiked
{
    sqlite3_stmt* sqlStmt;
    [db OpenDatabase];
    @try {
        if(database == nil && dataBaseIsOpen == false){
            NSException *exception = [NSException exceptionWithName: @"ReadFavorites" reason: @"Veritabanı açık değil." userInfo: nil];
            @throw exception;
        }
        
         NSString *sqlComment = [NSString stringWithFormat:@"UPDATE TblRecipe SET isFavorite = %i WHERE id = %i",[isLiked intValue],[recipeId intValue]];
         
         //database gönderilen komutun çalışıp çalışmadığını kontrol eder
         int k=sqlite3_prepare_v2(database, [sqlComment cStringUsingEncoding:(NSUTF8StringEncoding)], -1, &sqlStmt, NULL) ;
         if(k!= SQLITE_OK) {
         NSException *exception = [NSException exceptionWithName: @"ReadRecipe" reason: [NSString stringWithFormat:@"sqlite3_prepare_v2'de hata :%d",k] userInfo: nil];
         @throw exception;
         
         }
      
        
        /*
        const char* pszSQL = "UPDATE TblRecipe SET isFavorite = ? WHERE id = ?";
        
        if (database == nil && dataBaseIsOpen == false) {
            NSException *exception = [NSException exceptionWithName: @"UpdateSong" reason: @"veritabanı açık değil" userInfo: nil];
            @throw exception;
        }
        
        int p=sqlite3_prepare_v2(database, pszSQL, -1, &sqlStmt, NULL) ;
        if (p!= SQLITE_OK){
            NSException *exception = [NSException exceptionWithName: @"UpdateSong" reason: @"sqlite3_prepare_v2'da hata oluştu" userInfo: nil];
            @throw exception;
        }
      
        sqlite3_bind_int(sqlStmt, 1, [isLiked intValue]);
        sqlite3_bind_int(sqlStmt, 2, [recipeId intValue]);
            */
        if (sqlite3_step(sqlStmt) != SQLITE_DONE) {
            NSException *exception = [NSException exceptionWithName: @"UpdateSong" reason: @"sqlite3_step'da hata oluştu" userInfo: nil];
            @throw exception;
        }
        if (sqlite3_finalize(sqlStmt) != SQLITE_OK){
            NSException *exception = [NSException exceptionWithName: @"UpdateSong" reason: @"sqlite3_finalize'da hata oluştu" userInfo: nil];
            @throw exception;
        }
        //int kp=sqlite3_step(sqlStmt) ;
        //satır satır database'den bilgileri okur
        
    }
    @catch (NSException *exception) {
        NSLog(@"Fonskiyon:%@  Hata:%@", [exception name], [exception reason]);
    }
    
    @finally {
        @try {
            sqlite3_finalize(sqlStmt);
        }
        @catch (NSException *exception) {
            
        }
        // [self CloseDatabase];
        //return  returnArray;
    }
}


@end
