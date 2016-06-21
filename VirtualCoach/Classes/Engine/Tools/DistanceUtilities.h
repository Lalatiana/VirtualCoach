//
//  DistanceUtilities.h
//  VirtualCoach
//
//  Created by Bi ZORO on 15/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KmeanEntry.h"

@interface DistanceUtilities : NSObject

+ (double) euclidianDistance2DBetweenFirstKmeanEntry:(KmeanEntry *)firstPoint andSecondKmeanEntry:(KmeanEntry *)secondPoint;
+ (double) euclidianDistance2DWithWeightForAccelerationBetweenFirstKmeanEntry:(KmeanEntry *)firstPoint andSecondKmeanEntry:(KmeanEntry *)secondPoint;


+ (double) euclidianDistance3DBetweenFirstKmeanEntry:(KmeanEntry *)firstPoint andSecondKmeanEntry:(KmeanEntry *)secondPoint;
+ (double) euclidianDistance3DWithWeightForAccelerationBetweenFirstKmeanEntry:(KmeanEntry *)firstPoint andSecondKmeanEntry:(KmeanEntry *)secondPoint;

+ (double) manhattanDistance2DBetweenFirstKmeanEntry:(KmeanEntry *)firstPoint andSecondKmeanEntry:(KmeanEntry *)secondPoint;
+ (double) manhattanDistance3DBetweenFirstKmeanEntry:(KmeanEntry *)firstPoint andSecondKmeanEntry:(KmeanEntry *)secondPoint;

@end
