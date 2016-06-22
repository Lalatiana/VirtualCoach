//
//  VideoDataEngine.h
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 06/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoDataEngine.h"
#import "VideoDO.h"
#import "VideoDAO.h"

@interface VideoDataEngine : NSObject

@property (nonatomic) VideoDAO *videoDAO;

//INSERT
-(id)insertVideo:(VideoDO *)videoDO andIdPlayer:(int) idPlayer andIdTraining:(int)idTraining;

@end
