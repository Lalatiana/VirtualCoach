//
//  VideoDataEngine.m
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 06/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "VideoDataEngine.h"
#import "PlayerTrainingVideoDAO.h"

@implementation VideoDataEngine

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _videoDAO = [[VideoDAO alloc] init];
    }
    
    return self;
}

//INSERT
-(id)insertVideo:(VideoDO *)videoDO andIdPlayer:(int) idPlayer andIdTraining:(int)idTraining
{
    PlayerTrainingVideoDAO *ptv = [[PlayerTrainingVideoDAO alloc] init];
    
    NSString *processed = @"0";
    if(videoDO.processed == NO){
        processed= @"1";
    }
    
    NSString *removed = @"0";
    if(videoDO.removed == NO){
        processed= @"1";
    }
    
    id insertVideo = [_videoDAO insertIntoVideo:videoDO.name
                                             processed:processed
                                               removed:removed
                                                   day:[NSString stringWithFormat:@"%i",videoDO.day]
                                                 month:[NSString stringWithFormat:@"%i",videoDO.month]
                                                  year:[NSString stringWithFormat:@"%i",videoDO.year]
                                                        ];
    int idVideo = [_videoDAO searchIdVideoByName:videoDO.name Processed:processed];
    
    [ptv insertIntoPlayer_Training_Video:[NSString stringWithFormat:@"%i",idPlayer]
                             id_training:[NSString stringWithFormat:@"%i",idTraining]
                                id_video:[NSString stringWithFormat:@"%i",idVideo]
                                          ];
    
    
    
    return insertVideo;
}

@end
