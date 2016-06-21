//
//  main.m
//  TestChaineComplete
//
//  Created by Romain Dubreucq on 13/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoProcess.h"
#import "KmeanEntryDataSet.h"
#import "TrackingAnalysisProcess.h"
#import "KmeanCalculation.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        NSDictionary *dictInfo = [NSDictionary dictionaryWithContentsOfFile:@"/Volumes/ZORO 1/VideoTest/2016-06-06_19.19.40-data.plist"];
        
        VideoProcess *vidProc = [[VideoProcess alloc] initWithDictionary:dictInfo];
        
        vidProc.samplingCount = 10;
        vidProc.overlappingRate = 0.6;
        vidProc.scale = 0.5;
        vidProc.shouldDeleteIrrelevantSequences = YES;
        
        [vidProc setup];
        [vidProc start];
        
        NSMutableArray *dataEntrysets = vidProc.dataAnalysisProcess.entryDatasetsArray;
        
        NSString *videoDirectory = [(NSString *)[dictInfo objectForKey:@"videoPath"] stringByDeletingPathExtension];
        
        NSFileManager *defaultManager = [NSFileManager defaultManager];
        
        if (![defaultManager createDirectoryAtPath:videoDirectory withIntermediateDirectories:NO attributes:nil error:nil])
        {
            NSLog(@"Couldn't create directory %@", videoDirectory);
        }
        
        NSString *videoName = [[(NSString *)[dictInfo objectForKey:@"videoPath"] lastPathComponent] stringByDeletingPathExtension];
        
        for (NSUInteger i = 0; i < dataEntrysets.count; i++)
        {
            KmeanEntryDataSet *dataSetEntry = (KmeanEntryDataSet *)[[dataEntrysets objectAtIndex:i] objectForKey:@"entryDataset"];
            
            /*
             KmeanCalculation *kmeanCalculation = [[KmeanCalculation alloc] initKmeanCalculationWithKmeanEntryDataSet:dataSetEntry andClusterCount:2];
             NSLog(@"begin clusturing");
             [kmeanCalculation kmeanProcessWithMaxIteration:60];
             NSLog(@"end clusturing");
             */
            
            NSNumber *startSequenceImage = (NSNumber *)[[dataEntrysets objectAtIndex:i] objectForKey:@"startSequenceImage"];
            
            NSNumber *endSequenceImage = (NSNumber *)[[dataEntrysets objectAtIndex:i] objectForKey:@"endSequenceImage"];
            
            NSString *path = [videoDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-%d-(%d,%d)dataEntrySet4d.txt", videoName, (int)i, startSequenceImage.intValue, endSequenceImage.intValue]];
            //NSString *pathForKmean = [videoDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-%d-(%d,%d)kmeanCalculation.txt", videoName, (int)i, startSequenceImage.intValue, endSequenceImage.intValue]];
            
            
            //[entryDataSet writeKmeanDatasetForTestAtPath:path];
            //[kmeanCalculation writeKmeanCalculationForTestAtPath:pathForKmean];
            [dataSetEntry writeKmeanDataset4dForTestAtPath:path];
        }
        
        NSLog(@"Done!");
    }
    return 0;
}
