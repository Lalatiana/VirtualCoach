//
//  CoachDataEngine.h
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 06/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoachDAO.h"
#import "CoachDO.h"

@interface CoachDataEngine : NSObject

@property (nonatomic) CoachDAO *coachDAO;

//INSERT
-(id)insertCoach:(CoachDO*)coachDO;
//SELECT
-(NSMutableArray<CoachDO*>*)selectAllCoaches;
-(CoachDO*)searchByLogin:(NSString*)login password:(NSString*)pass;
//DELETE
-(id)deleteCoachById:(int)idCoach;
@end
