//
//  KmeanCalculation.m
//  VirtualCoach
//
//  Created by Bi ZORO on 15/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "KmeanCalculation.h"

@interface KmeanCalculation ()

/*!
 @method generateClusterWithIterration:iteration
 @abstract
 Generates all cluster with her center and her members.
 @param iteration
 0 => first launch of this method, so we add all centroids point to each member's cluster, because at initialization centroid are choozen in set of our data.
 != 0 => all centroid wich have been recalculated are not add in each member's cluster.
 @discussion
 */
- (NSMutableArray *) generateClusterWithIterration:(int)iteration;

/*!
 @method calculateCentroidsWithClusters:clusters
 @abstract
 Re-calculate centroids of all clusters
 @param clusters
 Set of clusters which will have her centroid recalculate
 @discussion
 */
- (NSMutableArray *) calculateCentroidsWithClusters:(NSMutableArray *)clusters;

@end

@implementation KmeanCalculation

- (instancetype)initKmeanCalculationWithPathOfDataEntries:(NSString *)path andClusterCount:(int)clusterCount{
    self = [super init];
    if (self){
        _dataEntries = [KmeanEntryDataSet loadKmeanDatasetAtPath:path];
        _clusters = [[NSMutableArray alloc] init];
        _clusterCount = clusterCount;
        _centroids = [[NSMutableArray alloc] initWithCapacity:clusterCount];
        for (NSInteger i=0; i<_clusterCount; i++) {
            // may be check if an int can be negative. If it's posible make a codition tu put all value of dataIndex negative at 0
            int dataIndex = (_dataEntries.datacount / (int) (i+1) ) -1 ;
            //NSLog(@"factor: %d", dataIndex);
            [_centroids insertObject:[_dataEntries.data objectAtIndex:dataIndex] atIndex:i];
        }
    }
    return  self;
}

- (instancetype)initKmeanCalculationWithKmeanEntryDataSet:(KmeanEntryDataSet *)dataSet andClusterCount:(int)clusterCount {
    
    self = [super init];
    if (self){
        
        //_dataEntries = [dataSet mutableCopy];
        _dataEntries = dataSet;
        _clusters = [[NSMutableArray alloc] init];
        _clusterCount = clusterCount;
        _centroids = [[NSMutableArray alloc] initWithCapacity:clusterCount];
        for (NSInteger i=0; i<_clusterCount; i++) {
            // may be check if an int can be negative. If it's posible make a codition tu put all value of dataIndex negative at 0
            int dataIndex = (_dataEntries.datacount / (int) (i+1) ) -1 ;
            //NSLog(@"factor: %d", dataIndex);
            [_centroids insertObject:[_dataEntries.data objectAtIndex:dataIndex] atIndex:i];
            if(i == 0){
                [_centroids insertObject:[_dataEntries.data objectAtIndex:0] atIndex:i];
            }
            if (i == 1) {
                [_centroids insertObject:[_dataEntries.data objectAtIndex:_dataEntries.datacount-1] atIndex:i];
            }
        }
    }
    return  self;
    
}

- (NSMutableArray *) generateClusterWithIterration:(int)iteration{
    
    //Begin initialization of result
    NSMutableArray * clusterResult = [[NSMutableArray alloc] init];
    
    if (iteration ==0) {
        for (NSInteger c=0; c<_centroids.count; c++) {
            Cluster * clust = [[Cluster alloc] init];
            clust.center = [_centroids objectAtIndex:c];
            clust.countMember = 1;
            [clust.members insertObject:[_centroids objectAtIndex:c] atIndex:iteration];
            [clusterResult insertObject:clust atIndex:c];
            
        }
    }
    else{
        for (NSInteger c=0; c<_centroids.count; c++) {
            Cluster * clust = [[Cluster alloc] init];
            clust.center = [_centroids objectAtIndex:c];
            [clusterResult insertObject:clust atIndex:c];
        }
    }
    
    //End initialization of result
    int index_min_cluster = 100;
    for (NSInteger i=0; i< _dataEntries.datacount; i++) {
        double distance_point_to_cluster = MAXFLOAT;
        //NSLog(@"data[i]: %@", [_dataEntries.data objectAtIndex:i]);
        for (NSInteger j=0; j< _clusterCount; j++) {
            //double tmpDistance = [DistanceUtilities euclidianDistance2DBetweenFirstKmeanEntry:[_dataEntries.data objectAtIndex:i] andSecondKmeanEntry:((Cluster *)[clusterResult objectAtIndex:j]).center ];
            double tmpDistance = [DistanceUtilities euclidianDistance2DWithWeightForAccelerationBetweenFirstKmeanEntry:[_dataEntries.data objectAtIndex:i] andSecondKmeanEntry:((Cluster *)[clusterResult objectAtIndex:j]).center ];
            //NSLog(@"tmpDistance: %f and distance_point_to_cluster: %f",tmpDistance,distance_point_to_cluster);
            if (tmpDistance < distance_point_to_cluster) {
                distance_point_to_cluster = tmpDistance;
                index_min_cluster = (int) j;
                ((Cluster *)[clusterResult objectAtIndex:index_min_cluster]).center = (KmeanEntry *)[_centroids objectAtIndex:j];
            }
        }
        KmeanEntry * entry = ((KmeanEntry *)[_dataEntries.data objectAtIndex:i]);
        //NSLog(@"indexMinCluster: %d", index_min_cluster);
        [((Cluster *)[clusterResult objectAtIndex:index_min_cluster]).members insertObject:entry atIndex:((Cluster *)[clusterResult objectAtIndex:index_min_cluster]).countMember];
        
        ((Cluster *)[clusterResult objectAtIndex:index_min_cluster]).countMember++;
    }
    //NSLog(@"count: %lu", (long)clusterResult.count);
    return clusterResult;
}

- (NSMutableArray *) calculateCentroidsWithClusters:(NSMutableArray *)clusters {
    
    NSMutableArray * centroidResult = [[NSMutableArray alloc] init];
    
    for (NSInteger i=0; i<_clusterCount; i++) {
        KmeanEntry * newCenter = [[KmeanEntry alloc] init];
        for (NSInteger j=0; j<((Cluster*)[clusters objectAtIndex:i]).countMember; j++) {
            newCenter.time += ((KmeanEntry *)[((Cluster*)[clusters objectAtIndex:i]).members objectAtIndex:j]).time;
            newCenter.meanAcceleration += ((KmeanEntry *)[((Cluster*)[clusters objectAtIndex:i]).members objectAtIndex:j]).meanAcceleration;
            newCenter.maxAngle += ((KmeanEntry *)[((Cluster*)[clusters objectAtIndex:i]).members objectAtIndex:j]).maxAngle;
            newCenter.meanSpeed += ((KmeanEntry *)[((Cluster*)[clusters objectAtIndex:i]).members objectAtIndex:j]).meanSpeed;
        }
        //NSLog(@"countMember: %d", ((Cluster*)[clusters objectAtIndex:i]).countMember);
        newCenter.time = newCenter.time / ((Cluster*)[clusters objectAtIndex:i]).countMember;
        newCenter.meanAcceleration = newCenter.meanAcceleration / ((Cluster*)[clusters objectAtIndex:i]).countMember;
        newCenter.maxAngle = newCenter.maxAngle / ((Cluster*)[clusters objectAtIndex:i]).countMember;
        newCenter.meanSpeed = newCenter.meanSpeed / ((Cluster*)[clusters objectAtIndex:i]).countMember;
        
        [centroidResult insertObject:newCenter atIndex:i];
    }
    //_centroids = centroidResult;
    return centroidResult;
}

- (void)kmeanProcessWithMaxIteration:(int)maxIteration{
    
    NSMutableArray * clusterResult;
    int iteration =0;
    /*
     for(int z=0; z<_centroids.count; z++){
     NSLog(@"z: %lu and time centroid: %d and acc centroid: %lf", (long)z, [_centroids[z] time], [_centroids[z] meanAcceleration]);
     }
     */
    clusterResult = [self generateClusterWithIterration:iteration];
    iteration++;
    NSMutableArray * centroidResult = [self calculateCentroidsWithClusters:clusterResult];
    /*
     for(int z=0; z<centroidResult.count; z++){
     NSLog(@"z: %lu and time centroid: %d and acc centroid: %lf", (long)z, [centroidResult[z] time], [centroidResult[z] meanAcceleration]);
     }
     */
    Boolean centroidMoove = true;
    int countIteration=0;
    KmeanEntry * cumulMoveCentroid ;
    double meanMoveCentroidTime= 0., meanMoveCentroidMeanAcceleration = 0.;
    
    do{
        //NSLog(@"In kmean calculation");
        
        
        cumulMoveCentroid = [[KmeanEntry alloc]init];
        //NSLog(@"cumul before: %d", cumulMoveCentroid.time);
        for (NSInteger i=0; i<_clusterCount; i++) {
            //NSLog(@"%lu ,time: %d and time: %d" , (long)i,((KmeanEntry *)([centroidResult objectAtIndex:i])).time, ((KmeanEntry*)[_centroids objectAtIndex:i]).time);
            cumulMoveCentroid.time += ((KmeanEntry *)([centroidResult objectAtIndex:i])).time - ((KmeanEntry*)[_centroids objectAtIndex:i]).time ;
            
            cumulMoveCentroid.meanAcceleration += ((KmeanEntry *)([centroidResult objectAtIndex:i])).meanAcceleration - ((KmeanEntry*)[_centroids objectAtIndex:i]).meanAcceleration ;
        }
        //NSLog(@"cumul time after: %d and countCluster %d and %d", cumulMoveCentroid.time,_clusterCount,cumulMoveCentroid.time/_clusterCount);
        //NSLog(@"clustercount: %d", _clusterCount);
        meanMoveCentroidTime = cumulMoveCentroid.time/_clusterCount;
        meanMoveCentroidMeanAcceleration = cumulMoveCentroid.meanAcceleration/_clusterCount;
        //NSLog(@"time: %f ", meanMoveCentroidTime);
        //NSLog(@"acceleration: %f ", meanMoveCentroidMeanAcceleration);
        if (meanMoveCentroidTime == 0 && meanMoveCentroidMeanAcceleration==0) {
            _centroids = [centroidResult mutableCopy];
            /*
             for(int z=0; z<_centroids.count; z++){
             NSLog(@"z: %lu and time centroid: %d and acc centroid: %lf", (long)z, [_centroids[z] time], [_centroids[z] meanAcceleration]);
             }
             */
            clusterResult = [self generateClusterWithIterration:iteration];
            centroidResult = [self calculateCentroidsWithClusters:clusterResult];
            countIteration ++;
            if (countIteration == maxIteration) {
                centroidMoove = false;
            }
        }else{
            _centroids = [centroidResult mutableCopy];
            /*
             for(int z=0; z<_centroids.count; z++){
             NSLog(@"z: %lu and time centroid: %d and acc centroid: %lf", (long)z, [_centroids[z] time], [_centroids[z] meanAcceleration]);
             }
             */
            clusterResult = [self generateClusterWithIterration:iteration];
            centroidResult = [self calculateCentroidsWithClusters:clusterResult];
            countIteration=0;
        }
    }while (centroidMoove == true);
    _clusters = [clusterResult mutableCopy];
    //NSLog(@"countIteration: %d",countIteration);
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.dataEntries forKey:@"dataEntries"];
    [aCoder encodeObject:self.clusters forKey:@"clusters"];
    [aCoder encodeInt:self.clusterCount forKey:@"clusterCount"];
    [aCoder encodeObject:self.centroids forKey:@"centroids"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self)
    {
        _dataEntries = [aDecoder decodeObjectForKey:@"dataEntries"];
        _clusters = [aDecoder decodeObjectForKey:@"clusters"];
        _clusterCount = [aDecoder decodeIntForKey:@"clusterCount"];
        _centroids = [aDecoder decodeObjectForKey:@"centroids"];
    }
    
    return self;
}

- (void)writeKmeanCalculationAtPath:(NSString *)path
{
    [NSKeyedArchiver archiveRootObject:self toFile:path];
}

+ (id)loadKmeanCalculationAtPath:(NSString *)path
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

- (void)writeKmeanCalculationForTestAtPath:(NSString *)path{
    
    const char * pathChar = path.UTF8String;
    FILE* fichier = NULL;
    fichier = fopen(pathChar, "w+");
    if (fichier != NULL){
        
        for(int i=0; i< _clusterCount; i++){
            Cluster * currentCluster = (Cluster *)[_clusters objectAtIndex:i];
            KmeanEntry * currentCenter = [currentCluster center];
            NSMutableArray * currentMembers = [[currentCluster members] mutableCopy];
            NSString * lineCenter = [NSString stringWithFormat:@"%d %f %d %f center%d\n", currentCenter.time, currentCenter.meanAcceleration, currentCenter.maxAngle, currentCenter.meanSpeed, i];
            const char * lineCenterChar = lineCenter.UTF8String;
            fputs(lineCenterChar, fichier);
            for (int j=0; j<currentMembers.count; j++) {
                KmeanEntry * currentMember = [currentMembers objectAtIndex:j];
                NSString * lineMember = [NSString stringWithFormat:@"%d %f %d %f\n", currentMember.time, currentMember.meanAcceleration, currentMember.maxAngle, currentMember.meanSpeed ];
                const char * lineMemberChar = lineMember.UTF8String;
                fputs(lineMemberChar, fichier);
            }
        }
        
        fclose(fichier);
    }
    else{
        NSLog(@"Your file %@ does not exist",path);
    }
    
}

@end
