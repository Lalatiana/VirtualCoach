//
//  Histogram.h
//  VirtualCoach
//
//  Created by Bi ZORO on 02/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <geometry.h>
#include <core.h>

//#define THRESHOLD_HISTOGRAM 0.000005
//#define THRESHOLD_NORM_SPEED_VECTORS 0.000005

#define THRESHOLD_HISTOGRAM 0.0
#define THRESHOLD_NORM_SPEED_VECTORS 0.0

@interface Histogram : NSObject <NSCoding>

@property (nonatomic) NSMutableArray * data;

/*!
 @method generateHistogramFromSpeedVector:speed betweenInterval:interval andWithImageWidth:width
 @abstract
 Creates a Histogram of angles. This method updates the hits of each angle considering the set of speed interesting pixels
 @param speed
 Set of speed of pixel generate by the optical flow algorithm
 @param interval
 Interval of speed of pixel looked upon as interesting
 @param width
 Width of image using to generate speed of each pixel
 @discussion
 */

- (void)generateHistogramFromSpeedVector:(vect2darray_t *)speed betweenInterval:(rect_t)interval andWithImageWidth:(uint16_t)width;


/*!
 @method writeHistogramAtPath:path
 @abstract
 Creates a file which stock the histogram of angles
 @param path
 Path use to write the file
 @discussion
 */
- (void)writeHistogramAtPath:(NSString *)path;

/*!
 @method loadHistogramAtPath:path
 @abstract
 Creates a histogram of angles by loading data from file
 @param path
 Path use to write the file
 @discussion
 */
+ (id)loadHistogramAtPath:(NSString *)path;

- (void)writeHistogramForTestAtPath:(NSString *)path;



@end
