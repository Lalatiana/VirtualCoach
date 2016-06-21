//
//  KmeanEntry.m
//  VirtualCoach
//
//  Created by Bi ZORO on 03/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "KmeanEntry.h"

@implementation KmeanEntry

- (instancetype)init{
    self = [super init];
    if (self){
        _time =0;
        _maxAngle =0;
        _meanAcceleration =0;
        _meanSpeed =0;
    }
    return  self;
}

- (void)generateDataEntryForKmeanFromFirstSpeedVectorsTab:(vect2darray_t *)speed1 andSecondSpeedVectorsTab:(vect2darray_t *)speed2 betweenInterval:(rect_t)interval andWithImageWidth:(uint16_t)width{
    
    NSMutableArray * tmpHistogram = [[NSMutableArray alloc] initWithCapacity:360];
    for (NSInteger i=0; i<360; i++) {
        [tmpHistogram insertObject:@0 atIndex:i];
    }
    
    int minHit =0;
    double u1 = 0, u2 = 0, v1 = 0, v2= 0;
    double angle = 0;
    double norm1 = 0, norm2 =0;
    double meanSpeed1=0, meanSpeed2=0;
    int countSpeed1=0, countSpeed2=0;
    for (NSInteger y=interval.start.y; y<interval.end.y; y++) {
        for (NSInteger x=interval.start.x; x<interval.end.x; x++){
            u2= speed2->data[PXL_IDX(width, x, y)].x;
            v2= speed2->data[PXL_IDX(width, x, y)].y;
            
            float tmpNorm2 = sqrt(u2*u2 + v2*v2);
            if(tmpNorm2 > THRESHOLD_NORM_SPEED_VECTORS){
                norm2 += tmpNorm2;
                countSpeed2++;
            }
            
            u1= speed1->data[PXL_IDX(width, x, y)].x;
            v1= speed1->data[PXL_IDX(width, x, y)].y;
            
            float tmpNorm1 = sqrt(u1*u1 + v1*v1);
            if(tmpNorm1 > THRESHOLD_NORM_SPEED_VECTORS){
                norm1 += tmpNorm1;
                countSpeed1 ++;
            }
            
            
            if (tmpNorm2 > THRESHOLD_HISTOGRAM){
                angle = atan2(-v2, u2) * 180 / M_PI;
                if ((int)angle < 0) {
                    angle += 360;
                }
                tmpHistogram[(int) angle] = @([[tmpHistogram objectAtIndex:(int) angle] intValue] + 1);
            }
        }
    }
    
    meanSpeed1 = norm1/countSpeed1;
    meanSpeed2 = norm2/countSpeed2;
    NSLog(@"meanSpeed2: %lf - meanSpeed1: %lf = %lf", meanSpeed2, meanSpeed1, meanSpeed2-meanSpeed1);
    _meanSpeed = meanSpeed2;
    _meanAcceleration = meanSpeed2 - meanSpeed1;
    for (NSInteger i=0; i<360; i++) {
        if ([[tmpHistogram objectAtIndex:i] intValue] > minHit) {
            minHit = [[tmpHistogram objectAtIndex:i] intValue];
            _maxAngle = (int)i;
        }
    }
    [tmpHistogram removeAllObjects];
    
    
}

- (void)generateDataEntryForKmeanFromFirstSpeedVectorsTab:(vect2darray_t *)speed1 betweenFirstInterval:(rect_t)firstInterval andSecondSpeedVectorsTab:(vect2darray_t *)speed2 betweenSecondInterval:(rect_t)secondInterval andWithImageWidth:(uint16_t)width{
    
    NSMutableArray * tmpHistogram = [[NSMutableArray alloc] initWithCapacity:360];
    for (NSInteger i=0; i<360; i++) {
        [tmpHistogram insertObject:@0 atIndex:i];
    }
    
    int minHit =0;
    double u1 = 0, u2 = 0, v1 = 0, v2= 0;
    double angle = 0;
    double norm1 = 0, norm2 =0;
    double meanSpeed1=0, meanSpeed2=0;
    int countSpeed1=0, countSpeed2=0;
    NSLog(@"firstInterval starty: %d firstInterval endy: %d", firstInterval.start.y,firstInterval.end.y);
    NSLog(@"firstInterval startx: %d firstInterval endx: %d", firstInterval.start.x,firstInterval.end.x);
    for (NSInteger y=firstInterval.start.y; y<firstInterval.end.y; y++) {
        for (NSInteger x=firstInterval.start.x; x<firstInterval.end.x; x++){
            u1= speed1->data[PXL_IDX(width, x, y)].x;
            v1= speed1->data[PXL_IDX(width, x, y)].y;
            
            float tmpNorm1 = sqrt(u1*u1 + v1*v1);
            if(tmpNorm1 > THRESHOLD_NORM_SPEED_VECTORS){
                norm1 += tmpNorm1;
                countSpeed1 ++;
            }
        }
    }
    
    NSLog(@"secondInterval starty: %d secondInterval endy: %d", secondInterval.start.y,secondInterval.end.y);
    NSLog(@"secondInterval startx: %d secondInterval endx: %d", secondInterval.start.x,secondInterval.end.x);
    for (NSInteger y=secondInterval.start.y; y<secondInterval.end.y; y++) {
        for (NSInteger x=secondInterval.start.x; x<secondInterval.end.x; x++){
            u2= speed2->data[PXL_IDX(width, x, y)].x;
            v2= speed2->data[PXL_IDX(width, x, y)].y;
            
            float tmpNorm2 = sqrt(u2*u2 + v2*v2);
            if(tmpNorm2 > THRESHOLD_NORM_SPEED_VECTORS){
                norm2 += tmpNorm2;
                countSpeed2++;
            }
            
            if (tmpNorm2 > THRESHOLD_HISTOGRAM){
                angle = atan2(-v2, u2) * 180 / M_PI;
                if ((int)angle < 0) {
                    angle += 360;
                }
                tmpHistogram[(int) angle] = @([[tmpHistogram objectAtIndex:(int) angle] intValue] + 1);
            }
            
        }
    }
    
    if(countSpeed1 == 0){
        countSpeed1 =1;
    }
    if(countSpeed2 == 0){
        countSpeed2 =1;
    }
    meanSpeed1 = norm1/countSpeed1;
    meanSpeed2 = norm2/countSpeed2;
    NSLog(@"meanSpeed2: %lf - meanSpeed1: %lf = %lf", meanSpeed2, meanSpeed1, meanSpeed2-meanSpeed1);
    _meanSpeed = meanSpeed2;
    _meanAcceleration = meanSpeed2 - meanSpeed1;
    for (NSInteger i=0; i<360; i++) {
        if ([[tmpHistogram objectAtIndex:i] intValue] > minHit) {
            minHit = [[tmpHistogram objectAtIndex:i] intValue];
            _maxAngle = (int)i;
        }
    }
    [tmpHistogram removeAllObjects];
    
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:self.time forKey:@"time"];
    [aCoder encodeInt:self.maxAngle forKey:@"angle"];
    [aCoder encodeDouble:self.meanAcceleration forKey:@"acceleration"];
    [aCoder encodeDouble:self.meanSpeed forKey:@"speed"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self)
    {
        _time =[aDecoder decodeIntForKey:@"time"];
        _maxAngle =[aDecoder decodeIntForKey:@"angle"];
        _meanAcceleration =[aDecoder decodeDoubleForKey:@"acceleration"];
        _meanSpeed = [aDecoder decodeDoubleForKey:@"speed"];
    }
    
    return self;
}


@end
