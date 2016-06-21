//
//  PlayerDataEngine.h
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 06/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayerDAO.h"
#import "PlayerDO.h"

@interface PlayerDataEngine : NSObject

@property (nonatomic) PlayerDAO *playerDAO;

//INSERT
-(id)insertPlayer:(PlayerDO *)playerDO;
//SELECT
-(NSMutableArray<PlayerDO*>*)selectAllPlayers;
-(PlayerDO*) selectPlayerById:(int)idP;
//DELETE
-(id)deletePlayerId:(int)idP;

@end
