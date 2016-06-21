//
//  UITrainingView.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 22/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIBaseView.h"
#import "UIBaseLabel.h"
#import "UIBaseButton.h"
#import "UIProcessProgressView.h"
#import "UIMultipleProcessProgressView.h"

#import <Quartzcore/QuartzCore.h>

@interface UITrainingView : UIBaseView

@property (nonatomic, strong) UITableView *trainingsTableView;
@property (nonatomic, strong) UITableView *playersTableView;
@property (nonatomic, strong) UITableView *videosTableView;

@property (nonatomic, strong) UIBaseLabel *trainingsPanelLabel;
@property (nonatomic, strong) UIBaseLabel *infosPanelLabel;
@property (nonatomic, strong) UIBaseLabel *playersPanelLabel;
@property (nonatomic, strong) UIBaseLabel *videosPanelLabel;

@property (nonatomic, strong) UIBaseLabel *trainingCreationDateLabel;
@property (nonatomic, strong) UIBaseLabel *trainingPlayerCountLabel;

@property (nonatomic, strong) UIBaseButton *recordingViewButton;

@property (nonatomic, strong) UIBaseButton *addPlayerToTrainingButton;
@property (nonatomic, strong) UIBaseButton *removeSelectedPlayerButton;

@property (nonatomic, strong) UIBaseButton *processAllVideosButton;
@property (nonatomic, strong) UIBaseButton *watchSelectedVideoButton;

@property (nonatomic, strong) UIProcessProgressView *processVideoProgressView;
@property (nonatomic, strong) UIMultipleProcessProgressView *multipleProcessVideoProgressView;

@end
