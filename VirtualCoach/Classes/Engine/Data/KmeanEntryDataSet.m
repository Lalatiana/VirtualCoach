//
//  KmeanEntryDataSet.m
//  VirtualCoach
//
//  Created by Bi ZORO on 04/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "KmeanEntryDataSet.h"

@implementation KmeanEntryDataSet

-(instancetype)init{
    self = [super init];
    if (self){
        _data=[[NSMutableArray alloc]init];
        _datacount = 0;
    }
    return  self;
}

- (void)addKmeanEntryToDataSetFromFirstSpeedVectorsTab:(vect2darray_t *)speed1 andSecondSpeedVectorsTab:(vect2darray_t *)speed2 betweenInterval:(rect_t)interval andWithImageWidth:(uint16_t)width{
    
    KmeanEntry * entry = [[KmeanEntry alloc] init];
    [entry generateDataEntryForKmeanFromFirstSpeedVectorsTab:speed1 andSecondSpeedVectorsTab:speed2 betweenInterval:interval andWithImageWidth:width];
    [_data insertObject:entry atIndex:_datacount];
    _datacount ++;
    entry.time = _datacount;
    NSLog(@"time: %d", entry.time);
    
}

- (void)addKmeanEntryToDataSetFromFirstSpeedVectorsTab:(vect2darray_t *)speed1 betweenFirstInterval:(rect_t)firstInterval andSecondSpeedVectorsTab:(vect2darray_t *)speed2 betweenSecondInterval:(rect_t)secondInterval andWithImageWidth:(uint16_t)width{
    
    KmeanEntry * entry = [[KmeanEntry alloc] init];
    [entry generateDataEntryForKmeanFromFirstSpeedVectorsTab:speed1 betweenFirstInterval:firstInterval andSecondSpeedVectorsTab:speed2 betweenSecondInterval:secondInterval andWithImageWidth:width];
    [_data insertObject:entry atIndex:_datacount];
    _datacount ++;
    entry.time = _datacount;
    NSLog(@"time: %d", entry.time);
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.data forKey:@"dataset"];
    [aCoder encodeInt:self.datacount forKey:@"datacount"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self)
    {
        _data = [aDecoder decodeObjectForKey:@"dataset"];
        _datacount =[aDecoder decodeIntForKey:@"datacount"];
    }
    
    return self;
}

- (void)writeKmeanDatasetAtPath:(NSString *)path
{
    [NSKeyedArchiver archiveRootObject:self toFile:path];
}

+ (id)loadKmeanDatasetAtPath:(NSString *)path
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

- (void)writeKmeanDatasetForTestAtPath:(NSString *)path{
    
    const char * pathChar = path.UTF8String;
    FILE* fichier = NULL;
    fichier = fopen(pathChar, "w+");
    if (fichier != NULL){
        
        for (NSInteger i =0; i<_datacount; i++) {
            NSString *line = [NSString stringWithFormat:@"%d %f\n", ((KmeanEntry *)[_data objectAtIndex:i]).time, ((KmeanEntry *)[_data objectAtIndex:i]).meanAcceleration];
            const char * lineChar = line.UTF8String;
            fputs(lineChar, fichier);
        }
        
        fclose(fichier);
    }
    else{
        NSLog(@"Your file %@ does not exist",path);
    }
    
}

- (void)writeKmeanDataset3dForTestAtPath:(NSString *)path{
    
    const char * pathChar = path.UTF8String;
    FILE* fichier = NULL;
    fichier = fopen(pathChar, "w+");
    if (fichier != NULL){
        
        for (NSInteger i =0; i<_datacount; i++) {
            NSString *line = [NSString stringWithFormat:@"%d %f %d\n", ((KmeanEntry *)[_data objectAtIndex:i]).time, ((KmeanEntry *)[_data objectAtIndex:i]).meanAcceleration, ((KmeanEntry *)[_data objectAtIndex:i]).maxAngle];
            const char * lineChar = line.UTF8String;
            fputs(lineChar, fichier);
        }
        
        fclose(fichier);
    }
    else{
        NSLog(@"Your file %@ does not exist",path);
    }
    
}

- (void)writeKmeanDataset4dForTestAtPath:(NSString *)path{
    
    const char * pathChar = path.UTF8String;
    FILE* fichier = NULL;
    fichier = fopen(pathChar, "w+");
    if (fichier != NULL){
        
        for (NSInteger i =0; i<_datacount; i++) {
            NSString *line = [NSString stringWithFormat:@"%d %f %d %f\n", ((KmeanEntry *)[_data objectAtIndex:i]).time, ((KmeanEntry *)[_data objectAtIndex:i]).meanAcceleration, ((KmeanEntry *)[_data objectAtIndex:i]).maxAngle, ((KmeanEntry *)[_data objectAtIndex:i]).meanSpeed];
            const char * lineChar = line.UTF8String;
            fputs(lineChar, fichier);
        }
        
        fclose(fichier);
    }
    else{
        NSLog(@"Your file %@ does not exist",path);
    }
    
}

- (void)writeKmeanDataset2dSpeedTimeForTestAtPath:(NSString *)path{
    
    const char * pathChar = path.UTF8String;
    FILE* fichier = NULL;
    fichier = fopen(pathChar, "w+");
    if (fichier != NULL){
        
        for (NSInteger i =0; i<_datacount; i++) {
            NSString *line = [NSString stringWithFormat:@"%d %f\n", ((KmeanEntry *)[_data objectAtIndex:i]).time, ((KmeanEntry *)[_data objectAtIndex:i]).meanSpeed];
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
