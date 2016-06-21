//
//  PlayerDataEngine.m
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 06/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "PlayerDataEngine.h"
#import "PlayerDAO.h"
#import "StatisticalDAO.h"
#import "TrophyDAO.h"

@implementation PlayerDataEngine

//INSERT
-(id)insertPlayer:(PlayerDO *)playerDO
{
    NSString *leftHanded = @"0";
    if(playerDO.leftHanded == YES){
        leftHanded= @"0";
    }
    else{
        leftHanded = @"1";
    }
    
    return [_playerDAO insertIntoPlayer:playerDO.name firstName:playerDO.firstName leftHanded:leftHanded level:nil];
}

//SELECT
-(NSMutableArray<PlayerDO*>*)selectAllPlayers
{
    NSMutableArray<PlayerDO*> *arrayPlayerDO;
    PlayerDO *playerDO;
    PlayerDAO *playerDAO = [[PlayerDAO alloc]init];
    NSMutableArray<StatisticalDO*> *arrayStatDO;
    StatisticalDO *statDO;
    StatisticalDAO *statDAO = [[StatisticalDAO alloc]init];
   // NSMutableArray<TrophyDO*> *arrayTrophyDO;
   // TrophyDO *trophyDO;
   // TrophyDAO *trophyDAO = [[TrophyDAO alloc]init];
    
    NSArray *players = [playerDAO allPlayers];
    
    for(int i = 0; i<[players count]; i++){
        for(int j = 0; j<[players[i] count]; j++){
            
            NSArray *oneStat = [statDAO searchByIdPlayer:players[0][j]];
            
            statDO = [statDO initWithId:((NSNumber *)[[oneStat objectAtIndex:0] objectAtIndex:0]).intValue
                       andForehandCount:((NSNumber *)[[oneStat objectAtIndex:1] objectAtIndex:0]).intValue
                       andBackhandCount:((NSNumber *)[[oneStat objectAtIndex:2] objectAtIndex:0]).intValue
                        andServiceCount:((NSNumber *)[[oneStat objectAtIndex:3] objectAtIndex:0]).intValue
                          andWinningRun:((NSNumber *)[[oneStat objectAtIndex:4] objectAtIndex:0]).intValue
                          andLoosingRun:((NSNumber *)[[oneStat objectAtIndex:5] objectAtIndex:0]).intValue
           andForehandGlobalSuccessRate:[[[oneStat objectAtIndex:6] objectAtIndex:0 ]floatValue]
           andBackhandGlobalSuccessRate:[[[oneStat objectAtIndex:7] objectAtIndex:0] floatValue]
            andServiceGlobalSuccessRate:[[[oneStat objectAtIndex:8] objectAtIndex:0] floatValue]
                                 andDay:((NSNumber *)[[oneStat objectAtIndex:9] objectAtIndex:0]).intValue
                               andMonth:((NSNumber *)[[oneStat objectAtIndex:10] objectAtIndex:0]).intValue
                                andYear:((NSNumber *)[[oneStat objectAtIndex:11] objectAtIndex:0]).intValue
                      ];
            
            [arrayStatDO addObject:statDO];
            
            
            
            bool leftHanded = YES;
            if([players[3][0] integerValue] == 1){
                leftHanded= NO;
            }
            else{
                leftHanded = YES;
            }
            
            int idPlayerId = [players[0][j] intValue];
            playerDO = [[PlayerDO alloc] initWithId:idPlayerId
                                            andName:players[1][j]
                                       andFirstName:players[2][j]
                                      andLeftHanded:leftHanded
                                      andStatistics:arrayStatDO
                                        andTrophies:0];
            
            [arrayPlayerDO addObject:playerDO];
        }
    }
    
    return arrayPlayerDO;
}

-(PlayerDO*) selectPlayerById:(int)idP
{
    PlayerDAO *playerDAO = [[PlayerDAO alloc]init];
    PlayerDO *playerDO;
    
    
    NSArray *players = [playerDAO searchPlayerById:[NSString stringWithFormat:@"%i", idP]];
    
    playerDO.playerId = idP;
    playerDO.name = players[1][0];
    playerDO.firstName = players[2][0];
    playerDO.leftHanded = players[3][0];
    
    return playerDO;
}

//DELETE
-(id)deletePlayerId:(int)idP
{
    return [_playerDAO deletePlayerById:[NSString stringWithFormat:@"%i", idP]];
}
    
@end
