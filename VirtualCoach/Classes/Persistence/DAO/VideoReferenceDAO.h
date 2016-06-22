//
//  VideoReferenceDAO.h
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 24/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseService.h"

@interface VideoReferenceDAO : NSObject

//INSERT
-(id)insertIntoVideoReference:(NSString *) name processed:(NSString *) proc removed:(NSString *) rm day:(NSString *) d month:(NSString *) m year:(NSString *) y idCoach:(NSString *) idc;
//SELECT
-(NSArray *) allVideoRef;
-(int)searchIdVideoRefByName:(NSString*) name Processed:(NSString *) proc;
-(int)searchIdVideoRefByName:(NSString*) name Removed:(NSString *) rm;
-(NSArray *)searchVideoRefByDay:(NSString*) d Month:(NSString *) m andYear:(NSString *) y;
-(NSArray *)searchVideoRefByMonth:(NSString *) m andYear:(NSString *) y;
-(NSArray *)searchVideoRefByIdCoach:(NSString *) idC;
//UPDATE
-(id)updatedVideoProcessing:(NSString *) proc byName:(NSString*) name;
-(id)updatedVideoRemoving:(NSString *)rm byName:(NSString*) name;
//DELETE
-(id)deleteVideoRefById:(NSString *) idVideo;

@end
