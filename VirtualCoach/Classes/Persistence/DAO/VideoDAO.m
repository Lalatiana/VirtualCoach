//
//  VideoDAO.m
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 15/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "VideoDAO.h"

@implementation VideoDAO

//INSERT
-(id)insertIntoVideo:(NSString *) name processed:(NSString *) proc removed:(NSString *) rm day:(NSString *) d month:(NSString *) m year:(NSString *) y // rm prend la valeur 0/1 bool
{
    NSString *query = @"insert into Video values (null,'";
    query = [query stringByAppendingString:name];
    query = [query stringByAppendingString:@"','"];
    query = [query stringByAppendingString:proc];
    query = [query stringByAppendingString:@"','"];
    query = [query stringByAppendingString:rm];
    query = [query stringByAppendingString:@"','"];
    query = [query stringByAppendingString:d];
    query = [query stringByAppendingString:@"','"];
    query = [query stringByAppendingString:m];
    query = [query stringByAppendingString:@"','"];
    query = [query stringByAppendingString:y];
    query = [query stringByAppendingString:@"');"];
    
    NSNumber *insertion = [DatabaseService query:query mode:VCQueryNoMode];
    
    return insertion;
}

//SELECT
-(NSArray *) allVideo
{
    NSString *query = @"select * from Video;";
    
    NSArray * result =[[NSArray alloc]init];
    result = [DatabaseService query:query mode:VCSelectIntegerIndexedResult];
    
    return result;
}

-(int)searchIdVideoByName:(NSString*) name Processed:(NSString *) proc
{
    NSString *query = @"select idVideo from Video where name ='";
    query = [query stringByAppendingString:name];
    query = [query stringByAppendingString:@"' and processed='"];
    query = [query stringByAppendingString:proc];
    query = [query stringByAppendingString:@"';"];
    
    NSArray * result =[[NSArray alloc]init];
    result = [DatabaseService query:query mode:VCSelectIntegerIndexedResult];
    
    int desc = (int) [result[0][0] longValue];
    
    return desc;
}

-(int)searchIdVideoByName:(NSString*) name Removed:(NSString *) rm
{
    NSString *query = @"select idVideo from Video where name ='";
    query = [query stringByAppendingString:name];
    query = [query stringByAppendingString:@"' and removed='"];
    query = [query stringByAppendingString:rm];
    query = [query stringByAppendingString:@"';"];
    
    NSArray * result =[[NSArray alloc]init];
    result = [DatabaseService query:query mode:VCSelectIntegerIndexedResult];
    
    int desc = (int) [result[0][0] longValue];
    
    return desc;
}

-(NSArray *)searchVideoByDay:(NSString*) d Month:(NSString *) m andYear:(NSString *) y
{
    NSString *query = @"select * from Video where day='";
    query = [query stringByAppendingString:d];
    query = [query stringByAppendingString:@"' and month='"];
    query = [query stringByAppendingString:m];
    query = [query stringByAppendingString:@"' and year='"];
    query = [query stringByAppendingString:y];
    query = [query stringByAppendingString:@"';"];
    
    NSArray * result =[[NSArray alloc]init];
    result = [DatabaseService query:query mode:VCSelectIntegerIndexedResult];
    
    return result;
}
-(NSArray *)searchVideoByMonth:(NSString *) m andYear:(NSString *) y
{
    NSString *query = @"select * from Video where month='";
    query = [query stringByAppendingString:m];
    query = [query stringByAppendingString:@"' and year='"];
    query = [query stringByAppendingString:y];
    query = [query stringByAppendingString:@"';"];
    
    NSArray * result =[[NSArray alloc]init];
    result = [DatabaseService query:query mode:VCSelectIntegerIndexedResult];
    
    return result;
}

//UPDATE
-(id)updatedVideoProcessing:(NSString *) proc byName:(NSString*) name
{
    NSString *query=@"update Video set processed =";
     query = [query stringByAppendingString:proc];
    query = [query stringByAppendingString:@" where name='"];
    query = [query stringByAppendingString:name];
    query = [query stringByAppendingString:@"';"];

    NSNumber *update = [DatabaseService query:query mode:VCQueryNoMode];
    
    return update;
    
}
-(id)updatedVideoRemoving:(NSString *)rm byName:(NSString*) name
{
    NSString *query=@"update Video set removed =";
    query = [query stringByAppendingString:rm];
    query = [query stringByAppendingString:@" where name='"];
    query = [query stringByAppendingString:name];
    query = [query stringByAppendingString:@"';"];
    
    NSNumber *update = [DatabaseService query:query mode:VCQueryNoMode];
    
    return update;
}

//DELETE
-(id)deleteVideoById:(NSString *) idVideo
{
    NSString *query =@"delete from Video where idVideo ='";
    query = [query stringByAppendingString:idVideo];
    query = [query stringByAppendingString:@"';"];
    
    NSNumber *delete = [DatabaseService query:query mode:VCQueryNoMode];
    
    return delete;
}

@end
