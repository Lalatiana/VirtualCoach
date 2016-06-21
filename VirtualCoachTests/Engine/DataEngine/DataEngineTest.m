//
//  DataEngineTest.m
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 16/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DatabaseService.h"
#import "CoachDataEngine.h"
#import "CoachDO.h"
#import "CheckDatabaseDAO.h"

@interface DataEngineTest : XCTestCase

@property (nonatomic) NSString * databasePath;
@property (nonatomic) CoachDataEngine *coachDE;
@property (nonatomic) CoachDO *coachDO1;
@property (nonatomic) CoachDO *coachDO2;
@property (nonatomic) CheckDatabaseDAO *checkDB;
@property (nonatomic) NSString * sqlPath;

@end

@implementation DataEngineTest

- (void)setUp {
    [super setUp];
    NSLog(@"\n\n\n\n\n\n\n\n");
    NSLog(@"TEST SETUP");
    NSLog(@"\n\n\n\n\n\n\n\n");
    _databasePath  = [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingString:@"/Database/DatabaseTest.db"];
    NSLog(@"\n\n\n\n\n");
    NSLog(@"databasePath: %@", _databasePath);
    NSLog(@"\n\n\n\n\n");
    [DatabaseService initWithFile:_databasePath];
    
    _sqlPath = [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingString:@"/Database/CreationTablesTest.sql"];
    NSLog(@"\n\n\n\n\n");
    NSLog(@"sqlPath: %@", _sqlPath);
    NSLog(@"\n\n\n\n\n");
    
    _coachDE = [[CoachDataEngine alloc] init];
    _coachDO1 = [[CoachDO alloc]init];
    _coachDO2 = [[CoachDO alloc]init];
    _checkDB = [[CheckDatabaseDAO alloc]init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCoachDataEngine {
    /**************************************************DROP TABLES*****************************************************/
    int rep = [DatabaseService sqlFile:[[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingString:@"/Database/DropTables.sql"]];
    
    NSLog(@"REP:%d", rep);
    
    XCTAssertEqual(rep, 0);
    /***********************test checking database and/or creating tables**************/
    int check = [_checkDB CheckingDatabase: _databasePath andScriptCreationPath: _sqlPath];
    
    NSLog(@"CHECK: %d", check);
    
    /********************************************INSERT*************************************************************/
    _coachDO1.name = @"Adrien";
    _coachDO1.firstName = @"LESUR";
    _coachDO1.login = @"lesura";
    _coachDO1.password = @"adidi";
    _coachDO1.leftHanded = YES;
    
    
     NSNumber *insertCoachDE1 = (NSNumber *)[_coachDE insertCoach:_coachDO1];
    
    NSLog(@"testDE1 insert\n\n\n\n\n");
    NSLog(@"%@",insertCoachDE1);
    NSLog(@"\n\n\n\n\n");
    
     XCTAssertEqual([insertCoachDE1 boolValue],YES );
    
    _coachDO2.name = @"Lala";
    _coachDO2.firstName = @"RAK";
    _coachDO2.login = @"rakotoml";
    _coachDO2.password = @"lrak";
    _coachDO2.leftHanded = YES;
    
   
    NSNumber *insertCoachDE2 = (NSNumber *)[_coachDE insertCoach:_coachDO2];
    

    NSLog(@"testDE2 insert\n\n\n\n\n");
    NSLog(@"%@",insertCoachDE2);
     NSLog(@"\n\n\n\n\n");

    XCTAssertEqual([insertCoachDE2 boolValue],YES );
    
    /********************************************SELECT*************************************************************/
    NSMutableArray *selectCoachDE = [_coachDE selectAllCoaches];
     NSLog(@"testDE select\n\n\n\n\n");
    
    CoachDO *coach = [selectCoachDE objectAtIndex:1];
    NSLog(@"testDE select\n\n\n\n\n");
    NSLog(@"Name1:%@",coach.name);
    NSLog(@"\n\n\n\n\n");
    XCTAssertEqualObjects(@"Lala", coach.name);
    
    NSMutableArray *selectAllCoach = [_coachDE selectOnlyAllCoaches];
    
    CoachDO *coach2 = [selectAllCoach objectAtIndex:2];
   
    NSLog(@"testDE2 select\n\n\n\n\n");
    NSLog(@"Name2:%@",coach2.name);
    NSLog(@"\n\n\n\n\n");
    XCTAssertEqualObjects(@"Adrien", coach2.name);
    
    
    /********************************************DELETE*************************************************************/
    NSNumber *delete = (NSNumber *) [_coachDE deleteCoachById:coach.coachId];
    
    XCTAssertEqual([delete boolValue],YES );
    
    NSNumber *delete2 = (NSNumber *) [_coachDE deleteCoachById:coach2.coachId];
    
    XCTAssertEqual([delete2 boolValue],YES );
}

@end
