//
//  CoachDAO.h
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 15/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseService.h"

@interface CoachDAO : NSObject

//INSERT
-(id)insertIntoCoach:(NSString *) name firstName:(NSString *) fname leftHanded:(NSString *) lh login:(NSString *) log password:(NSString *) pass;
//SELECT
-(NSArray *) allCoaches;
-(NSArray *)searchByLogin:(NSString *) login password:(NSString *) pass;
//DELETE
-(id)deleteCoachById:(NSString *) idCoach;
//UPDATE


@end
