//
//  Histogram.m
//  VirtualCoach
//
//  Created by Bi ZORO on 02/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "Histogram.h"

@implementation Histogram

- (instancetype)init{
    self = [super init];
    if (self){
        _data=[[NSMutableArray alloc]initWithCapacity:360];
        for (NSInteger i=0; i<360; i++) {
            [_data insertObject:@0 atIndex:i];
        }
    }
    return  self;
}

- (void)generateHistogramFromSpeedVector:(vect2darray_t *)speed betweenInterval:(rect_t)interval andWithImageWidth:(uint16_t)width{
    
    double u = 0, v = 0;
    double angle = 0;
    double norm = 0;
    for (NSInteger y=interval.start.y; y<interval.end.y; y++) {
        for (NSInteger x=interval.start.x; x<interval.end.x; x++){
            u = speed->data[PXL_IDX(width, x, y)].x;
            v = speed->data[PXL_IDX(width, x, y)].y;
            norm = sqrt(u*u + v*v);
            if (norm > THRESHOLD_HISTOGRAM){
                angle = atan2(-v, u) * 180 / M_PI;
                if ((int)angle < 0) {
                    angle += 360;
                }
                _data[(int) angle] = @([[_data objectAtIndex:(int) angle] intValue] + 1);
            }
        }
    }
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.data forKey:@"angle"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self)
    {
        _data = [aDecoder decodeObjectForKey:@"angle"];
    }
    
    return self;
}

- (void)writeHistogramAtPath:(NSString *)path
{
    [NSKeyedArchiver archiveRootObject:self toFile:path];
}

+ (id)loadHistogramAtPath:(NSString *)path
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

- (void)writeHistogramForTestAtPath:(NSString *)path{
    
    const char * pathChar = path.UTF8String;
    FILE* fichier = NULL;
    fichier = fopen(pathChar, "w+");
    if (fichier != NULL){
        
        for (NSInteger i =0; i<_data.count; i++) {
            
            NSString *line = [NSString stringWithFormat:@"%ld %@\n", (long)i,[_data objectAtIndex:i]];
            const char * lineChar = line.UTF8String;
            fputs(lineChar, fichier);
        }
        
        fclose(fichier);
    }
    else{
        NSLog(@"Your file %@ does not exist",path);
    }
    
    
}


@end
