//
//  UIMultipleProcessProgressView.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 19/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIMultipleProcessProgressView.h"

@implementation UIMultipleProcessProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _globalProgressView = [[UIProgressView alloc] init];
        _globalProgressLabel = [[UIBaseLabel alloc] init];
    }
    
    return self;
}

- (void)prepareView
{
    [super prepareView];
    
    CGFloat defaultMargin = 40.f;
    
    CGPoint globalProgressLabelOrigin = CGPointMake(defaultMargin, self.progressView.frame.origin.y + self.progressView.frame.size.height + defaultMargin);
    CGSize globalProgressLabelSize = CGSizeMake(self.frame.size.width - (defaultMargin * 2), 20);
    
    [_globalProgressLabel setFrame:CGRectMake(globalProgressLabelOrigin.x, globalProgressLabelOrigin.y, globalProgressLabelSize.width, globalProgressLabelSize.height)];
    
    NSMutableAttributedString *globalProgressLabelText = [[NSMutableAttributedString alloc] initWithString:@"   "];
    [globalProgressLabelText addAttribute:NSForegroundColorAttributeName
                              value:[UIColor whiteColor]
                              range:NSMakeRange(0, globalProgressLabelText.length)];
    [globalProgressLabelText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.f] range:NSMakeRange(0, globalProgressLabelText.length)];
    [_globalProgressLabel setAttributedText:globalProgressLabelText];
    
    CGPoint globalProgressViewOrigin = CGPointMake(defaultMargin, globalProgressLabelOrigin.y + globalProgressLabelSize.height + defaultMargin);
    CGSize globalProgressViewSize = CGSizeMake(self.frame.size.width - (defaultMargin * 2), 20);
    
    [_globalProgressView setFrame:CGRectMake(globalProgressViewOrigin.x, globalProgressViewOrigin.y, globalProgressViewSize.width, globalProgressViewSize.height)];
    [_globalProgressView setProgress:0.f];
    [_globalProgressView setTrackTintColor:[UIColor lightGrayColor]];
    _globalProgressView.observedProgress = nil;
}

- (void)layout
{
    [super layout];
    
    [self prepareForUse];
    
    [self addSubview:_globalProgressLabel alignment:UIViewCenteredOnX];
    [self addSubview:_globalProgressView alignment:UIViewCenteredOnX];
}

- (void)prepareForUse
{
    [self prepareView];
}

@end
