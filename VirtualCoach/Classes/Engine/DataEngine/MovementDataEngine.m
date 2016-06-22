//
//  MovementDataEngine.m
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 06/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "MovementDataEngine.h"

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

//INSERT
/*-(id)insertMovment:(MovementDO*)movementDO andIdVideo:(int) idVideo
{
    NSString *winning = @"0";
    if(movementDO.winning == NO){
        winning= @"1";
    }
    
    NSString *loosing = @"0";
    if(movementDO.loosing == NO){
        loosing= @"1";
    }
    return [_movementDAO insertIntoMovement:movementDO.type
                                     winner:winning
                                     losing:loosing
                               success_rate:movementDO.successRate
                                   id_video:nil];
}*/

@end
