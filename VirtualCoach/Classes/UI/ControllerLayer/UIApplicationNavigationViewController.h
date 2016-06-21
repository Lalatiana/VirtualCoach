//
//  UIApplicationNavigationViewController.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 06/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIAuthenticationViewController.h"
#import "UIAccountCreationViewController.h"
#import "UITrainingViewController.h"
#import "UIMenuViewController.h"
#import "UIPlayerViewController.h"
#import "CaptureProcessManager.h"
#import "UIProfileViewController.h"

@class UIHomeViewController, UICaptureSessionViewController, UIAuthenticationViewController, UIAccountCreationViewController, UITrainingViewController, UIMenuViewController, UIProfileViewController;

@interface UIApplicationNavigationViewController : UINavigationController

@property (nonatomic, strong) UIAuthenticationViewController *authenticationViewController;
@property (nonatomic, strong) UIAccountCreationViewController *accountCreationViewController;
@property (nonatomic, strong) UICaptureSessionViewController *captureSessionViewController;
@property (nonatomic, strong) UITrainingViewController *trainingViewController;
@property (nonatomic, strong) UIMenuViewController *menuViewController;
@property (nonatomic, strong) UIPlayerViewController *playerViewController;
@property (nonatomic, strong) UIProfileViewController *profileViewController;

@end
