//
//  VideoDAO.h
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 15/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseService.h"

@interface VideoDAO : NSObject

//INSERT
-(id)insertIntoVideo:(NSString *) name processed:(NSString *) proc removed:(NSString *) rm day:(NSString *) d month:(NSString *) m year:(NSString *) y;
//SELECT
-(NSArray *) allVideo;
-(int)searchIdVideoByName:(NSString*) name Processed:(NSString *) proc;
-(int)searchIdVideoByName:(NSString*) name Removed:(NSString *) rm;
-(NSArray *)searchVideoByDay:(NSString*) d Month:(NSString *) m andYear:(NSString *) y;
-(NSArray *)searchVideoByMonth:(NSString *) m andYear:(NSString *) y;
//UPDATE
-(id)udpatedVideoProcessing:(NSString *) proc byName:(NSString*) name;
-(id)udpatedVideoRemoving:(NSString *)rm byName:(NSString*) name;
//DELETE
-(id)deleteVideoById:(NSString *) idVideo;

@end
