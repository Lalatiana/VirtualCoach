//
//  UIMenuView.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 14/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIBaseView.h"
#import "UIBaseButton.h"
#import "UIBaseLabel.h"

@interface UIMenuView : UIBaseView

@property (nonatomic, strong) UIBaseButton *captureViewButton;
@property (nonatomic, strong) UIBaseButton *trainingViewButton;
@property (nonatomic, strong) UIBaseButton *playerViewButton;

@property (nonatomic, strong) UIBarButtonItem *profileButton;

@property (nonatomic, strong) UIImageView *tennisCourtImage;

@property (nonatomic, strong) UIBaseLabel *captureViewInformationsLabel;
@property (nonatomic, strong) UIBaseLabel *trainingsViewInformationsLabel;
@property (nonatomic, strong) UIBaseLabel *playersViewInformationsLabel;

@end
