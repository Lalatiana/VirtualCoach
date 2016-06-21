//
//  UIMultipleProcessProgressView.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 19/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIProcessProgressView.h"

@interface UIMultipleProcessProgressView : UIProcessProgressView

@property (nonatomic, strong) UIProgressView *globalProgressView;
@property (nonatomic, strong) UIBaseLabel *globalProgressLabel;

@end
