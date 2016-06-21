//
//  VideoReferenceDAO.m
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 24/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "VideoReferenceDAO.h"

@implementation VideoReferenceDAO

//INSERT
-(id)insertIntoVideoReference:(NSString *) name processed:(NSString *) proc removed:(NSString *) rm day:(NSString *) d month:(NSString *) m year:(NSString *) y idCoach:(NSString *) idc
{
    NSString *query = @"insert into VideoReference values (null,'";
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
    query = [query stringByAppendingString:@"','"];
    query = [query stringByAppendingString:idc];
    query = [query stringByAppendingString:@"');"];
    
    NSLog(@"VIdeoREF: %@",query);
    
    NSNumber *insertion = [DatabaseService query:query mode:VCQueryNoMode];
    
    return insertion;
}

//SELECT
-(NSArray *) allVideoRef
{
    NSString *query = @"select * from VideoReference;";
    
    NSArray * result =[[NSArray alloc]init];
    result = [DatabaseService query:query mode:VCSelectIntegerIndexedResult];
    
    return result;
}

-(int)searchIdVideoRefByName:(NSString*) name Processed:(NSString *) proc
{
    NSString *query = @"select idVideoRef from VideoReference where name ='";
    query = [query stringByAppendingString:name];
    query = [query stringByAppendingString:@"' and processed='"];
    query = [query stringByAppendingString:proc];
    query = [query stringByAppendingString:@"';"];
    
    NSArray * result =[[NSArray alloc]init];
    result = [DatabaseService query:query mode:VCSelectIntegerIndexedResult];
    
    int desc = (int) [result[0][0] longValue];
    
    return desc;
}

-(int)searchIdVideoRefByName:(NSString*) name Removed:(NSString *) rm
{
    NSString *query = @"select idVideoRef from VideoReference where name ='";
    query = [query stringByAppendingString:name];
    query = [query stringByAppendingString:@"' and removed='"];
    query = [query stringByAppendingString:rm];
    query = [query stringByAppendingString:@"';"];
    
    NSLog(@"SELECT VIDEOREF: %@",query);
    
    NSArray * result =[[NSArray alloc]init];
    result = [DatabaseService query:query mode:VCSelectIntegerIndexedResult];
    
    int desc = (int) [result[0][0] longValue];
    
    return desc;
}

-(NSArray *)searchVideoRefByDay:(NSString*) d Month:(NSString *) m andYear:(NSString *) y
{
    NSString *query = @"select * from VideoReference where day='";
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
-(NSArray *)searchVideoRefByMonth:(NSString *) m andYear:(NSString *) y
{
    NSString *query = @"select * from VideoReference where month='";
    query = [query stringByAppendingString:m];
    query = [query stringByAppendingString:@"' and year='"];
    query = [query stringByAppendingString:y];
    query = [query stringByAppendingString:@"';"];
    
    NSArray * result =[[NSArray alloc]init];
    result = [DatabaseService query:query mode:VCSelectIntegerIndexedResult];
    
    return result;
}

-(NSArray *)searchVideoRefByIdCoach:(NSString *) idC
{
    NSString *query = @"select * from VideoReference where idcoach='";
    query = [query stringByAppendingString:idC];
    query = [query stringByAppendingString:@"';"];
    
    NSArray * result =[[NSArray alloc]init];
    result = [DatabaseService query:query mode:VCSelectIntegerIndexedResult];
    
    return result;
}

//UPDATE
-(id)udpatedVideoProcessed:(NSString *) proc byName:(NSString*) name
{
    NSString *query=@"update VideoReference set processed =";
    query = [query stringByAppendingString:proc];
    query = [query stringByAppendingString:@" where name='"];
    query = [query stringByAppendingString:name];
    query = [query stringByAppendingString:@"';"];
    
    NSNumber *update = [DatabaseService query:query mode:VCQueryNoMode];
    
    return update;
    
}
-(id)udpatedVideoRemoved:(NSString *)rm byName:(NSString*) name
{
    NSString *query=@"update VideoReference set removed =";
    query = [query stringByAppendingString:rm];
    query = [query stringByAppendingString:@" where name='"];
    query = [query stringByAppendingString:name];
    query = [query stringByAppendingString:@"';"];
    
    NSNumber *update = [DatabaseService query:query mode:VCQueryNoMode];
    
    return update;
}


//DELETE
-(id)deleteVideoRefById:(NSString *) idVideo
{
    NSString *query =@"delete from VideoReference where idVideoRef ='";
    query = [query stringByAppendingString:idVideo];
    query = [query stringByAppendingString:@"';"];
    
    NSNumber *delete = [DatabaseService query:query mode:VCQueryNoMode];
    
    return delete;
}
@end
