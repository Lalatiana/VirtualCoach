//
//  PlayerDO.h
//  VirtualCoach
//
//  Created by Adrien on 24/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#ifndef PlayerDO_h
#define PlayerDO_h

#import <Foundation/Foundation.h>
#import "StatisticDO.h"
#import "TrophyDO.h"

@interface PlayerDO : NSObject

@property (nonatomic) int playerId;
@property (nonatomic) NSString* name;
@property (nonatomic) NSString* firstName;
@property (nonatomic) bool leftHanded;
@property (nonatomic) NSMutableArray<StatisticDO*>* statistics;
@property (nonatomic) NSMutableArray<TrophyDO*>* trophies;

-(instancetype)initWithId:(int)playerId andName:(NSString*)name andFirstName:(NSString*)firstName andLeftHanded:(bool)leftHanded andStatistics:(NSMutableArray<StatisticDO*>*)statistics andTrophies:(NSMutableArray<TrophyDO*>*)trophies;

@end

#endif /* PlayerDO_h */
