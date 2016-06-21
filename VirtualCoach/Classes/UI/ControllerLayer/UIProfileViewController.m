//
//  UIProfileViewController.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 19/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIProfileViewController.h"

@implementation UIProfileViewController

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _profileView = [[UIProfileView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        _playerViewController = [[AVPlayerViewController alloc] init];
        
        self.view = _profileView;
        
        self.navigationItem.title = @"Profile";
        
        [_profileView.referenceMotionsTableView setDelegate:self];
        [_profileView.referenceMotionsTableView setDataSource:self];
        
        [_profileView.forehandReferenceMotionPickerView setDataSource:self];
        [_profileView.forehandReferenceMotionPickerView setDelegate:self];
        
        [_profileView.backhandReferenceMotionPickerView setDataSource:self];
        [_profileView.backhandReferenceMotionPickerView setDelegate:self];
        
        [_profileView.serviceReferenceMotionPickerView setDataSource:self];
        [_profileView.serviceReferenceMotionPickerView setDelegate:self];
        
        [_profileView.processAllReferenceMotionsButton addTarget:self action:@selector(processAllReferenceVideosButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_profileView.goToRecordingViewButton addTarget:self action:@selector(goToRecordingViewButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (void)prepareForUse
{
    [_profileView layout];
    
    AVPlayer * player = [[AVPlayer alloc] init];
    _playerViewController.player = player;
    [_playerViewController.view setFrame:_profileView.frame];
    _playerViewController.showsPlaybackControls = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    _referenceVideosTableViewData = [NSMutableArray array];
    _referenceForehandPickerViewData = [NSMutableArray array];
    _referenceBackhandPickerViewData = [NSMutableArray array];
    _referenceServicePickerViewData = [NSMutableArray array];
    
    // temporary : load all videos in Documents directory
    
    NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] error:NULL];
    
    for (NSUInteger i = 0; i < [directoryContent count]; i++)
    {
        if ([[[directoryContent objectAtIndex:i] pathExtension] isEqualToString:@"mov"])
        {
            [_referenceVideosTableViewData addObject:[[directoryContent objectAtIndex:i] stringByDeletingPathExtension]];
            [_referenceForehandPickerViewData addObject:[[directoryContent objectAtIndex:i] stringByDeletingPathExtension]];
            [_referenceBackhandPickerViewData addObject:[[directoryContent objectAtIndex:i] stringByDeletingPathExtension]];
            [_referenceServicePickerViewData addObject:[[directoryContent objectAtIndex:i] stringByDeletingPathExtension]];
        }
    }
    
    //temporary end
}

- (void)processReferenceVideoButtonAction:(UIBaseButton *)sender
{
    
}

- (void)removeReferenceVideoButtonAction:(UIBaseButton *)sender
{
    
}

- (void)processAllReferenceVideosButtonAction
{
    
}

- (void)goToRecordingViewButtonAction
{
    UIApplicationNavigationViewController *nav = (UIApplicationNavigationViewController *)self.navigationController;
    [nav pushViewController:nav.captureSessionViewController animated:YES];
}

- (void)playReferenceVideoButtonAction:(UIBaseButton *)sender
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
    NSLog(@"Cell from VIDEOS TABLE CELL VIEW WAS SELECTED");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_referenceVideosTableViewData count];
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
    
    [cell.textLabel setText:[_referenceVideosTableViewData objectAtIndex:indexPath.row]];
    [cell.detailTextLabel setText:@"Motion: Forehand"];
    
    CGSize playButtonSize = CGSizeMake(40, 40);
    
    UIBaseButton *playButton = [UIBaseButton buttonWithType:UIButtonTypeCustom];
    [playButton setFrame:CGRectMake((cell.frame.size.width / 2) + 80, cell.frame.size.height / 2 + 5, playButtonSize.width, playButtonSize.height)];
    [playButton setImage:[UIImage imageNamed:@"playIcon.png"] forState:UIControlStateNormal];
    [playButton addTarget:self action:@selector(playReferenceVideoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:playButton];
    
    UIBaseButton *processButton = [UIBaseButton buttonWithType:UIButtonTypeCustom];
    [processButton setFrame:CGRectMake(playButton.frame.origin.x + playButton.frame.size.width + 10, playButton.frame.origin.y, playButtonSize.width, playButtonSize.height)];
    [processButton setImage:[UIImage imageNamed:@"deleteVideoIcon.png"] forState:UIControlStateNormal];
    [processButton addTarget:self action:@selector(removeReferenceVideoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:processButton];
    
    UIBaseButton *removeButton = [UIBaseButton buttonWithType:UIButtonTypeCustom];
    [removeButton setFrame:CGRectMake(processButton.frame.origin.x + processButton.frame.size.width + 10, processButton.frame.origin.y, playButtonSize.width, playButtonSize.height)];
    [removeButton setImage:[UIImage imageNamed:@"processIcon.png"] forState:UIControlStateNormal];
    [removeButton addTarget:self action:@selector(processReferenceVideoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:removeButton];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 74.f;
}

// picker views

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger count = -1;
    
    if (pickerView.tag == REFERENCE_FOREHAND_PICKERVIEW_TAG)
    {
        count = [_referenceForehandPickerViewData count];
    }
    
    else if (pickerView.tag == REFERENCE_BACKHAND_PICKERVIEW_TAG)
    {
        count = [_referenceBackhandPickerViewData count];
    }
    
    else if (pickerView.tag == REFERENCE_SERVICE_PICKERVIEW_TAG)
    {
        count = [_referenceServicePickerViewData count];
    }
    
    return count;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView.tag == REFERENCE_FOREHAND_PICKERVIEW_TAG)
    {
        NSLog(@"You selected this: %@", [_referenceForehandPickerViewData objectAtIndex:row]);
    }
    
    else if (pickerView.tag == REFERENCE_BACKHAND_PICKERVIEW_TAG)
    {
        NSLog(@"You selected this: %@", [_referenceBackhandPickerViewData objectAtIndex:row]);
    }
    
    else if (pickerView.tag == REFERENCE_SERVICE_PICKERVIEW_TAG)
    {
        NSLog(@"You selected this: %@", [_referenceServicePickerViewData objectAtIndex:row]);
    }
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    NSString *rowItem;
    
    if (pickerView.tag == REFERENCE_FOREHAND_PICKERVIEW_TAG)
    {
        rowItem = [_referenceForehandPickerViewData objectAtIndex:row];
    }
    
    else if (pickerView.tag == REFERENCE_BACKHAND_PICKERVIEW_TAG)
    {
        rowItem = [_referenceBackhandPickerViewData objectAtIndex:row];
    }
    
    else if (pickerView.tag == REFERENCE_SERVICE_PICKERVIEW_TAG)
    {
        rowItem = [_referenceServicePickerViewData objectAtIndex:row];
    }
    
    UILabel *lblRow = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView bounds].size.width, 44.0f)];
    [lblRow setTextAlignment:NSTextAlignmentCenter];
    [lblRow setTextColor: [UIColor whiteColor]];
    [lblRow setText:rowItem];
    [lblRow setBackgroundColor:[UIColor clearColor]];
    
    return lblRow;
}

@end
