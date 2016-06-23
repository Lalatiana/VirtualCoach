//
//  InitDatabaseTest.m
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 09/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DatabaseService.h"
#import "CoachDAO.h"
#import "PlayerDAO.h"
#import "StatisticalDAO.h"
#import "TrainingDAO.h"
#import "VideoDAO.h"
#import "MovementDAO.h"
#import "TrophyDAO.h"
#import "CoachPlayerDAO.h"
#import "PlayerTrophyDAO.h"
#import "PlayerTrainingVideoDAO.h"
#import "MovementReferenceDAO.h"
#import "VideoReferenceDAO.h"
#import "CheckDatabaseDAO.h"

@interface DatabaseTest : XCTestCase

@property (nonatomic) DatabaseService *database;
@property (nonatomic) CoachDAO *coach;
@property (nonatomic) PlayerDAO *player;
@property (nonatomic) StatisticalDAO *stat;
@property (nonatomic) TrainingDAO *train;
@property (nonatomic) VideoDAO *video;
@property (nonatomic) MovementDAO *mvt;
@property (nonatomic) TrophyDAO *trophy;
@property (nonatomic) CoachPlayerDAO *coachPlayer;
@property (nonatomic) PlayerTrophyDAO *playerTrophy;
@property (nonatomic) PlayerTrainingVideoDAO *ptv;
@property (nonatomic) MovementReferenceDAO *mvtRef;
@property (nonatomic) VideoReferenceDAO *videoRef;
@property (nonatomic) CheckDatabaseDAO *checkDB;
@property (nonatomic) NSString * databasePath;
@property (nonatomic) NSString * sqlPath;

@end

@implementation DatabaseTest

- (void)setUp {
    [super setUp];
    _databasePath  = [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingString:@"/Database/DatabaseTest.db"];
    NSLog(@"\n\n\n\n\n");
    NSLog(@"databasePath: %@", _databasePath);
    NSLog(@"\n\n\n\n\n");
    [DatabaseService initWithFile:_databasePath];
    
    _sqlPath = [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingString:@"/Database/CreationTablesTest.sql"];
    NSLog(@"\n\n\n\n\n");
    NSLog(@"sqlPath: %@", _sqlPath);
    NSLog(@"\n\n\n\n\n");
    
    _coach = [[CoachDAO alloc] init];
    _player = [[PlayerDAO alloc] init];
    _stat = [[StatisticalDAO alloc] init];
    _train = [[TrainingDAO alloc] init];
    _video = [[VideoDAO alloc] init];
    _mvt = [[MovementDAO alloc] init];
    _trophy = [[TrophyDAO alloc] init];
    _coachPlayer = [[CoachPlayerDAO alloc] init];
    _playerTrophy = [[PlayerTrophyDAO alloc] init];
    _ptv = [[PlayerTrainingVideoDAO alloc] init];
    _mvtRef = [[MovementReferenceDAO alloc] init];
    _videoRef = [[VideoReferenceDAO alloc] init];
    _checkDB = [[CheckDatabaseDAO alloc]init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [DatabaseService close];
    [super tearDown];
}

-(void)testAllDAO{
    /**************************************************DROP TABLES*****************************************************/
    int rep = [DatabaseService sqlFile:[[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingString:@"/Database/DropTables.sql"]];
    
    NSLog(@"REP:%d", rep);
    
    XCTAssertEqual(rep, 0);
    /***********************test checking database and/or creating tables**************/
    int check = [_checkDB CheckingDatabase: _databasePath andScriptCreationPath: _sqlPath];
    
    NSLog(@"CHECK: %d", check);
    // XCTAssertEqual(check,2);
    
    /*********************************************TEST COACH*********************************************************/
    //insert coach
    NSNumber *insertCoach = (NSNumber *)[_coach insertIntoCoach:@"RAK" firstName:@"Lala" leftHanded:@"0" login:@"lrak" password:@"lrakotom"];
    
    XCTAssertEqual([insertCoach boolValue],YES );
    
    NSNumber *insertCoach1 = (NSNumber *)[_coach insertIntoCoach:@"DUBREUCQ" firstName:@"Romain" leftHanded:@"1" login:@"drom" password:@"dromain"];
    
    XCTAssertEqual([insertCoach1 boolValue],YES );
    
    //show all coaches
    NSArray *coaches = [_coach allCoaches];
    
    NSLog(@"%@", coaches);
    
    XCTAssertEqualObjects(@"RAK", coaches[1][0]);
    XCTAssertEqualObjects(@"Lala", coaches[2][0]);
    
    //search coach's id
    NSArray* coach = [_coach searchByLogin:@"lrak" password:@"lrakotom"];
    XCTAssertEqual(1, [coach[0] count]);
    int coachId = [[[coach objectAtIndex:0] objectAtIndex:0] intValue];
    NSString *idC = [NSString stringWithFormat:@"%d", coachId];
    NSLog(@"IDCOACH: %@", idC);
    XCTAssertEqual(1, coachId);
    
    NSArray* coach1 = [_coach searchByLogin:@"drom" password:@"dromain"];
    XCTAssertEqual(1, [coach1[0] count]);
    int coachId1 = [[[coach1 objectAtIndex:0] objectAtIndex:0] intValue];
    NSString *idC1 = [NSString stringWithFormat:@"%d",coachId1];
    NSLog(@"IDCOACH: %@", idC1);
    XCTAssertEqual(2, coachId1);
    
    /*********************************************TEST PLAYER*********************************************************/
    //insert player
    NSNumber *insertPlayer = (NSNumber *) [_player insertIntoPlayer:@"LESUR" firstName:@"Adrien" leftHanded:@"1" level:@"intermediaire"];
    
    XCTAssertEqual([insertPlayer boolValue],YES );
    
    NSNumber *insertPlayer1 = (NSNumber *) [_player insertIntoPlayer:@"ZORO" firstName:@"JD" leftHanded:@"0" level:@"intermediaire"];
    
    XCTAssertEqual([insertPlayer1 boolValue],YES );
    
    NSNumber *insertPlayer2 = (NSNumber *) [_player insertIntoPlayer:@"TAPIN" firstName:@"Fred" leftHanded:@"1" level:@"debutant"];
    
    XCTAssertEqual([insertPlayer2 boolValue],YES );
    
    NSNumber *insertPlayer3 = (NSNumber *) [_player insertIntoPlayer:@"CLAVELLE" firstName:@"Stanley" leftHanded:@"1" level:@"debutant"];
    
    XCTAssertEqual([insertPlayer3 boolValue],YES );
    
    //show all players
    NSArray *players = [_player allPlayers];
    
    NSLog(@"%@", players);
    
    XCTAssertEqualObjects(@"LESUR", players[1][0]);
    XCTAssertEqualObjects(@"Adrien", players[2][0]);
    
    //search player's id
    int idPlayer = [_player searchIdByName:@"LESUR" firstName:@"Adrien" ];
    NSString *idP = [NSString stringWithFormat:@"%d",idPlayer];
    NSLog(@"IDPLAYER: %@", idP);
    XCTAssertEqual(1, idPlayer);
    
    int idPlayer1 = [_player searchIdByName:@"ZORO" firstName:@"JD" ];
    NSString *idP1 = [NSString stringWithFormat:@"%d",idPlayer1];
    NSLog(@"IDPLAYER1: %@", idP1);
    XCTAssertEqual(2, idPlayer1);
    
    int idPlayer2 = [_player searchIdByName:@"TAPIN" firstName:@"Fred" ];
    NSString *idP2 = [NSString stringWithFormat:@"%d",idPlayer2];
    NSLog(@"IDPLAYER1: %@", idP2);
    XCTAssertEqual(3, idPlayer2);
    
    int idPlayer3 = [_player searchIdByName:@"CLAVELLE" firstName:@"Stanley" ];
    NSString *idP3 = [NSString stringWithFormat:@"%d",idPlayer3];
    NSLog(@"IDPLAYER1: %@", idP3);
    XCTAssertEqual(4, idPlayer3);
    
    //search player by id
    NSArray *player = [_player searchPlayerById:idP];
    
    NSLog(@"%@", player);
    
    XCTAssertEqualObjects(@"LESUR", player[1][0]);
    
    /*********************************************TEST CoachPlayer*********************************************************/
    
    //insert coachplayer
    NSNumber *insertCoachPlayer = (NSNumber *) [_coachPlayer insertIntoCoach_Player:idC id_player:idP];
    
    XCTAssertEqual([insertCoachPlayer boolValue],YES );
    
    NSNumber *insertCoachPlayer1 = (NSNumber *) [_coachPlayer insertIntoCoach_Player:idC id_player:idP1];
    
    XCTAssertEqual([insertCoachPlayer1 boolValue],YES );
    
    NSNumber *insertCoachPlayer2 = (NSNumber *) [_coachPlayer insertIntoCoach_Player:idC1 id_player:idP2];
    
    XCTAssertEqual([insertCoachPlayer2 boolValue],YES );
    
    NSNumber *insertCoachPlayer3 = (NSNumber *) [_coachPlayer insertIntoCoach_Player:idC1 id_player:idP3];
    
    XCTAssertEqual([insertCoachPlayer3 boolValue],YES );
    
    //search coachplayer's id
    int idCoachPlayer = [_coachPlayer searchIdByCoach:idC andPlayer:idP];
    NSString *idCP = [NSString stringWithFormat:@"%d",idCoachPlayer];
    
    XCTAssertEqual(1, idCoachPlayer);
    
    //search idPlayer
    NSArray *idPlayers = [_coachPlayer searchIdPlayersByCoach:idC];
    
    NSLog(@"IDPLAYERS: %@", idPlayers);
    
    
    XCTAssertEqual(1, [idPlayers[0][0] integerValue]);
    
    /*********************************************TEST VideoReference*******************************************************/
    //insert videoref
    NSNumber *insertVideoRef = (NSNumber *) [_videoRef insertIntoVideoReference:@"/path/ppath/test1" processed:@"0" removed:@"1" day:@"29" month:@"5" year:@"2016" idCoach:idC];
    
    XCTAssertEqual([insertVideoRef boolValue],YES );
    
    //show all videoRef
    NSArray *videorefs = [_videoRef allVideoRef];
    
    NSLog(@"%@", videorefs);
    
    XCTAssertEqualObjects(@"/path/ppath/test1", videorefs[1][0]);
    
    //search
    NSArray *VideoRef1 = [_videoRef searchVideoRefByMonth:@"5" andYear:@"2016"];
    
    NSLog(@"%@", VideoRef1);
    
    XCTAssertEqualObjects(@"/path/ppath/test1", VideoRef1[1][0]);
    
    NSArray *VideoRef2 = [_videoRef searchVideoRefByDay:@"29" Month:@"5" andYear:@"2016"];
    
    NSLog(@"%@", VideoRef2);
    
    XCTAssertEqualObjects(@"/path/ppath/test1", VideoRef2[1][0]);
    
    NSArray *onevideo = [_videoRef searchVideoRefByIdCoach:idC];
    
    NSLog(@"ONEVIDEO: %@", onevideo);
    
    XCTAssertEqualObjects(@"/path/ppath/test1", onevideo[1][0]);
    
    //search viedeoRef's id
    int idVideoRef1 = [_videoRef searchIdVideoRefByName:@"/path/ppath/test1" Removed:@"1"];
    NSString *idVR1 = [NSString stringWithFormat:@"%d",idVideoRef1];
    
    XCTAssertEqual(1, idVideoRef1);
    
    int idVideoRef2 = [_videoRef searchIdVideoRefByName:@"/path/ppath/test1" Processed:@"0"];
    //NSString *idVR2 = [NSString stringWithFormat:@"%d",idVideoRef2];
    
    XCTAssertEqual(1, idVideoRef2);
    
    /*********************************************TEST MovementReference******************************************************/
    //insert MovementRef
    NSNumber *insertMovementRef = (NSNumber *) [_mvtRef insertIntoMovementReference:@"backhand" path:@"/path/path1/mvt1" id_video:idVR1];
    
    XCTAssertEqual([insertMovementRef boolValue],YES );
    
    //show all movements ref
    NSArray *movementsref = [_mvtRef allMovementRef];
    
    NSLog(@"%@", movementsref);
    NSString *idmvtRef = [[[movementsref objectAtIndex:0] objectAtIndex:0] stringValue];
    
    XCTAssertEqualObjects(@"backhand", movementsref[1][0]);
    
    //search
    NSArray *mvtref1 = [_mvtRef searchByIdVideoRef:idVR1];
    
    NSLog(@"%@", mvtref1);
    
    XCTAssertEqualObjects(@"/path/path1/mvt1" , mvtref1[2][0]);
    
    NSArray *mvtref2 = [_mvtRef searchByIdVideoRef:idVR1 Type:@"backhand"];
    
    NSLog(@"%@", mvtref2);
    
    XCTAssertEqualObjects(@"backhand" , mvtref2[1][0]);
    
    /*********************************************TEST Video*******************************************************/
    //insert video
    NSNumber *insertVideo = (NSNumber *) [_video insertIntoVideo:@"/A/B/v1" processed:@"1" removed:@"1" day:@"29" month:@"05" year:@"2016"];
    
    XCTAssertEqual([insertVideo boolValue],YES );
    
    NSNumber *insertVideo1 = (NSNumber *) [_video insertIntoVideo:@"/A/B/v2" processed:@"0" removed:@"1" day:@"31" month:@"05" year:@"2016"];
    
    XCTAssertEqual([insertVideo1 boolValue],YES );
    
    NSNumber *insertVideo2 = (NSNumber *) [_video insertIntoVideo:@"/A/B/v3" processed:@"0" removed:@"0" day:@"31" month:@"05" year:@"2016"];
    
    XCTAssertEqual([insertVideo2 boolValue],YES );
    
    //show all video
    NSArray *videos = [_video allVideo];
    
    NSLog(@"Videos before:%@", videos);
    
    XCTAssertEqualObjects(@"/A/B/v1", videos[1][0]);
    
    //search
    NSArray *Video1 = [_video searchVideoByDay:@"29" Month:@"05" andYear:@"2016"];
    
    NSLog(@"%@", Video1);
    
    XCTAssertEqualObjects(@"/A/B/v1", Video1[1][0]);
    
    NSArray *Video2 = [_video searchVideoByMonth:@"05" andYear:@"2016"];
    
    NSLog(@"%@", Video2);
    
    XCTAssertEqualObjects(@"1", [[[Video2 objectAtIndex:2] objectAtIndex:0] stringValue]);
    
    //search viedeoRef's id
    int idVideo1 = [_video searchIdVideoByName:@"/A/B/v1" Processed:@"1"] ;
    //NSString *idV1 = [NSString stringWithFormat:@"%d",idVideo1];
    
    XCTAssertEqual(1, idVideo1);
    
    int idVideo2 = [_video searchIdVideoByName:@"/A/B/v1" Removed:@"1"];
    NSString *idV2 = [NSString stringWithFormat:@"%d",idVideo2];
    
    XCTAssertEqual(1, idVideo2);
    
    int idVideo3 = [_video searchIdVideoByName:@"/A/B/v2" Removed:@"1"];
    NSString *idV3 = [NSString stringWithFormat:@"%d",idVideo3];
    
    XCTAssertEqual(2, idVideo3);
    
    int idVideo4 = [_video searchIdVideoByName:@"/A/B/v3" Removed:@"0"];
    NSString *idV4 = [NSString stringWithFormat:@"%d",idVideo4];
    
    XCTAssertEqual(3, idVideo4);
    
    //update
    NSNumber *updateProcess = [_video updatedVideoProcessing:@"0" byName:@"/A/B/v1"];
    XCTAssertEqual([updateProcess boolValue],YES );
    
    NSNumber *updateRemoved = [_video updatedVideoRemoving:@"1" byName:@"/A/B/v3"];
     XCTAssertEqual([updateRemoved boolValue],YES );
    
    NSArray *videos1 = [_video allVideo];
    
    NSLog(@"Videos after:%@", videos1);
    /*********************************************TEST Movement******************************************************/
    //insert Movement
    NSNumber *insertMovement = (NSNumber *) [_mvt insertIntoMovement:@"forehand" winner:@"1" losing:@"0" success_rate:@"20%" id_video:idV2];
    
    XCTAssertEqual([insertMovement boolValue],YES );
    
    //show all movements
    NSArray *movements = [_mvt allMovement];
    
    NSLog(@"%@", movements);
    NSString *idmvt = [[[movements objectAtIndex:0] objectAtIndex:0] stringValue];;
    
    XCTAssertEqualObjects(@"forehand", movements[1][0]);
    
    //search
    NSArray *mvt1 = [_mvt searchByIdVideo:idV2 Type:@"forehand"];
    
    NSLog(@"%@", mvt1);
    
    XCTAssertEqualObjects(@"1" ,[[[mvt1 objectAtIndex:2] objectAtIndex:0] stringValue]);
    
    NSArray *mvt2 = [_mvt searchByIdVideo:idV2];
    
    NSLog(@"%@", mvt2);
    
    XCTAssertEqualObjects(@"forehand" , mvt2[1][0]);
    
    /*********************************************TEST Training******************************************************/
    //insert Training
    NSNumber *insertTraining = (NSNumber *) [_train insertIntoTraining:@"29/05/2016" name:@"train forehand" place:@"gymnase1"];
    
    XCTAssertEqual([insertTraining boolValue],YES );
    
    NSNumber *insertTraining1 = (NSNumber *) [_train insertIntoTraining:@"31/05/2016" name:@"train2" place:@"gymnase1"];
    
    XCTAssertEqual([insertTraining1 boolValue],YES );
    
    NSNumber *insertTraining2 = (NSNumber *) [_train insertIntoTraining:@"31/05/2016" name:@"train3" place:@"gymnase1"];
    
    XCTAssertEqual([insertTraining2 boolValue],YES );
    
    //show all trainings
    NSArray *trainings = [_train allTraining];
    
    NSLog(@"%@", trainings);
    
    XCTAssertEqualObjects(@"29/05/2016", trainings[1][0]);
    
    //search training's id
    NSArray *Train1 = [_train searchByDate:@"29/05/2016"] ;
    
    int idT1 = [Train1[0][0] intValue];
    //NSString *idST1 = [NSString stringWithFormat:@"%d",idT1];
    
    XCTAssertEqual(1, idT1);
    
    NSArray *Train2 = [_train searchByDate:@"29/05/2016" Name:@"train forehand" Andplace:@"gymnase1"];
    
    int idT2 = [Train2[0][0] intValue];
    NSString *idST2 = [NSString stringWithFormat:@"%d",idT2];
    
    XCTAssertEqual(1,idT2 );
    
    NSArray *Train3 = [_train searchByDate:@"31/05/2016" Name:@"train2" Andplace:@"gymnase1"];
    
    int idT3 = [Train3[0][0] intValue];
    NSString *idST3 = [NSString stringWithFormat:@"%d",idT3];
    
    XCTAssertEqual(2, idT3);
    
    NSArray *Train4 = [_train searchByDate:@"31/05/2016" Name:@"train3" Andplace:@"gymnase1"];
    
    int idT4 = [Train4[0][0] intValue];
    NSString *idST4 = [NSString stringWithFormat:@"%d",idT4];
    
    XCTAssertEqual(3, idT4);
    
    /*********************************************TEST PlayerTrainingVideo****************************************************/
    //insert PTV
    NSNumber *insertPTV = (NSNumber *) [_ptv insertIntoPlayer_Training_Video:idP id_training:idST2 id_video:idV2];
    
    XCTAssertEqual([insertPTV boolValue],YES );
    
    NSNumber *insertPTV1 = (NSNumber *) [_ptv insertIntoPlayer_Training_Video:idP1 id_training:idST3 id_video:idV3];
    
    XCTAssertEqual([insertPTV1 boolValue],YES );
    
    NSNumber *insertPTV2 = (NSNumber *) [_ptv insertIntoPlayer_Training_Video:idP2 id_training:idST4 id_video:idV4];
    
    XCTAssertEqual([insertPTV2 boolValue],YES );
    
    //search PTV's id
    int idPTV = [_ptv searchIdByPlayer:idP andTraining:idST2 andVideo:idV2] ;
    NSString *idPTV1 = [NSString stringWithFormat:@"%d",idPTV];
    
    XCTAssertEqual(1, idPTV);
    
    /*********************************************TEST Statistical****************************************************/
    //insert stat
    NSNumber *insertStat = (NSNumber *) [_stat insertIntoStatistical:@"5" backhanh:@"7" service:@"4" winningRun:@"2" losingRun:@"1" globalSuccessRateForehand:@"0.20" globalSuccessRateBackhand:@"0.35" globalSuccessRateService:@"0.50" day:@"29" month:@"05" year:@"2016" idPlayer:idP];
    
    [_stat insertIntoStatistical:@"2" backhanh:@"3" service:@"4" winningRun:@"2" losingRun:@"1" globalSuccessRateForehand:@"0.20" globalSuccessRateBackhand:@"0.35" globalSuccessRateService:@"0.50" day:@"02" month:@"06" year:@"2016" idPlayer:idP];
    
    [_stat insertIntoStatistical:@"6" backhanh:@"3" service:@"1" winningRun:@"2" losingRun:@"1" globalSuccessRateForehand:@"0.56" globalSuccessRateBackhand:@"0.35" globalSuccessRateService:@"0.60" day:@"28" month:@"12" year:@"2016" idPlayer:idP];
    
    [_stat insertIntoStatistical:@"1" backhanh:@"3" service:@"1" winningRun:@"2" losingRun:@"1" globalSuccessRateForehand:@"0.23" globalSuccessRateBackhand:@"0.45" globalSuccessRateService:@"0.89" day:@"02" month:@"01" year:@"2017" idPlayer:idP];
    
    [_stat insertIntoStatistical:@"13" backhanh:@"12" service:@"9" winningRun:@"2" losingRun:@"1" globalSuccessRateForehand:@"0.23" globalSuccessRateBackhand:@"0.45" globalSuccessRateService:@"0.89" day:@"04" month:@"01" year:@"2017" idPlayer:idP];
    
    XCTAssertEqual([insertStat boolValue],YES );
    
    //show all stats
    NSArray *stats = [_stat allStatistical];
    
    NSLog(@"stats:%@", stats);
    NSString *idstat = [[[stats objectAtIndex:0] objectAtIndex:0] stringValue];
    
    XCTAssertEqual([[NSNumber numberWithFloat:0.2] floatValue], [[[stats objectAtIndex:6] objectAtIndex:0] floatValue]);
    
    //search
    NSArray *stat1 = [_stat searchByMonth:@"05" Andyear:@"2016" andIdPlayer:idP];
    
    NSLog(@"stat1:%@", stat1);
    
    XCTAssertEqualObjects(@"5", [[[stat1 objectAtIndex:1] objectAtIndex:0] stringValue]);
    
    NSArray *stat2 = [_stat searchByYear:@"2016" andIdPlayer:idP];
    
    NSLog(@"stat2:%@", stat2);
    
    XCTAssertEqualObjects(@"7", [[[stat2 objectAtIndex:2] objectAtIndex:0] stringValue]);
    
    NSArray *stat3 = [_stat searchByDay:@"29" Month:@"05" Andyear:@"2016" andIdPlayer:idP];
    
    NSLog(@"stat3:%@", stat3);
    
    XCTAssertEqualObjects(@"4",[[[stat3 objectAtIndex:3] objectAtIndex:0] stringValue]);
    
    NSArray *statis = [_stat searchByIdPlayer:idP];
    
    NSLog(@"STAT:%@", statis);
    
    XCTAssertEqualObjects(@"1",[[[statis objectAtIndex:12] objectAtIndex:0] stringValue]);
    
    NSArray* result = [_stat searchFromDay:@"20" andMonth:@"05" andYear:@"2016" toDay:@"10" andMonth:@"06" andYear:@"2016" forPlayerId:idP];
    
    XCTAssertEqual(2, [result[0] count]);
    
    result = [_stat searchFromDay:@"25" andMonth:@"12" andYear:@"2016" toDay:@"12" andMonth:@"1" andYear:@"2017" forPlayerId:idP];
    
    XCTAssertEqual(3, [result[0] count]);
    
    //update
    NSNumber *updateServiceGSR = (NSNumber *)[_stat updateServiceGlobalSuccessRate:@"70%" forDay:@"29" Month:@"05" andYear:@"2016" andIdPlayer:idP];
    
    XCTAssertEqual([updateServiceGSR boolValue],YES );
    
    NSNumber *updateBackhandGSR = (NSNumber *)[_stat updateBackhandGlobalSuccessRate:@"40%" forDay:@"29" Month:@"05" andYear:@"2016" andIdPlayer:idP];
    
    XCTAssertEqual([updateBackhandGSR boolValue],YES );
    
    NSNumber *updateForehandGSR = (NSNumber *)[_stat updateForeHandGlobalSuccessRate:@"65%" forDay:@"29" Month:@"05" andYear:@"2016" andIdPlayer:idP];
    
    XCTAssertEqual([updateForehandGSR boolValue],YES );
    
    NSArray *statsAfterUpdate = [_stat allStatistical];
    
    NSLog(@"%@", statsAfterUpdate);
    
    /*********************************************TEST Delete****************************************************/
    //delete coachplayer
    NSNumber *deleteCP = (NSNumber *) [_coachPlayer deleteCoachPlayerById:idCP];
    
    XCTAssertEqual([deleteCP boolValue],YES );
    
    NSNumber *deleteCP1 = (NSNumber *) [_coachPlayer deleteCoachPlayerByIdCoach:idC1];
    
    XCTAssertEqual([deleteCP1 boolValue],YES );
    
    NSNumber *deleteCP2 = (NSNumber *) [_coachPlayer deleteCoachPlayerByIdPlayer:idP2];
    
    XCTAssertEqual([deleteCP2 boolValue],YES );
    
    //delete trainingvideoplayer
    NSNumber *deletePTV = (NSNumber *) [_ptv deletePlayerTrainingVideoByIdVideo:idV2];
    
    XCTAssertEqual([deletePTV boolValue],YES );
    
    NSNumber *deletePTV1 = (NSNumber *) [_ptv deletePlayerTrainingVideoByIdPlayer:idP3];
    
    XCTAssertEqual([deletePTV1 boolValue],YES );
    
    NSNumber *deletePTV2 = (NSNumber *) [_ptv deletePlayerTrainingVideoByIdTraining:idST4];
    
    XCTAssertEqual([deletePTV2 boolValue],YES );
    
    NSNumber *deletePTV3 = (NSNumber *) [_ptv deletePlayerTrainingVideoById:idPTV1];
    
    XCTAssertEqual([deletePTV3 boolValue],YES );
    
    //delete movementref
    NSNumber *deletemvtref = (NSNumber *) [_mvtRef deleteMovementRefById:idmvtRef];
    
    XCTAssertEqual([deletemvtref boolValue],YES );
    
    //delete videoRef
    NSNumber *deletevideoref = (NSNumber *) [_videoRef deleteVideoRefById:idVR1];
    
    XCTAssertEqual([deletevideoref boolValue],YES );
    
    //delete movement
    NSNumber *deletemvt = (NSNumber *) [_mvt deleteMovementById:idmvt];
    
    XCTAssertEqual([deletemvt boolValue],YES );
    
    //delete video
    NSNumber *deletevideo = (NSNumber *) [_video deleteVideoById:idV2];
    
    XCTAssertEqual([deletevideo boolValue],YES );
    
    //delete training
    NSNumber *deletetraining = (NSNumber *) [_train deleteTrainingById:idST4];
    
    XCTAssertEqual([deletetraining boolValue],YES );
    
    //delete stat
    NSNumber *deletestat = (NSNumber *) [_stat deleteStatisticalById:idstat];
    
    XCTAssertEqual([deletestat boolValue],YES );
    
    //delete player
    NSNumber *deletep = (NSNumber *) [_player deletePlayerById:idP];
    
    XCTAssertEqual([deletep boolValue],YES );
    
    //delete coach
    NSNumber *deletec = (NSNumber *) [_coach deleteCoachById:idC];
    
    XCTAssertEqual([deletec boolValue],YES );
    
}

@end
