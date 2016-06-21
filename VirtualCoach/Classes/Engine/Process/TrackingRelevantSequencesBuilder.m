//
//  TrackingRelevantSequencesBuilder.m
//  VirtualCoachAllProcess
//
//  Created by Romain Dubreucq on 09/06/2016.
//  Copyright © 2016 Romain Dubreucq. All rights reserved.
//

#import "TrackingRelevantSequencesBuilder.h"

@interface TrackingRelevantSequencesBuilder ()

@property (nonatomic) NSUInteger motionImageFactor;
@property (nonatomic) NSArray *partialSequences;
@property (nonatomic, strong) NSMutableArray *relevantSequences;

- (NSMutableArray *)buildRelevantSequencesFromPartial;

@end

@implementation TrackingRelevantSequencesBuilder

- (instancetype)initWithPartialMotionArray:(NSArray *)array motionImageFactor:(NSUInteger)motionImageFactor
{
    self = [super init];
    
    if (self)
    {
        _motionImageFactor = motionImageFactor;
        _partialSequences = array;
    }
    
    return self;
}

- (NSMutableArray *)buildRelevantSequencesFromPartial
{
    NSMutableArray *finalObjectsMotion = [_partialSequences mutableCopy];
    
    NSUInteger currentMarkerIndex;
    NSUInteger previousMarkerIndex = 0;
    int previousMarker = ((NSNumber *)[finalObjectsMotion objectAtIndex:0]).intValue;
    
    for (NSUInteger i = _motionImageFactor; i < finalObjectsMotion.count; i += _motionImageFactor)
    {
        currentMarkerIndex = i;
        
        int currentMarker = ((NSNumber *)[finalObjectsMotion objectAtIndex:currentMarkerIndex]).intValue;
        
        int newValue = (currentMarker == 0 && previousMarker == 0) ? 0 : 1;
        
        if (currentMarker == 0 && previousMarker == 0)
            newValue = 0;
        
        else if (currentMarker == -2 && previousMarker == -2)
            newValue = 0;
        
        else if (currentMarker == 0 && previousMarker == -2)
            newValue = 0;
        
        else if (currentMarker == -2 && previousMarker == 0)
            newValue = 0;
        
        else
            newValue = 1;
        
        for (NSUInteger k = previousMarkerIndex + 1; k < currentMarkerIndex; k++)
            [finalObjectsMotion replaceObjectAtIndex:k withObject:[NSNumber numberWithInt:newValue]];
        
        previousMarker = currentMarker;
        previousMarkerIndex = currentMarkerIndex;
    }
    
    return finalObjectsMotion;
}

- (NSMutableArray *)removeIrrelevantSequences
{
    
    return nil;
}

- (void)buildRelevantSequences
{
    _relevantSequences = [self buildRelevantSequencesFromPartial];
}

- (NSMutableArray *)retreiveRelevantSequences
{
    return _relevantSequences;
}

@end
