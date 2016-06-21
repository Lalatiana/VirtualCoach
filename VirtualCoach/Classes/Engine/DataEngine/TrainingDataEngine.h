//
//  TrainingDataEngine.h
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 06/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TrainingDAO.h"
#import "TrainingDO.h"

@interface TrainingDataEngine : NSObject

@property (nonatomic) TrainingDAO* trainingDAO;

// INSERT
-(void)insertTraining:(TrainingDO*)trainingDO;

// SELECT
-(NSMutableArray<TrainingDO*>*)searchAllTrainings;
// TODO updates DAO select queries

// DELETE
-(void)deleteTrainingWithId:(int)trainingId;

@end
