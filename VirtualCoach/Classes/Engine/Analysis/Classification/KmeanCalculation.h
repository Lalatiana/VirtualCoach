//
//  KmeanCalculation.h
//  VirtualCoach
//
//  Created by Bi ZORO on 15/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KmeanEntryDataSet.h"
#import "Cluster.h"
#import "DistanceUtilities.h"

@interface KmeanCalculation : NSObject <NSCoding>

@property (nonatomic) KmeanEntryDataSet * dataEntries;
@property (nonatomic) NSMutableArray * clusters;
@property (nonatomic) int clusterCount;
@property (nonatomic) NSMutableArray * centroids;


/*!
 @method initKmeanCalculationWithPathOfDataEntries:path andClusterCount:clusterCount
 @abstract
 Initializes properties of KmeanCalculation objects
 @param path
 Path to the file which contains data to classify. We load data in property dataEntries
 @param clusterCount
 Determines number of cluster, we want to create
 @discussion
 */
- (instancetype)initKmeanCalculationWithPathOfDataEntries:(NSString *)path andClusterCount:(int)clusterCount;

- (instancetype)initKmeanCalculationWithKmeanEntryDataSet:(KmeanEntryDataSet *)dataSet andClusterCount:(int)clusterCount;

- (void)kmeanProcessWithMaxIteration:(int)maxIteration;

- (void)writeKmeanCalculationForTestAtPath:(NSString *)path;

@end
