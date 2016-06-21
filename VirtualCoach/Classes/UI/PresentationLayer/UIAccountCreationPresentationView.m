//
//  UIAccountCreationPresentationView.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 05/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIAccountCreationPresentationView.h"

@implementation UIAccountCreationPresentationView

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _titleLabel = [[UIBaseLabel alloc] init];
        _presentationTextView = [[UITextView alloc] init];
    }
    
    return self;
}

- (void)prepareView
{
    //self.backgroundColor = [UIColor blueColor];
    
    [_titleLabel setFrame:CGRectMake(0, 100, 200, 100)];
    [_titleLabel setFont:[UIFont systemFontOfSize:30.f]];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    [_titleLabel setText:@"Why an account is so cool ?"];
    [_titleLabel resizeToFitText];
    
    CGPoint presentationTextViewOrigin = CGPointMake(0, _titleLabel.frame.origin.y + _titleLabel.frame.size.height + 50);
    CGSize presentationTextViewSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width / 2) - 80, [UIScreen mainScreen].bounds.size.height - 350);
    
    _presentationTextView.backgroundColor = [UIColor clearColor];
    [_presentationTextView setFrame:CGRectMake(presentationTextViewOrigin.x, presentationTextViewOrigin.y, presentationTextViewSize.width, presentationTextViewSize.height)];
    [_presentationTextView setScrollEnabled:NO];
    [_presentationTextView setEditable:NO];
    
    NSMutableAttributedString *presentationText = [[NSMutableAttributedString alloc] initWithString:@"Manage your players easily\n\n\nSet up the interface according with to preferences\n\n\nFollow your players's progression with wonderful curves\n\n\nBla bla bla"];
    [presentationText addAttribute:NSForegroundColorAttributeName
                             value:[UIColor whiteColor]
                             range:NSMakeRange(0, presentationText.length)];
    [presentationText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.f] range:NSMakeRange(0, presentationText.length)];
    [_presentationTextView setAttributedText:presentationText];
}

- (void)layout
{
    [super layout];
    
    [self prepareForUse];
    
    [self addSubview:_titleLabel alignment:UIViewCenteredOnX];
    [self addSubview:_presentationTextView alignment:UIViewCentered];
}

- (void)prepareForUse
{
    [self prepareView];
}

@end
