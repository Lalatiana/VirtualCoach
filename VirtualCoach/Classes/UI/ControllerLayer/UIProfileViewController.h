//
//  UIProfileViewController.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 19/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIBaseViewController.h"
#import "UIProfileView.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "UIApplicationNavigationViewController.h"

#define REFERENCE_FOREHAND_PICKERVIEW_TAG 1
#define REFERENCE_BACKHAND_PICKERVIEW_TAG 2
#define REFERENCE_SERVICE_PICKERVIEW_TAG 3

@class AVPlayerViewController, UIProfileView;

@interface UIProfileViewController : UIBaseViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIProfileView *profileView;

@property (nonatomic, strong) NSMutableArray *referenceVideosTableViewData;

@property (nonatomic, strong) NSMutableArray *referenceForehandPickerViewData;
@property (nonatomic, strong) NSMutableArray *referenceBackhandPickerViewData;
@property (nonatomic, strong) NSMutableArray *referenceServicePickerViewData;

@property (nonatomic, strong) AVPlayerViewController *playerViewController;

- (void)processReferenceVideoButtonAction:(UIBaseButton *)sender;
- (void)removeReferenceVideoButtonAction:(UIBaseButton *)sender;
- (void)processAllReferenceVideosButtonAction;
- (void)goToRecordingViewButtonAction;
- (void)playReferenceVideoButtonAction:(UIBaseButton *)sender;

@end
