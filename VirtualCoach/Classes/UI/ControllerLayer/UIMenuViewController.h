//
//  UIMenuViewController.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 14/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIBaseViewController.h"
#import "UIMenuView.h"
#import "UIApplicationNavigationViewController.h"
#import "UICaptureSessionViewController.h"
#import "UITrainingViewController.h"
#import "UIProfileViewController.h"

@interface UIMenuViewController : UIBaseViewController

@property (nonatomic, strong) UIMenuView *menuView;

- (void)captureViewButtonAction;
- (void)trainingViewButtonAction;
- (void)playerViewButtonAction;
- (void)profileButtonAction;

@end
