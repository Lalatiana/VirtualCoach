//
//  TrainingDataEngine.m
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 06/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "TrainingDataEngine.h"

@interface TrainingDataEngine()

-(NSMutableArray<TrainingDO*>*)fromResultSetToTrainingDOList:(NSArray*)result;

@end

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

//
// ***************** UTIL ****************
//
-(NSMutableArray<TrainingDO*>*)fromResultSetToTrainingDOList:(NSArray*)result {
    
    NSMutableArray<TrainingDO*>* trainingDOList = [[NSMutableArray<TrainingDO*> alloc] initWithCapacity:[result[0] count]];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];

    for (int i = 0; i < [result[0] count]; i++) {
        
        int stringId = [[[result objectAtIndex:0] objectAtIndex:i] intValue];
        NSString* stringDate = [[[result objectAtIndex:1] objectAtIndex:i] stringValue];
        NSString* stringName = [[[result objectAtIndex:2] objectAtIndex:i] stringValue];
        NSString* stringPlace = [[[result objectAtIndex:3] objectAtIndex:i] stringValue];
        
        [dateFormatter setDateFormat:@"dd/MM/YYYY"];
        NSDate* date = [dateFormatter dateFromString:stringDate];
        
        TrainingDO* trainingDO = [[TrainingDO alloc] initWithId:stringId andDate:date andName:stringName andPlace:stringPlace andVideos:nil];
        
        [trainingDOList addObject:trainingDO];
    }
    
    return trainingDOList;
}

@end
