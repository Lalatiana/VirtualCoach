//
//  TrackingRelevantSequencesBuilderTest.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 14/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TrackingRelevantSequencesBuilder.h"

@interface TrackingRelevantSequencesBuilderTest : XCTestCase

@property (nonatomic) TrackingRelevantSequencesBuilder *builder;

@end

@implementation TrackingRelevantSequencesBuilderTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
}

- (void)testWithMotionFactor2
{
    NSArray *motions = @[@(0), @(-1), @(0), @(-1), @(0), @(-1), @(1), @(-1), @(0), @(-1), @(1), @(-1), @(0), @(-1), @(0), @(-1), @(0), @(-1), @(0), @(-1), @(0), @(-1), @(1), @(-1), @(1), @(-1), @(0), @(-1), @(1), @(-1), @(0), @(-1), @(1), @(-1), @(1), @(-1), @(0), @(-1), @(0), @(-1), @(1) ];
    
    NSArray *motionsExpectedResults = @[@(0), @(0), @(0), @(0), @(0), @(1), @(1), @(1), @(0), @(1), @(1), @(1), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(1), @(1), @(1), @(1), @(1), @(0), @(1), @(1), @(1), @(0), @(1), @(1), @(1), @(1), @(1), @(0), @(0), @(0), @(1), @(1) ];
    
    _builder = [[TrackingRelevantSequencesBuilder alloc] initWithPartialMotionArray:motions motionImageFactor:2];
    [_builder buildRelevantSequences];
    
    NSArray *motionResults = [_builder retreiveRelevantSequences];
    
    XCTAssertEqual([motionResults isEqualToArray:motionsExpectedResults], YES);
}

- (void)testWithMotionFactor5
{
    NSArray *motions = @[ @(0), @(-1), @(-1), @(-1), @(-1), @(0), @(-1), @(-1), @(-1), @(-1), @(1), @(-1), @(-1), @(-1), @(-1), @(1), @(-1), @(-1), @(-1), @(-1), @(0), @(-1), @(-1), @(-1), @(-1), @(1), @(-1), @(-1), @(-1), @(-1), @(0), @(-1), @(-1), @(-1), @(-1), @(0), @(-1), @(-1), @(-1), @(-1), @(1) ];
    
    NSArray *motionsExpectedResults = @[ @(0), @(0), @(0), @(0), @(0), @(0), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(0), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(0), @(0), @(0), @(0), @(0), @(0), @(1), @(1), @(1), @(1), @(1) ];
    
    _builder = [[TrackingRelevantSequencesBuilder alloc] initWithPartialMotionArray:motions motionImageFactor:5];
    [_builder buildRelevantSequences];
    
    NSArray *motionResults = [_builder retreiveRelevantSequences];
    
    XCTAssertEqual([motionResults isEqualToArray:motionsExpectedResults], YES);
}

- (void)testWithMotionFactor10
{
    NSArray *motions = @[ @(0), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(0), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(0) ];
    
    NSArray *motionsExpectedResults = @[ @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(0) ];
    
    _builder = [[TrackingRelevantSequencesBuilder alloc] initWithPartialMotionArray:motions motionImageFactor:10];
    [_builder buildRelevantSequences];
    
    NSArray *motionResults = [_builder retreiveRelevantSequences];
    
    XCTAssertEqual([motionResults isEqualToArray:motionsExpectedResults], YES);
}

- (void)testWithLostObject
{
    NSArray *motions = @[ @(0), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-2), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-2), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(1) ];
    
    NSArray *motionsExpectedResults = @[ @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(-2), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(-2), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1) ];
    
    _builder = [[TrackingRelevantSequencesBuilder alloc] initWithPartialMotionArray:motions motionImageFactor:10];
    [_builder buildRelevantSequences];
    
    NSArray *motionResults = [_builder retreiveRelevantSequences];
    
    XCTAssertEqual([motionResults isEqualToArray:motionsExpectedResults], YES);
}

@end
