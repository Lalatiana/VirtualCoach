//
//  StatisticalDataEngine.h
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 06/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatisticalDAO.h"
#import "StatisticalDO.h"

@interface StatisticalDataEngine : NSObject

@property (nonatomic) StatisticalDAO* statisticalDAO;

// INSERT
/*!
 * Inserts a statistical for a given player id.
 *
 * WARNING : if a statistical has already been inserted for the given day, month and year trio, then you should use UPDATE methods.
 *
 */
-(void)insertStatistical:(StatisticalDO*)statisticalDO forPlayerId:(int)playerId;

// SELECT
-(NSMutableArray<StatisticalDO*>*)searchAllStatisticals;
-(NSMutableArray<StatisticalDO*>*)searchByDay:(int)day andMonth:(int)month andYear:(int)year andPlayerId:(int)playerId;
-(NSMutableArray<StatisticalDO*>*)searchByMonth:(int)month andYear:(int)year andPlayerId:(int)playerId;
-(NSMutableArray<StatisticalDO*>*)searchByYear:(int)year andPlayerId:(int)playerId;
-(NSMutableArray<StatisticalDO*>*)searchByPlayerId:(int)playerId;
-(NSMutableArray<StatisticalDO*>*)searchFromDay:(int)startDay andMonth:(int)startMonth andYear:(int)startYear toDay:(int)endDay andMonth:(int)endMonth andYear:(int)endYear forPlayerId:(int)playerId;

// UPDATE
-(void)updateServiceGlobalSuccessRate:(float)serviceGlobalSuccessRate forDay:(int)day andMonth:(int)month andYear:(int)year andPlayerId:(int)playerId;
-(void)updateForehandGlobalSuccessRate:(float)forehandGlobalSuccessRate forDay:(int)day andMonth:(int)month andYear:(int)year andPlayerId:(int)playerId;
-(void)updateBackhandGlobalSuccessRate:(float)backhandGlobalSuccessRate forDay:(int)day andMonth:(int)month andYear:(int)year andPlayerId:(int)playerId;

// DELETE
-(void)deleteStatisticalById:(int)statisticalId;

@end
