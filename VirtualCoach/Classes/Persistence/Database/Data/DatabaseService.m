//
//  DatabaseService.m
//  SQLite3Test
//
//  Created by Romain Dubreucq on 18/03/2015.
//  Copyright (c) 2015 Romain Dubreucq. All rights reserved.
//

#import "DatabaseService.h"
#include <sqlite3.h>

@interface DatabaseService ()

+ (id)select:(NSString *)query mode:(VCQueryMode)mode;
+ (id)update:(NSString *)query;
+ (id)insert:(NSString *)query;
+ (id)delete:(NSString *)query;

+ (NSArray *)selectWithIndexedByIntegerResult:(NSString *)query;
+ (NSDictionary *)selectWithIndexedByColumnNameResult:(NSString *)query;
+ (id)dataOfType:(int)datatype statement:(sqlite3_stmt *)statement index:(int)index;

@end

@implementation DatabaseService

static sqlite3 *database;
static BOOL initialized;

+ (void)initWithFile:(NSString *)filePath
{
    initialized = NO;
    
    if ((sqlite3_open([filePath UTF8String], &database) != SQLITE_OK))
    {
        NSLog(@"Can't open the database file at %@", filePath);
    }
    
    else
    {
        initialized = YES;
        sqlite3_exec(database, "PRAGMA FOREIGN_KEYS = 0", NULL, NULL, NULL);
    }
}

+ (sqlite3 *)instance
{
    return database;
}

+ (BOOL)initialized
{
    return initialized;
}

// Method used by the developer, the query is generic, the method calls the appropriated method to do the request then

+ (id)query:(NSString *)query mode:(VCQueryMode)mode
{
    //NSLog(@"lala\n");
    if ([query containsString:@"SELECT"] || [query containsString:@"select"])
        return [DatabaseService select:query mode:mode];
    if ([query containsString:@"UPDATE"] || [query containsString:@"update"])
        return [DatabaseService update:query ];
    if ([query containsString:@"INSERT INTO"] || [query containsString:@"insert into"])
        return [DatabaseService insert:query];
    if ([query containsString:@"DELETE"] || [query containsString:@"delete"])
        return [DatabaseService delete:query];
    return nil;
}

// Encapsulates the data in an object (to be stored in collection) following the datatype

+ (id)dataOfType:(int)datatype statement:(sqlite3_stmt *)statement index:(int)index
{
    int int_value;
    float float_value;
    const char *const_char_value;
    
    switch (datatype)
    {
        case SQLITE_INTEGER:
            int_value = (int)sqlite3_column_int64(statement, index);
            return [NSNumber numberWithInt:int_value];
        break;
            
        case SQLITE_FLOAT:
            float_value = (float)sqlite3_column_double(statement, index);
            return [NSNumber numberWithFloat:float_value];
        break;
            
        case SQLITE_BLOB:
            
        break;
            
        case SQLITE_NULL:
            return [NSNull null];
        break;
            
        case SQLITE_TEXT:
            const_char_value = (char *)sqlite3_column_text(statement, index);
            return [[NSString alloc] initWithUTF8String:const_char_value];
        break;
            
        default:
        break;
    }
    
    return nil;
}

// SELECT query

+ (id)select:(NSString *)query mode:(VCQueryMode)mode;
{
    switch (mode)
    {
        case VCQueryNoMode:
            return [DatabaseService selectWithIndexedByColumnNameResult:query];
        break;
            
        case VCSelectIntegerIndexedResult:
            return [DatabaseService selectWithIndexedByIntegerResult:query];
        break;
            
        case VCSelectColumnIndexedResult:
            return [DatabaseService selectWithIndexedByColumnNameResult:query];
        break;
            
        default:
        break;
    }
    
    return nil;
}

// TODO (JD & Lala)

+ (NSArray *)selectWithIndexedByIntegerResult:(NSString *)query
{
    sqlite3_stmt *statement;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    int result = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
    if (result == SQLITE_OK) {
        int columnCount = sqlite3_column_count(statement);
        for (NSUInteger i = 0; i < columnCount; i++)
        {
            NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
            [array insertObject:mutableArray atIndex:i];
        }
        while(sqlite3_step(statement) == SQLITE_ROW){
            for (NSUInteger i = 0; i < columnCount; i++){
                int datatype = (int)sqlite3_column_type(statement, (int)i);
                id value = [DatabaseService dataOfType:datatype statement:statement index:(int)i];
                [array[i] addObject:value];
            }
        }
    }
    else{
        NSLog(@"Failed:%s",sqlite3_errmsg(database));
    }
    return [array copy];
}


+ (NSDictionary *)selectWithIndexedByColumnNameResult:(NSString *)query
{
    NSLog(@"Query: %@",query);
    sqlite3_stmt *statement;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    int result = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
    
    if (result == SQLITE_OK)
    {
        int columnCount = sqlite3_column_count(statement);
        
        for (NSUInteger i = 0; i < columnCount; i++)
        {
            const char *columnName = sqlite3_column_name(statement, (int)i);
            
            NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
            NSString *columnNameString = [[NSString alloc] initWithUTF8String:columnName];
            [dict setValue:mutableArray forKey:columnNameString];
        }
        
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            for (NSUInteger i = 0; i < columnCount; i++)
            {
                int datatype = (int)sqlite3_column_type(statement, (int)i);
                const char *columnName = sqlite3_column_name(statement, (int)i);
                NSString *columnNameString = [[NSString alloc] initWithUTF8String:columnName];
                id value = [DatabaseService dataOfType:datatype statement:statement index:(int)i];
                [[dict objectForKey:columnNameString] addObject:value];
            }
        }
        
        sqlite3_finalize(statement);
    }
    
    
    return [dict copy];
}

// UPDATE query

+ (id)update:(NSString *)query
{
    NSLog(@"Query: %@",query);
    int result=0;
    sqlite3_stmt *updateStmt;
     char* errMsg;
    
    result = sqlite3_prepare_v2(database, [query UTF8String], -1, &updateStmt, NULL);
    
    if (SQLITE_OK != result) {
        NSLog(@"Error while creating update statement. %s", sqlite3_errmsg(database));
        return [NSNumber numberWithBool:NO];
    }
    sqlite3_bind_int(updateStmt, 1, 1000);
    
    sqlite3_bind_int(updateStmt, 2 , 1);
    
    sqlite3_exec(database, [query UTF8String], NULL, NULL, &errMsg);
    
    if(SQLITE_DONE != sqlite3_step(updateStmt)){
         NSLog(@"Error while updating. %s", sqlite3_errmsg(database));
        return [NSNumber numberWithBool:NO];
    }
    
    sqlite3_finalize(updateStmt);
    
     return [NSNumber numberWithBool:YES];
}

// INSERT query

+ (id)insert:(NSString *)query
{
    
    NSLog(@"Query: %@",query);
    int result=0;
    char *errMsg;
 
    result = sqlite3_exec(database, [query UTF8String] ,NULL,NULL,&errMsg);
    
    if(result != SQLITE_OK)
    {
        NSLog(@"Failed to insert record  result:%d message:%s",result,errMsg);
        
        return [NSNumber numberWithBool:NO];
    }
    
    return [NSNumber numberWithBool:YES];
}

//DELETE query
+ (id)delete:(NSString *)query
{
    NSLog(@"Query: %@",query);
    int result = 0;
    char *errMsg;
    
    result = sqlite3_exec(database, [query UTF8String], NULL, NULL, &errMsg );
    
    if( result != SQLITE_OK )
    {
        NSLog(@"Failed delete  result:%d, message=%s",result,errMsg);
        return [NSNumber numberWithBool:NO];
    }
    
    return [NSNumber numberWithBool:YES];
}

//execueSQLfile
+(int)sqlFile:(NSString *)filePath
{
    int x;
    NSError* error;
    char* execError;
    
    NSString* content = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    if(error)
    {
        NSLog(@"ERROR: %@", error);
        return x = 1;
    }
    
    x = sqlite3_exec(database, [content UTF8String], nil, nil, &execError);
    
    if(execError)
    {
        NSLog(@"ERROR:%s", execError);
    }
    if(x!=SQLITE_OK)
    {
        NSLog(@"Can't read content of file: %@", content);
    }
    return x;
    
}

+ (void)close
{
    sqlite3_close(database);
}

@end
