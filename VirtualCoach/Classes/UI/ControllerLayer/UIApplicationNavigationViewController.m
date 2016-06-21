//
//  UIApplicationNavigationViewController.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 06/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIApplicationNavigationViewController.h"

#import "UICaptureSessionViewController.h"

@implementation UIApplicationNavigationViewController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    
    if (self)
    {
        _authenticationViewController = (UIAuthenticationViewController *)rootViewController;
        _accountCreationViewController = [[UIAccountCreationViewController alloc] init];
        _trainingViewController = [[UITrainingViewController alloc] init];
        _menuViewController = [[UIMenuViewController alloc] init];
        _playerViewController = [[UIPlayerViewController alloc] init];
        _profileViewController = [[UIProfileViewController alloc] init];
        
        [_authenticationViewController prepareForUse];
        [_accountCreationViewController prepareForUse];
        [_trainingViewController prepareForUse];
        [_menuViewController prepareForUse];
        [_playerViewController prepareForUse];
        [_profileViewController prepareForUse];
        
        CaptureProcessManager *captureProcessManager = [CaptureProcessManager sharedInstance];
        _captureSessionViewController = [[UICaptureSessionViewController alloc] initWithSessionController:[captureProcessManager captureSessionController]];
        
        [_captureSessionViewController prepareForUse];
        
        [self.navigationBar setBackgroundImage:[UIImage new]
                                 forBarMetrics:UIBarMetricsDefault];
        self.navigationBar.shadowImage = [UIImage new];
        self.navigationBar.translucent = YES;
        [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
        
        [self popToRootViewControllerAnimated:NO];
    }
    
    return self;
}

@end
