//
//  UIProcessProgressView.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 12/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIBaseView.h"
#import "UIBaseLabel.h"

@interface UIProcessProgressView : UIBaseView

@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UIBaseLabel *progressLabel;

- (void)prepareView;

@end
