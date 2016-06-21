//
//  TrainingDataEngine.m
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 06/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "TrainingDataEngine.h"

@implementation TrainingDataEngine

/*!
 * Instantiates a new TrainingDataEngine.
 */
-(instancetype)init {
    
    self = [super init];
    
    if (self) {
        _trainingDAO = [[TrainingDAO alloc] init];
    }
    
    return self;
}

//
// #### INSERT ####
//
-(void)insertTraining:(TrainingDO*)trainingDO {
    
    if (trainingDO) {
        
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/YYYY"];
        NSString* date = [dateFormatter stringFromDate:trainingDO.date];
        
        NSString* name = trainingDO.name;
        NSString* place = trainingDO.place;
        
        [_trainingDAO insertIntoTraining:date name:name place:place];
        
    } else {
        NSLog(@"Error : the trainingDO is nil");
    }
}

//
// #### SELECT ####
//
-(NSMutableArray<TrainingDO*>*)searchAllTrainings {
    return nil;
}

//
// #### DELETE ####
//
-(void)deleteTrainingWithId:(int)trainingId {
    
}

@end
