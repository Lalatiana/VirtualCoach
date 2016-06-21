//
//  UITrainingViewController.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 22/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UITrainingViewController.h"

@interface UITrainingViewController ()

@property (nonatomic, assign) BOOL isMultipleProcess;

@end

@implementation UITrainingViewController

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _trainingView = [[UITrainingView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        _playerViewController = [[AVPlayerViewController alloc] init];
        
        [_trainingView.trainingsTableView setDelegate:self];
        [_trainingView.trainingsTableView setDataSource:self];
        
        [_trainingView.playersTableView setDelegate:self];
        [_trainingView.playersTableView setDataSource:self];
        
        [_trainingView.videosTableView setDelegate:self];
        [_trainingView.videosTableView setDataSource:self];
        
        [_trainingView.processAllVideosButton addTarget:self action:@selector(processAllVideosButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_trainingView.recordingViewButton addTarget:self action:@selector(recordingViewButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        self.view = _trainingView;
        
        self.navigationItem.title = @"Trainings";
        
        _isMultipleProcess = NO;
    }
    
    return self;
}

- (void)prepareForUse
{
    [_trainingView.trainingsTableView setTag:TRAININGS_TABLEVIEW_TAG];
    [_trainingView.playersTableView setTag:PLAYERS_TABLEVIEW_TAG];
    [_trainingView.videosTableView setTag:VIDEOS_TABLEVIEW_TAG];
    
    [_trainingView layout];
    
    AVPlayer * player = [[AVPlayer alloc] init];
    _playerViewController.player = player;
    [_playerViewController.view setFrame:_trainingView.frame];
    _playerViewController.showsPlaybackControls = YES;
    
}

- (void)viewDidLoad
{
    [_trainingView.trainingsTableView setSeparatorColor:[UIColor whiteColor]];
    [_trainingView.playersTableView setSeparatorColor:[UIColor whiteColor]];
    [_trainingView.videosTableView setSeparatorColor:[UIColor whiteColor]];
}

- (void)viewWillAppear:(BOOL)animated
{
    // set table view controller datas
    
    _trainingsTableViewData = @[@"Training1", @"Training2", @"Training3", @"Training4", @"Training5", @"Training6", @"Training7", @"Training8", @"Training9", @"Training10", @"Training11", @"Training12"];
    _playersTableViewData = [NSMutableArray arrayWithObjects:@"Joe", @"David", @"Luke", @"Steve P", @"Jeffrey", nil];
    
    _videosTableViewData = [NSMutableArray array];
    
    // temporary : load all videos in Documents directory
    
    NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] error:NULL];
    
    for (NSUInteger i = 0; i < [directoryContent count]; i++)
    {
        if ([[[directoryContent objectAtIndex:i] pathExtension] isEqualToString:@"mov"])
        {
            [_videosTableViewData addObject:[[directoryContent objectAtIndex:i] stringByDeletingPathExtension]];
        }
    }
    
    //temporary end
}

- (void)processVideoButtonAction:(UIBaseButton *)sender
{
    UITableViewCell *parentCell = (UITableViewCell *)[sender superview];
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Info"
                                  message:[NSString stringWithFormat:@"Are you sure to want to process the video %@ ?", parentCell.textLabel.text]
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"Process"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   // process video
                                   
                                   _isMultipleProcess = NO;
                                   
                                   NSString *videoName = [parentCell.textLabel text];
                                   NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                                   
                                   NSString *videoDataFilePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-data.plist", videoName]];
                                   
                                   NSDictionary *videoInfo = [[NSDictionary alloc] initWithContentsOfFile:videoDataFilePath];
                                   
                                   // workaround to update data file of example video as the application id changes everytime (so does the data file path) ...
                                   
                                   NSMutableDictionary *videoInfoMutable = [videoInfo mutableCopy];
                                   
                                   [videoInfoMutable setObject:[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mov", videoName]] forKey:@"videoPath"];
                                   
                                   [videoInfoMutable setObject:[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-reference.pgm", videoName]] forKey:@"referenceFramePath"];
                                   
                                   videoInfo = [videoInfoMutable copy];
                                   
                                   
                                   // end workaround
                                   
                                   __block NSUInteger serviceCount = 0, forehandCount = 0, backhandCount = 0;
                                   
                                   __block VideoProcess *vidProc;
                                   
                                   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                       
                                       dispatch_sync(dispatch_get_main_queue(), ^{
                                           [_trainingView addSubview:_trainingView.processVideoProgressView alignment:UIViewCentered];
                                           
                                           [parentCell.detailTextLabel setText:[NSString stringWithFormat:@"Length: 1:13\nForehand : %lu, backhand : %lu, service : %lu", (unsigned long)forehandCount, (unsigned long)backhandCount, (unsigned long)serviceCount]];
                                       });
                                       
                                       vidProc = [[VideoProcess alloc] initWithDictionary:videoInfo];
                                       [vidProc setDelegate:self];
                                       
                                       vidProc.samplingCount = 10;
                                       vidProc.overlappingRate = 0.6;
                                       vidProc.scale = 0.5;
                                       vidProc.shouldDeleteIrrelevantSequences = YES;
                                       
                                       [vidProc setup];
                                       [vidProc start];
                                       
                                       /**
                                        
                                            Retreive result datas and process them with RequestEngine
                                        
                                        **/
                                       
                                       serviceCount = [vidProc.dataAnalysisProcess serviceCount];
                                       forehandCount = [vidProc.dataAnalysisProcess forehandCount];
                                       backhandCount = [vidProc.dataAnalysisProcess backhandCount];
                                       
                                       dispatch_sync(dispatch_get_main_queue(), ^{
                                           [_trainingView.processVideoProgressView removeFromSuperview];
                                           
                                           [parentCell.detailTextLabel setText:[NSString stringWithFormat:@"Length: 1:13\nForehand : %lu, backhand : %lu, service : %lu", (unsigned long)forehandCount, (unsigned long)backhandCount, (unsigned long)serviceCount]];
                                           
                                           [sender setEnabled:NO];
                                       });
                                   });
                                   
                                   
                                   
                                   // lazy way, have to think about it...
                                   
                                   
                                   
                                   
                               }];
    
    UIAlertAction* cancelButton = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction * action)
                                   {
                                       // do nothing
                                   }];
    
    [alert addAction:cancelButton];
    [alert addAction:okButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)processAllVideosButtonAction
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Process all videos ?"
                                  message:@"Processing all videos may take a lot of time. Are you sure ?"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"Process all"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   _isMultipleProcess = YES;
                                   
                                   // process all videos
                                   
                                   NSMutableArray *allVideos = [NSMutableArray array];
                                   
                                   // dictionary that will contains all video results (key is video name)
                                   
                                   NSMutableDictionary *allVideosResult = [NSMutableDictionary dictionary];
                                   
                                   // have to fill this array with all non processed videos
                                   
                                   [allVideos addObject:@"2016-06-06_19.19.40"];
                                   [allVideos addObject:@"2016-06-06_19.19.41"];
                                   [allVideos addObject:@"2016-06-06_19.19.42"];
                                   [allVideos addObject:@"2016-06-06_19.19.43"];
                                   
                                   CGFloat progressPerVideo = 1.f / allVideos.count;
                                   
                                   // we display the global process view with GCD
                                   
                                   dispatch_async(dispatch_get_global_queue(0, 0), ^{
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           [_trainingView addSubview:_trainingView.multipleProcessVideoProgressView alignment:UIViewCentered];
                                       });
                                   });
                                   
                                   // we loop through the allVideos array and process each video on a background thread
                                   
                                   dispatch_async(dispatch_get_global_queue(0, 0), ^{
                                       
                                       for (NSUInteger i = 0; i < allVideos.count; i++)
                                       {
                                           // we update the UI on the main thread synchronously
                                           
                                           dispatch_sync(dispatch_get_main_queue(), ^{
                                               
                                               [_trainingView.multipleProcessVideoProgressView.progressView setProgress:0.f animated:YES];
                                               
                                               NSDictionary *attributes = [(NSAttributedString *)_trainingView.multipleProcessVideoProgressView.globalProgressLabel.attributedText attributesAtIndex:0 effectiveRange:NULL];
                                               _trainingView.multipleProcessVideoProgressView.globalProgressLabel.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Processing video... (%u / %lu)", i+1, (unsigned long)allVideos.count] attributes:attributes];
                                           });
                                           
                                           // we extract video informations to prepare the process (always in a synchronous way)
                                           
                                           dispatch_sync(dispatch_get_global_queue(0, 0), ^{
                                               
                                               NSString *videoName = [allVideos objectAtIndex:i];
                                               NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                                               
                                               NSString *videoDataFilePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-data.plist", videoName]];
                                               
                                               NSDictionary *videoInfo = [[NSDictionary alloc] initWithContentsOfFile:videoDataFilePath];
                                               
                                               // workaround to update data file of example video as the application id changes everytime (so does the data file path) ...
                                               
                                               NSMutableDictionary *videoInfoMutable = [videoInfo mutableCopy];
                                               
                                               [videoInfoMutable setObject:[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mov", videoName]] forKey:@"videoPath"];
                                               
                                               [videoInfoMutable setObject:[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-reference.pgm", videoName]] forKey:@"referenceFramePath"];
                                               
                                               videoInfo = [videoInfoMutable copy];
                                               
                                               // end workaround
                                               
                                               NSUInteger serviceCount = 0, forehandCount = 0, backhandCount = 0;
                                               
                                               VideoProcess *vidProc;
                                               
                                               vidProc = [[VideoProcess alloc] initWithDictionary:videoInfo];
                                               [vidProc setDelegate:self];
                                               
                                               vidProc.samplingCount = 10;
                                               vidProc.overlappingRate = 0.6;
                                               vidProc.scale = 0.5;
                                               vidProc.shouldDeleteIrrelevantSequences = YES;
                                               
                                               [vidProc setup];
                                               [vidProc start];
                                               
                                               /**
                                                
                                                Retreive result datas and process them with RequestEngine
                                                
                                                **/
                                               
                                               serviceCount = [vidProc.dataAnalysisProcess serviceCount];
                                               forehandCount = [vidProc.dataAnalysisProcess forehandCount];
                                               backhandCount = [vidProc.dataAnalysisProcess backhandCount];
                                               
                                               NSArray *videoResultKey = [NSArray arrayWithObjects:@"forehandCount", @"backhandCount", @"serviceCount", nil];
                                               
                                               NSArray *videoResultObject = [NSArray arrayWithObjects:[NSNumber numberWithUnsignedInteger:forehandCount], [NSNumber numberWithUnsignedInteger:backhandCount], [NSNumber numberWithUnsignedInteger:serviceCount], nil];
                                               
                                               // we save the results in the allVideosResult dictionnary
                                               // more will be saved, for example the comparison results
                                               
                                               [allVideosResult setObject:[NSDictionary dictionaryWithObjects:videoResultObject forKeys:videoResultKey] forKey:videoName];
                                           });
                                           
                                           // we update the UI on the main thread
                                           
                                           dispatch_sync(dispatch_get_main_queue(), ^{
                                               
                                               [_trainingView.multipleProcessVideoProgressView.globalProgressView setProgress:(i+1) * progressPerVideo animated:YES];
                                           });
                                       }
                                       
                                       // we remove the progerss view and update the videos cell with the results
                                       
                                       dispatch_sync(dispatch_get_main_queue(), ^{
                                           
                                           [_trainingView.multipleProcessVideoProgressView removeFromSuperview];
                                           
                                           for (NSUInteger j = 0; j < [_trainingView.videosTableView numberOfRowsInSection:0]; j++)
                                           {
                                               UITableViewCell *cell = [_trainingView.videosTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:j inSection:0]];
                                               
                                               for (NSUInteger j = 0; j < allVideos.count; j++)
                                               {
                                                   NSString *video = [allVideos objectAtIndex:j];
                                                   
                                                   if ([cell.textLabel.text isEqualToString:video])
                                                   {
                                                       NSDictionary *videoResult = [allVideosResult objectForKey:video];
                                                       NSNumber *serviceCount = (NSNumber *)[videoResult objectForKey:@"serviceCount"];
                                                       NSNumber *forehandCount = (NSNumber *)[videoResult objectForKey:@"forehandCount"];
                                                       NSNumber *backhandCount = (NSNumber *)[videoResult objectForKey:@"backhandCount"];
                                                       
                                                       [cell.detailTextLabel setText:[NSString stringWithFormat:@"Length: 1:13\nForehand : %d, backhand : %d, service : %d", forehandCount.intValue, backhandCount.intValue, serviceCount.intValue]];
                                                       
                                                       // we should disable the process button for each cell of a processed video
                                                       
//                                                       for (UIView *cellSubview in cell.subviews)
//                                                       {
//                                                           if ([cellSubview isMemberOfClass:[UIBaseButton class]])
//                                                           {
//                                                               <#statements#>
//                                                           }
//                                                       }
                                                   }
                                               }
                                           }
                                       });
                                   });
                               }];
    
    UIAlertAction* cancelButton = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction * action)
                                   {
                                       // do nothing
                                   }];
    
    [alert addAction:okButton];
    [alert addAction:cancelButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)removeVideoButtonAction:(UIBaseButton *)sender
{
    UITableViewCell *parentCell = (UITableViewCell *)[sender superview];
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Delete video ?"
                                 message:[NSString stringWithFormat:@"The video %@ will be permanently deleted. Are you sure ?", parentCell.textLabel.text]
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"Delete"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   // delete video
                                   
                                   NSString *videoName = [parentCell.textLabel text];
                                   NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                                   NSString *videoPath = [documentsDirectory stringByAppendingPathComponent:[videoName stringByAppendingPathExtension:@"mov"]];
                                   
                                   NSFileManager *fileManager = [NSFileManager defaultManager];
                                   NSError *error;
                                   
                                   BOOL success = [fileManager removeItemAtPath:videoPath error:&error];
                                   
                                   if (success)
                                   {
                                       [_videosTableViewData removeObject:videoName];
                                       [_trainingView.videosTableView reloadData];
                                       
                                       // should do something with the database
                                   }
                               }];
    
    UIAlertAction* cancelButton = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction * action)
                                   {
                                       // do nothing
                                   }];
    
    [alert addAction:cancelButton];
    [alert addAction:okButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)recordingViewButtonAction
{
    UIApplicationNavigationViewController *nav = (UIApplicationNavigationViewController *)self.navigationController;
    [nav pushViewController:nav.captureSessionViewController animated:YES];
}

- (void)playVideoButtonAction:(UIBaseButton *)sender
{
    UITableViewCell *parentCell = (UITableViewCell *)[sender superview];
    
    NSString *videoName = [parentCell.textLabel text];
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *videoPath = [documentsDirectory stringByAppendingPathComponent:[videoName stringByAppendingPathExtension:@"mov"]];
    
    NSURL *url = [NSURL fileURLWithPath:videoPath];
    AVURLAsset *asset = [AVURLAsset assetWithURL: url];
    AVPlayerItem *item = [AVPlayerItem playerItemWithAsset: asset];
    
    [_playerViewController.player replaceCurrentItemWithPlayerItem:item];
    
    [self presentViewController:_playerViewController animated:YES completion:nil];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == TRAININGS_TABLEVIEW_TAG)
    {
        /** Example code to reload data according to a selection
         
        NSLog(@"Cell from TRAININGS TABLE CELL VIEW WAS SELECTED");
        
        _playersTableViewData = @[@"Training1Player1", @"Training1Player2", @"Training1Player3", @"Training1Player4"];
        _videosTableViewData = @[@"2016-05-25_11.00.47", @"2016-05-25_11.27.59", @"2016-06-05_10.10.07", @"2016-06-05_10.24.25"];
        
        [_trainingView.playersTableView reloadData];
        [_trainingView.videosTableView reloadData];
         
         **/
    }
    
    else if (tableView.tag == PLAYERS_TABLEVIEW_TAG)
    {
        NSLog(@"Cell from PLAYERS TABLE CELL VIEW WAS SELECTED");
    }
    
    else if (tableView.tag == VIDEOS_TABLEVIEW_TAG)
    {
        NSLog(@"Cell from VIDEOS TABLE CELL VIEW WAS SELECTED");
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = -1;
    
    if (tableView.tag == TRAININGS_TABLEVIEW_TAG)
        numberOfRows = _trainingsTableViewData.count;
    
    else if (tableView.tag == PLAYERS_TABLEVIEW_TAG)
        numberOfRows = _playersTableViewData.count;
    
    else if (tableView.tag == VIDEOS_TABLEVIEW_TAG)
        numberOfRows = _videosTableViewData.count;
    
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell)
        cell = nil;
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        [cell.detailTextLabel setTextColor:[UIColor whiteColor]];
        [cell.detailTextLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [cell.detailTextLabel setNumberOfLines:0];
        [cell setBackgroundColor:[UIColor clearColor]];
    }
    
    if (tableView.tag == TRAININGS_TABLEVIEW_TAG)
    {
        [cell.textLabel setText:[_trainingsTableViewData objectAtIndex:indexPath.row]];
        [cell.detailTextLabel setText:@"Date: 00/00/9999\nLocation: Cergy-Pontoise\nPlayer count: 6"];
    }
    
    else if (tableView.tag == PLAYERS_TABLEVIEW_TAG)
    {
        [cell.textLabel setText:[_playersTableViewData objectAtIndex:indexPath.row]];
        [cell.detailTextLabel setText:@"Name: Toto\nPro"];
        
        UIImage *profileIcon = [UIImage imageNamed:@"playerIcon.png"];
        [cell.imageView setImage:profileIcon];
//        UIImageView *profileIconImageView = [[UIImageView alloc] initWithImage:profileIcon];
//        [profileIconImageView setFrame:CGRectMake(-profileIconImageView.frame.size.width, -profileIconImageView.frame.size.height, profileIconImageView.frame.size.width, profileIconImageView.frame.size.height)];
//        [cell addSubview:profileIconImageView];
    }
    
    else if (tableView.tag == VIDEOS_TABLEVIEW_TAG)
    {
        [cell.textLabel setText:[_videosTableViewData objectAtIndex:indexPath.row]];
        [cell.detailTextLabel setText:@"Length: 1:13\n------------"];
        
        CGSize playButtonSize = CGSizeMake(40, 40);
        
        UIBaseButton *playButton = [UIBaseButton buttonWithType:UIButtonTypeCustom];
        [playButton setFrame:CGRectMake((cell.frame.size.width / 2) + 80, cell.frame.size.height / 2 + 5, playButtonSize.width, playButtonSize.height)];
        [playButton setImage:[UIImage imageNamed:@"playIcon.png"] forState:UIControlStateNormal];
        [playButton addTarget:self action:@selector(playVideoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:playButton];
        
        UIBaseButton *processButton = [UIBaseButton buttonWithType:UIButtonTypeCustom];
        [processButton setFrame:CGRectMake(playButton.frame.origin.x + playButton.frame.size.width + 10, playButton.frame.origin.y, playButtonSize.width, playButtonSize.height)];
        [processButton setImage:[UIImage imageNamed:@"processIcon.png"] forState:UIControlStateNormal];
        [processButton addTarget:self action:@selector(processVideoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:processButton];
        
        UIBaseButton *removeButton = [UIBaseButton buttonWithType:UIButtonTypeCustom];
        [removeButton setFrame:CGRectMake(processButton.frame.origin.x + processButton.frame.size.width + 10, processButton.frame.origin.y, playButtonSize.width, playButtonSize.height)];
        [removeButton setImage:[UIImage imageNamed:@"deleteVideoIcon.png"] forState:UIControlStateNormal];
        [removeButton addTarget:self action:@selector(removeVideoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:removeButton];
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 44.f;
    
    if (tableView.tag == TRAININGS_TABLEVIEW_TAG)
    {
        height += 50;
    }
    
    else if (tableView.tag == PLAYERS_TABLEVIEW_TAG)
    {
        height += 30;
    }
    
    else if (tableView.tag == VIDEOS_TABLEVIEW_TAG)
    {
        height += 30;
    }
    
    return height;
}

- (void)didUpdateStatusWithProgress:(float)progress message:(NSString *)message
{
    if (progress > 0)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIProcessProgressView *processProgressView = _isMultipleProcess ? _trainingView.multipleProcessVideoProgressView : _trainingView.processVideoProgressView;
            UIProgressView *progressView = processProgressView.progressView;
            [progressView setProgress:progressView.progress + progress animated:YES];
        });
    }
    
    if (message)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if ([_trainingView.processVideoProgressView.progressLabel.attributedText length])
            {
                UIProcessProgressView *processProgressView = _isMultipleProcess ? _trainingView.multipleProcessVideoProgressView : _trainingView.processVideoProgressView;
                NSDictionary *attributes = [(NSAttributedString *)processProgressView.progressLabel.attributedText attributesAtIndex:0 effectiveRange:NULL];
                processProgressView.progressLabel.attributedText = [[NSAttributedString alloc] initWithString:message attributes:attributes];
            }
        });
    }
}

@end
