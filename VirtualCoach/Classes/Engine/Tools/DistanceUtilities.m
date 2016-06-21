//
//  DistanceUtilities.m
//  VirtualCoach
//
//  Created by Bi ZORO on 15/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "DistanceUtilities.h"

@implementation DistanceUtilities

+ (double) euclidianDistance2DBetweenFirstKmeanEntry:(KmeanEntry *)firstPoint andSecondKmeanEntry:(KmeanEntry *)secondPoint{
    double result=0;
    result = sqrt(pow((secondPoint.time-firstPoint.time),2)+pow((secondPoint.meanAcceleration-firstPoint.meanAcceleration),2));
    return result;
}

+ (double) euclidianDistance2DWithWeightForAccelerationBetweenFirstKmeanEntry:(KmeanEntry *)firstPoint andSecondKmeanEntry:(KmeanEntry *)secondPoint{
    
    double result=0;
    int weightForAcceleration = 1000;
    result = sqrt( (weightForAcceleration * pow((secondPoint.time-firstPoint.time),2) )+ ((1/1000000) * pow((secondPoint.meanAcceleration-firstPoint.meanAcceleration),2)));
    return result;
    
}

+ (double) euclidianDistance3DBetweenFirstKmeanEntry:(KmeanEntry *)firstPoint andSecondKmeanEntry:(KmeanEntry *)secondPoint{
    double result=0;
    result = sqrt(pow((secondPoint.time-firstPoint.time),2)+pow((secondPoint.meanAcceleration-firstPoint.meanAcceleration),2)+pow((secondPoint.maxAngle-firstPoint.maxAngle),2));
    return result;
}

+ (double) euclidianDistance3DWithWeightForAccelerationBetweenFirstKmeanEntry:(KmeanEntry *)firstPoint andSecondKmeanEntry:(KmeanEntry *)secondPoint{
    
    double result=0;
    int weightForAcceleration = 1000;
    result = sqrt( (weightForAcceleration * pow((secondPoint.time-firstPoint.time),2) )+pow((secondPoint.meanAcceleration-firstPoint.meanAcceleration),2)+pow((secondPoint.maxAngle-firstPoint.maxAngle),2));
    return result;
    
}

+ (double) manhattanDistance2DBetweenFirstKmeanEntry:(KmeanEntry *)firstPoint andSecondKmeanEntry:(KmeanEntry *)secondPoint{
    double result=0;
    result = fabs( (secondPoint.time-firstPoint.time)+(secondPoint.meanAcceleration-firstPoint.meanAcceleration) );
    return result;
}

+ (double) manhattanDistance3DBetweenFirstKmeanEntry:(KmeanEntry *)firstPoint andSecondKmeanEntry:(KmeanEntry *)secondPoint{
    double result=0;
    result = fabs((secondPoint.time-firstPoint.time)+(secondPoint.meanAcceleration-firstPoint.meanAcceleration)+(secondPoint.maxAngle-firstPoint.maxAngle));
    return result;
}

@end
