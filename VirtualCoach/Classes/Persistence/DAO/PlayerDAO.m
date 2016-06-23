//
//  PlayerDAO.m
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 15/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "PlayerDAO.h"

@implementation PlayerDAO

//INSERT
-(id)insertIntoPlayer:(NSString *) name firstName:(NSString *) fname leftHanded:(NSString *) lh level:(NSString *) level
{
    NSString *query = @"insert into Player values (null,'";
    query = [query stringByAppendingString:name];
    query = [query stringByAppendingString:@"','"];
    query = [query stringByAppendingString:fname];
    query = [query stringByAppendingString:@"','"];
    query = [query stringByAppendingString:lh];
    query = [query stringByAppendingString:@"','"];
    query = [query stringByAppendingString:level];
    query = [query stringByAppendingString:@"');"];
    
    NSLog(@"PLAYER: %@",query);
    
    NSNumber *insertion = [DatabaseService query:query mode:VCQueryNoMode];
    
    return insertion;
}

//SELECT
-(NSArray *) allPlayers
{
    NSString *query = @"select * from Player;";
    
    NSArray * result =[[NSArray alloc]init];
    result = [DatabaseService query:query mode:VCSelectIntegerIndexedResult];
    
    return result;
}

-(int)searchIdByName:(NSString *) name firstName:(NSString *) fname
{
    NSString *query = @"select idPlayer from Player where name='";
    query = [query stringByAppendingString:name];
    query = [query stringByAppendingString:@"' and firstname='"];
    query = [query stringByAppendingString:fname];
    query = [query stringByAppendingString:@"';"];
    
    NSArray * result =[[NSArray alloc]init];
    result = [DatabaseService query:query mode:VCSelectIntegerIndexedResult];
    
    int desc;
    if(result.count > 0){
        desc = (int) [result[0][0] longValue];
    }
    else{
        desc = -1;
    }
    
    return desc;
}

-(NSArray *) searchPlayerById:(NSString *)idP
{
    NSString *query = @"select * from Player where idPlayer='";
    query = [query stringByAppendingString:idP];
    query = [query stringByAppendingString:@"';"];
    
    NSArray * result =[[NSArray alloc]init];
    result = [DatabaseService query:query mode:VCSelectIntegerIndexedResult];
    
    return result;
}

//DELETE
-(id)deletePlayerById:(NSString *) idPlayer
{
    NSString *query =@"delete from Player where idPlayer ='";
    query = [query stringByAppendingString:idPlayer];
    query = [query stringByAppendingString:@"';"];
    
    NSNumber *delete = [DatabaseService query:query mode:VCQueryNoMode];
    
    return delete;
}

@end
