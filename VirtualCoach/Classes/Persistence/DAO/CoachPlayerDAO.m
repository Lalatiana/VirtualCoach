//
//  CoachPlayer.m
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 04/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "CoachPlayerDAO.h"

@implementation CoachPlayerDAO

//INSERT
-(id)insertIntoCoach_Player:(NSString *) idCoach id_player:(NSString *) idPlayer
{
    NSString *query = @"insert into CoachPlayer values (null,'";
    query = [query stringByAppendingString:idCoach];
    query = [query stringByAppendingString:@"','"];
    query = [query stringByAppendingString:idPlayer];
    query = [query stringByAppendingString:@"');"];
    
    //NSLog(@"COACH-PLAYER: %@",query);
    
    NSNumber *insertion = [DatabaseService query:query mode:VCQueryNoMode];
    
    return insertion;
}

//SELECT
-(int)searchIdByCoach:(NSString *) idCoach andPlayer:(NSString *) idPlayer
{
    NSString *query = @"select idCoachPlayer from CoachPlayer where idcoach='";
    query = [query stringByAppendingString:idCoach];
    query = [query stringByAppendingString:@"' and idplayer='"];
    query = [query stringByAppendingString:idPlayer];
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

-(NSArray*)searchIdPlayersByCoach:(NSString *) idCoach
{
    NSString *query = @"select idplayer from CoachPlayer where idcoach='";
    query = [query stringByAppendingString:idCoach];
    query = [query stringByAppendingString:@"';"];
    
    NSArray * result =[[NSArray alloc]init];
    result = [DatabaseService query:query mode:VCSelectIntegerIndexedResult];
    
    return result;
}

//DELETE
-(id)deleteCoachPlayerByIdCoach:(NSString *) idCoach
{
    NSString *query =@"delete from CoachPlayer where idcoach ='";
    query = [query stringByAppendingString:idCoach];
    query = [query stringByAppendingString:@"';"];
    
    NSNumber *delete = [DatabaseService query:query mode:VCQueryNoMode];
    
    return delete;
}

-(id)deleteCoachPlayerByIdPlayer:(NSString *) idPlayer
{
    NSString *query =@"delete from CoachPlayer where idplayer ='";
    query = [query stringByAppendingString:idPlayer];
    query = [query stringByAppendingString:@"';"];
    
    NSNumber *delete = [DatabaseService query:query mode:VCQueryNoMode];
    
    return delete;
}

-(id)deleteCoachPlayerById:(NSString *) idCP
{
    NSString *query =@"delete from CoachPlayer where idCoachPlayer ='";
    query = [query stringByAppendingString:idCP];
    query = [query stringByAppendingString:@"';"];
    
    NSNumber *delete = [DatabaseService query:query mode:VCQueryNoMode];
    
    return delete;
}

@end
