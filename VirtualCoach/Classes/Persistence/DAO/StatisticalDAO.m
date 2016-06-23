//
//  StatisticalDAO.m
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 15/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "StatisticalDAO.h"

@interface DatabaseService ()
-(id)updateGlobalSuccessRate:(NSString *) gsr forDay:(NSString *) d Month:(NSString *) m andYear:(NSString *) y andIdPlayer:(NSString *) idPlayer;
@end

@implementation StatisticalDAO

//INSERT
-(id)insertIntoStatistical:(NSString *) cntForehand backhanh:(NSString *) cntBackhand service:(NSString *) cntService winningRun:(NSString *) win losingRun:(NSString *) lose globalSuccessRateForehand:(NSString *) forhandeRate globalSuccessRateBackhand:(NSString *) backhandRate globalSuccessRateService:(NSString *) ServiceRate day:(NSString *) d month:(NSString *) m year:(NSString *) y idPlayer:(NSString *)id
{
    NSString *query = @"insert into Statistical values (null,'";
    query = [query stringByAppendingString:cntForehand];
    query = [query stringByAppendingString:@"','"];
    query = [query stringByAppendingString:cntBackhand];
    query = [query stringByAppendingString:@"','"];
    query = [query stringByAppendingString:cntService];
    query = [query stringByAppendingString:@"','"];
    query = [query stringByAppendingString:win];
    query = [query stringByAppendingString:@"','"];
    query = [query stringByAppendingString:lose];
    query = [query stringByAppendingString:@"','"];
    query = [query stringByAppendingString:forhandeRate];
    query = [query stringByAppendingString:@"','"];
    query = [query stringByAppendingString:backhandRate];
    query = [query stringByAppendingString:@"','"];
    query = [query stringByAppendingString:ServiceRate];
    query = [query stringByAppendingString:@"','"];
    query = [query stringByAppendingString:d];
    query = [query stringByAppendingString:@"','"];
    query = [query stringByAppendingString:m];
    query = [query stringByAppendingString:@"','"];
    query = [query stringByAppendingString:y];
    query = [query stringByAppendingString:@"','"];
    query = [query stringByAppendingString:id];
    query = [query stringByAppendingString:@"');"];
    
    NSNumber *insertion = [DatabaseService query:query mode:VCQueryNoMode];
    
    return insertion;
    
}

//SELECT
-(NSArray *) allStatistical
{
    NSString *query = @"select * from Statistical;";
    
    NSArray * result =[[NSArray alloc]init];
    result = [DatabaseService query:query mode:VCSelectIntegerIndexedResult];
    
    return result;
}

-(NSArray *)searchByDay:(NSString*) day Month:(NSString *) month Andyear:(NSString *) year andIdPlayer:(NSString *) idPlayer
{
    NSString *query = @"select * from Statistical where day='";
    query = [query stringByAppendingString:day];
    query = [query stringByAppendingString:@"' and month='"];
    query = [query stringByAppendingString:month];
    query = [query stringByAppendingString:@"' and year='"];
    query = [query stringByAppendingString:year];
    query = [query stringByAppendingString:@"' and idplayer='"];
    query = [query stringByAppendingString:idPlayer];
    query = [query stringByAppendingString:@"';"];
    
    NSArray * result =[[NSArray alloc]init];
    result = [DatabaseService query:query mode:VCSelectIntegerIndexedResult];
    
    return result;
}

-(NSArray *)searchByMonth:(NSString *) month Andyear:(NSString *) year andIdPlayer:(NSString *) idPlayer
{
    NSString *query = @"select * from Statistical where month='";
    query = [query stringByAppendingString:month];
    query = [query stringByAppendingString:@"' and year='"];
    query = [query stringByAppendingString:year];
    query = [query stringByAppendingString:@"' and idplayer='"];
    query = [query stringByAppendingString:idPlayer];
    query = [query stringByAppendingString:@"';"];
    
    NSArray * result =[[NSArray alloc]init];
    result = [DatabaseService query:query mode:VCSelectIntegerIndexedResult];
    
    return result;
}

-(NSArray *)searchByYear:(NSString *) year andIdPlayer:(NSString *) idPlayer
{
    NSString *query = @"select * from Statistical where year='";
    query = [query stringByAppendingString:year];
    query = [query stringByAppendingString:@"' and idplayer='"];
    query = [query stringByAppendingString:idPlayer];
    query = [query stringByAppendingString:@"' order by month;"];
    
    NSArray * result =[[NSArray alloc]init];
    result = [DatabaseService query:query mode:VCSelectIntegerIndexedResult];
    
    return result;
}

-(NSArray *)searchByIdPlayer:(NSString *) idP
{
    NSString *query = @"select * from Statistical where idplayer='";
    query = [query stringByAppendingString:idP];
    query = [query stringByAppendingString:@"';"];
    
    NSArray * result =[[NSArray alloc]init];
    result = [DatabaseService query:query mode:VCSelectIntegerIndexedResult];
    
    return result;
}

-(NSArray *)searchFromDay:(NSString*)startDay andMonth:(NSString *)startMonth andYear:(NSString*)startYear toDay:(NSString*)endDay andMonth:(NSString*)endMonth andYear:(NSString*)endYear forPlayerId:(NSString*)playerId {
    
    NSString* query = @"select * from Statistical where idplayer='";
    query = [query stringByAppendingString:playerId];
    query = [query stringByAppendingString:@"' and "];
    
    if (startYear < endYear) {
        // Year switching
        query = [query stringByAppendingString:@"year between '"];
        query = [query stringByAppendingString:startYear];
        query = [query stringByAppendingString:@"' and '"];
        query = [query stringByAppendingString:endYear];
        query = [query stringByAppendingString:@"' "];
        
        // Month switching
        query = [query stringByAppendingString:@"and (month='"];
        query = [query stringByAppendingString:startMonth];
        query = [query stringByAppendingString:@"' or month='"];
        query = [query stringByAppendingString:endMonth];
        query = [query stringByAppendingString:@"') "];
        
        // Day switching
        query = [query stringByAppendingString:@"and (day between '"];
        query = [query stringByAppendingString:startDay];
        query = [query stringByAppendingString:@"' and '31' "];
        query = [query stringByAppendingString:@"or day between '1' and '"];
        query = [query stringByAppendingString:endDay];
        query = [query stringByAppendingString:@"')"];
        
    } else {
        query = [query stringByAppendingString:@"year='"];
        query = [query stringByAppendingString:startYear];
        query = [query stringByAppendingString:@"' and "];
        
        if (startMonth < endMonth) {
            
            // Month switching
            query = [query stringByAppendingString:@"(month='"];
            query = [query stringByAppendingString:startMonth];
            query = [query stringByAppendingString:@"' or month='"];
            query = [query stringByAppendingString:endMonth];
            query = [query stringByAppendingString:@"') "];
            
            // Day switching
            query = [query stringByAppendingString:@"and (day between '"];
            query = [query stringByAppendingString:startDay];
            query = [query stringByAppendingString:@"' and '31' "];
            query = [query stringByAppendingString:@"or day between '1' and '"];
            query = [query stringByAppendingString:endDay];
            query = [query stringByAppendingString:@"')"];
            
        } else {
            query = [query stringByAppendingString:@"month='"];
            query = [query stringByAppendingString:startMonth];
            query = [query stringByAppendingString:@"' and day between '"];
            query = [query stringByAppendingString:startDay];
            query = [query stringByAppendingString:@"' and '"];
            query = [query stringByAppendingString:endDay];
            query = [query stringByAppendingString:@"'"];
        }
    }
    
    NSLog(@"********DEBUG, query = %@", query);
    
    NSArray * result =[[NSArray alloc] init];
    result = [DatabaseService query:query mode:VCSelectIntegerIndexedResult];
    
    return result;
}

//UPDATE
-(id)updateGlobalSuccessRate:(NSString *) gsr forDay:(NSString *) d Month:(NSString *) m andYear:(NSString *) y andIdPlayer:(NSString *) idPlayer
{
    NSString *query=@"update Statistical set ";
    query = [query stringByAppendingString:gsr];
    query = [query stringByAppendingString:@" where day='"];
    query = [query stringByAppendingString:d];
    query = [query stringByAppendingString:@"' and month='"];
    query = [query stringByAppendingString:m];
    query = [query stringByAppendingString:@"' and year='"];
    query = [query stringByAppendingString:y];
    query = [query stringByAppendingString:@"' and idplayer='"];
    query = [query stringByAppendingString:idPlayer];
    query = [query stringByAppendingString:@"';"];
    
    NSNumber *update = [DatabaseService query:query mode:VCQueryNoMode];
    
    return update;
}

-(id)updateServiceGlobalSuccessRate:(NSString *) gsr forDay:(NSString *) d Month:(NSString *) m andYear:(NSString *) y andIdPlayer:(NSString *) idPlayer
{
    NSString *service = @"globalsuccessrateservice = '";
    service =  [service stringByAppendingString:gsr];
    service = [service stringByAppendingString:@"' and idplayer='"];
    service = [service stringByAppendingString:idPlayer];
    service = [service stringByAppendingString:@"'"];
    
    NSNumber *updateServiceGSR = [self updateGlobalSuccessRate:service forDay:d Month:m andYear:y andIdPlayer:idPlayer];
    
    return updateServiceGSR;
}

-(id)updateBackhandGlobalSuccessRate:(NSString *) gsr forDay:(NSString *) d Month:(NSString *) m andYear:(NSString *) y andIdPlayer:(NSString *) idPlayer
{
    NSString *backhand = @"globalsuccessratebackhand = '";
    backhand =  [backhand stringByAppendingString:gsr];
    backhand = [backhand stringByAppendingString:@"' and idplayer='"];
    backhand = [backhand stringByAppendingString:idPlayer];
    backhand = [backhand stringByAppendingString:@"'"];
    
    NSNumber *updateBackhandGSR = [self updateGlobalSuccessRate:backhand forDay:d Month:m andYear:y andIdPlayer:idPlayer];
    
    return updateBackhandGSR;
}

-(id)updateForeHandGlobalSuccessRate:(NSString *) gsr forDay:(NSString *) d Month:(NSString *) m andYear:(NSString *) y andIdPlayer:(NSString *) idPlayer
{
    NSString *forehand = @"globalsuccessrateforehand = '";
    forehand =  [forehand stringByAppendingString:gsr];
    forehand = [forehand stringByAppendingString:@"' and idplayer='"];
    forehand = [forehand stringByAppendingString:idPlayer];
    forehand = [forehand stringByAppendingString:@"'"];
    
    NSNumber *updateForehandGSR = [self updateGlobalSuccessRate:forehand forDay:d Month:m andYear:y andIdPlayer:idPlayer];
    
    return updateForehandGSR;
}


//DELETE
-(id)deleteStatisticalById:(NSString *) idStat
{
    NSString *query =@"delete from Statistical where idStatistical ='";
    query = [query stringByAppendingString:idStat];
    query = [query stringByAppendingString:@"';"];
    
    NSNumber *delete = [DatabaseService query:query mode:VCQueryNoMode];
    
    return delete;
}

@end
