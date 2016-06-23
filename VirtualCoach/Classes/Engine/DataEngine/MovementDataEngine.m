//
//  MovementDataEngine.m
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 06/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "MovementDataEngine.h"

@interface MovementDataEngine ()
- (NSString*) convertToString:(MovementEnum)type;
@end

@implementation MovementDataEngine

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _movementDAO = [[MovementDAO alloc] init];
    }
    
    return self;
}

//convert enum to NSSTRING
- (NSString*) convertToString:(MovementEnum)type
{
    NSString *typeMvt = nil;
    switch(type) {
        case FOREHAND:
            typeMvt = @"FOREHAND";
            break;
        case BACKHAND:
            typeMvt = @"BACKHAND";
            break;
        case SERVICE:
            typeMvt = @"SERVICE";
            break;
            
        default:
            typeMvt = @"unknown";
    }
    
    return typeMvt;
    
}
//INSERT
-(id)insertMovment:(MovementDO*)movementDO andIdVideo:(int) idVideo
{
    NSString *winning = @"0";
    if(movementDO.winning == NO){
        winning= @"1";
    }
    
    NSString *loosing = @"0";
    if(movementDO.loosing == NO){
        loosing= @"1";
    }
    
    NSString *type = [self convertToString:movementDO.type];
    
    return [_movementDAO insertIntoMovement:type
                                     winner:winning
                                     losing:loosing
                               success_rate:[NSString stringWithFormat:@"%1.6f", movementDO.successRate]
                                   id_video:nil];
}

@end
