//
//  StatisticalDataEngine.m
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 06/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "StatisticalDataEngine.h"

@interface StatisticalDataEngine()

-(NSMutableArray<StatisticalDO*>*)fromResultSetToStatisticalDOList:(NSArray*)result;
-(void)updateGlobalSuccessRate:(float)globalSuccessRate forDay:(int)day andMonth:(int)month andYear:(int)year andPlayerId:(int)playerId forMovementType:(int)movementType;

@end

@implementation StatisticalDataEngine

/*
 * Instantiates a new StatisticalDataEngine.
 */
-(instancetype)init {
    
    self = [super init];
    
    if (self) {
        _statisticalDAO = [[StatisticalDAO alloc] init];
    }
    
    return self;
}

//
// #### INSERT ####
//
-(void)insertStatistical:(StatisticalDO*)statisticalDO forPlayerId:(int)playerId {
    
    if (statisticalDO) {
        
        NSString* forehandCount = [NSString stringWithFormat:@"%d", statisticalDO.forehandCount];
        NSString* backhandCount = [NSString stringWithFormat:@"%d", statisticalDO.backhandCount];
        NSString* serviceCount = [NSString stringWithFormat:@"%d", statisticalDO.serviceCount];
        NSString* winningRun = [NSString stringWithFormat:@"%d", statisticalDO.winningRun];
        NSString* loosingRun = [NSString stringWithFormat:@"%d", statisticalDO.loosingRun];
        NSString* forehandGlobalSuccessRate = [NSString stringWithFormat:@"%f", statisticalDO.forehandGlobalSuccessRate];
        NSString* backhandGlobalSuccessRate = [NSString stringWithFormat:@"%f", statisticalDO.backhandGlobalSuccessRate];
        NSString* serviceGlobalSuccessRate = [NSString stringWithFormat:@"%f", statisticalDO.serviceGlobalSuccessRate];
        NSString* day = [NSString stringWithFormat:@"%d", statisticalDO.day];
        NSString* month = [NSString stringWithFormat:@"%d", statisticalDO.month];
        NSString* year = [NSString stringWithFormat:@"%d", statisticalDO.year];
        NSString* playerIdString = [NSString stringWithFormat:@"%d", playerId];
        
        [_statisticalDAO insertIntoStatistical:forehandCount
                                          backhanh:backhandCount
                                           service:serviceCount
                                        winningRun:winningRun
                                         losingRun:loosingRun
                         globalSuccessRateForehand:forehandGlobalSuccessRate
                         globalSuccessRateBackhand:backhandGlobalSuccessRate
                          globalSuccessRateService:serviceGlobalSuccessRate
                                               day:day
                                             month:month
                                              year:year
                                          idPlayer:playerIdString];
        
    } else {
        NSLog(@"Error : the statisticalDO is nil");
    }
}

//
// #### SELECT ####
//
-(NSMutableArray<StatisticalDO*>*)searchAllStatisticals {
    NSArray* searchResult = [_statisticalDAO allStatistical];
    
    return [self fromResultSetToStatisticalDOList:searchResult];
}

-(NSMutableArray<StatisticalDO*>*)searchByDay:(int)day andMonth:(int)month andYear:(int)year andPlayerId:(int)playerId {
    NSString* stringDay = [NSString stringWithFormat:@"%d", day];
    NSString* stringMonth = [NSString stringWithFormat:@"%d", month];
    NSString* stringYear = [NSString stringWithFormat:@"%d", year];
    NSString* stringPlayerId = [NSString stringWithFormat:@"%d", playerId];
    
    NSArray* searchResult = [_statisticalDAO searchByDay:stringDay Month:stringMonth Andyear:stringYear andIdPlayer:stringPlayerId];
    
    return [self fromResultSetToStatisticalDOList:searchResult];
}

-(NSMutableArray<StatisticalDO*>*)searchByMonth:(int)month andYear:(int)year andPlayerId:(int)playerId {
    NSString* stringMonth = [NSString stringWithFormat:@"%d", month];
    NSString* stringYear = [NSString stringWithFormat:@"%d", year];
    NSString* stringPlayerId = [NSString stringWithFormat:@"%d", playerId];
    
    NSArray* searchResult = [_statisticalDAO searchByMonth:stringMonth Andyear:stringYear andIdPlayer:stringPlayerId];
    
    return [self fromResultSetToStatisticalDOList:searchResult];
}

-(NSMutableArray<StatisticalDO*>*)searchByYear:(int)year andPlayerId:(int)playerId {
    NSString* stringYear = [NSString stringWithFormat:@"%d", year];
    NSString* stringPlayerId = [NSString stringWithFormat:@"%d", playerId];
    
    NSArray* searchResult = [_statisticalDAO searchByYear:stringYear andIdPlayer:stringPlayerId];
    
    // TODO : average by month
    
    return [self fromResultSetToStatisticalDOList:searchResult];
}

-(NSMutableArray<StatisticalDO*>*)searchByPlayerId:(int)playerId {
    NSString* stringPlayerId = [NSString stringWithFormat:@"%d", playerId];
    
    NSArray* searchResult = [_statisticalDAO searchByIdPlayer:stringPlayerId];
    
    return [self fromResultSetToStatisticalDOList:searchResult];
}

-(NSMutableArray<StatisticalDO*>*)searchFromDay:(int)startDay andMonth:(int)startMonth andYear:(int)startYear toDay:(int)endDay andMonth:(int)endMonth andYear:(int)endYear forPlayerId:(int)playerId {
    
    NSString* stringStartDay = [NSString stringWithFormat:@"%d", startDay];
    NSString* stringStartMonth = [NSString stringWithFormat:@"%d", startMonth];
    NSString* stringStartYear = [NSString stringWithFormat:@"%d", startYear];
    NSString* stringEndDay = [NSString stringWithFormat:@"%d", endDay];
    NSString* stringEndMonth = [NSString stringWithFormat:@"%d", endMonth];
    NSString* stringEndYear = [NSString stringWithFormat:@"%d", endYear];
    NSString* stringPlayerId = [NSString stringWithFormat:@"%d", playerId];
    
    NSArray* searchResult = [_statisticalDAO searchFromDay:stringStartDay andMonth:stringStartMonth andYear:stringStartYear toDay:stringEndDay andMonth:stringEndMonth andYear:stringEndYear forPlayerId:stringPlayerId];
    
    return [self fromResultSetToStatisticalDOList:searchResult];
}

//
// #### UPDATE ####
//
-(void)updateServiceGlobalSuccessRate:(float)serviceGlobalSuccessRate forDay:(int)day andMonth:(int)month andYear:(int)year andPlayerId:(int)playerId {
    
    [self updateGlobalSuccessRate:serviceGlobalSuccessRate forDay:day andMonth:month andYear:year andPlayerId:playerId forMovementType:0];
}

-(void)updateForehandGlobalSuccessRate:(float)forehandGlobalSuccessRate forDay:(int)day andMonth:(int)month andYear:(int)year andPlayerId:(int)playerId {
    
    [self updateGlobalSuccessRate:forehandGlobalSuccessRate forDay:day andMonth:month andYear:year andPlayerId:playerId forMovementType:1];
}

-(void)updateBackhandGlobalSuccessRate:(float)backhandGlobalSuccessRate forDay:(int)day andMonth:(int)month andYear:(int)year andPlayerId:(int)playerId {
    
    [self updateGlobalSuccessRate:backhandGlobalSuccessRate forDay:day andMonth:month andYear:year andPlayerId:playerId forMovementType:2];
}

//
// #### DELETE ####
//
-(void)deleteStatisticalById:(int)statisticalId {
    NSString* stringStatisticalId = [NSString stringWithFormat:@"%d", statisticalId];
    
    [_statisticalDAO deleteStatisticalById:stringStatisticalId];
}

//
// ************ UTIL *************
//

-(NSMutableArray<StatisticalDO*>*)fromResultSetToStatisticalDOList:(NSArray*)result {
    
    NSMutableArray<StatisticalDO*>* statisticalDOList = [[NSMutableArray<StatisticalDO*> alloc] initWithCapacity:[result[0] count]];
    
    for (int i = 0; i < [result[0] count]; i++) {
        
        int statisticalId = [[[result objectAtIndex:0] objectAtIndex:i] intValue];
        int forehandCount = [[[result objectAtIndex:1] objectAtIndex:i] intValue];
        int backhandCount = [[[result objectAtIndex:2] objectAtIndex:i] intValue];
        int serviceCount = [[[result objectAtIndex:3] objectAtIndex:i] intValue];
        int winningRun = [[[result objectAtIndex:4] objectAtIndex:i] intValue];
        int loosingRun = [[[result objectAtIndex:5] objectAtIndex:i] intValue];
        float forehandGlobalSuccessRate = [[[result objectAtIndex:6] objectAtIndex:i] floatValue];
        float backhandGlobalSuccessRate = [[[result objectAtIndex:7] objectAtIndex:i] floatValue];
        float serviceGlobalSuccessRate = [[[result objectAtIndex:8] objectAtIndex:i] floatValue];
        int day = [[[result objectAtIndex:9] objectAtIndex:i] intValue];
        int month = [[[result objectAtIndex:10] objectAtIndex:i] intValue];
        int year = [[[result objectAtIndex:11] objectAtIndex:i] intValue];
        
        StatisticalDO* statisticalDO = [[StatisticalDO alloc] initWithId:statisticalId andForehandCount:forehandCount andBackhandCount:backhandCount andServiceCount:serviceCount andWinningRun:winningRun andLoosingRun:loosingRun andForehandGlobalSuccessRate:forehandGlobalSuccessRate andBackhandGlobalSuccessRate:backhandGlobalSuccessRate andServiceGlobalSuccessRate:serviceGlobalSuccessRate andDay:day andMonth:month andYear:year];
        
        [statisticalDOList addObject:statisticalDO];
    }
    
    return statisticalDOList;
}

-(void)updateGlobalSuccessRate:(float)globalSuccessRate forDay:(int)day andMonth:(int)month andYear:(int)year andPlayerId:(int)playerId forMovementType:(int)movementType {
    
    NSString* stringGlobalSuccessRate = [NSString stringWithFormat:@"%f", globalSuccessRate];
    NSString* stringDay = [NSString stringWithFormat:@"%d", day];
    NSString* stringMonth = [NSString stringWithFormat:@"%d", month];
    NSString* stringYear = [NSString stringWithFormat:@"%d", year];
    NSString* stringPlayerId = [NSString stringWithFormat:@"%d", playerId];
    
    switch (movementType) {
        case 0:
            [_statisticalDAO updateServiceGlobalSuccessRate:stringGlobalSuccessRate forDay:stringDay Month:stringMonth andYear:stringYear andIdPlayer:stringPlayerId];
            break;
        case 1:
            [_statisticalDAO updateForeHandGlobalSuccessRate:stringGlobalSuccessRate forDay:stringDay Month:stringMonth andYear:stringYear andIdPlayer:stringPlayerId];
            break;
        case 2:
            [_statisticalDAO updateBackhandGlobalSuccessRate:stringGlobalSuccessRate forDay:stringDay Month:stringMonth andYear:stringYear andIdPlayer:stringPlayerId];
        default:
            NSLog(@"Unknown movement type : %d", movementType);
            break;
    }
}

@end



