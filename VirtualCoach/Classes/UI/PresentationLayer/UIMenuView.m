//
//  UIMenuView.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 14/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIMenuView.h"

@implementation UIMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _captureViewButton = [[UIBaseButton alloc] init];
        _trainingViewButton = [[UIBaseButton alloc] init];
        _playerViewButton = [[UIBaseButton alloc] init];
        _profileButton = [[UIBarButtonItem alloc] init];
        
        _captureViewInformationsLabel = [[UIBaseLabel alloc] init];
        _trainingsViewInformationsLabel = [[UIBaseLabel alloc] init];
        _playersViewInformationsLabel = [[UIBaseLabel alloc] init];
    }
    
    return self;
}

- (void)prepareView
{
    CGFloat defaultMargin = 40.f;
    
    CGSize captureViewButtonSize = CGSizeMake(80, 80);
    CGPoint captureViewButtonOrigin = CGPointMake(((3 * self.frame.size.width) / 4) - (captureViewButtonSize.width / 2), (self.frame.size.height / 4) - (captureViewButtonSize.height / 2));
    
    //_captureViewButton.backgroundColor = [UIColor yellowColor];
    
    [_captureViewButton setFrame:CGRectMake(captureViewButtonOrigin.x, captureViewButtonOrigin.y, captureViewButtonSize.width, captureViewButtonSize.height)];
    [_captureViewButton setImage:[UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
    
    NSMutableAttributedString *captureViewButtonTitle = [[NSMutableAttributedString alloc] initWithString:@"Capture"];
    [captureViewButtonTitle addAttribute:NSFontAttributeName
                                   value:[UIFont systemFontOfSize:18.0]
                                   range:NSMakeRange(0, [captureViewButtonTitle length])];
    [captureViewButtonTitle addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [captureViewButtonTitle length])];
    
    [_captureViewButton setAttributedTitle:captureViewButtonTitle forState:UIControlStateNormal];
    
    CGSize trainingViewButtonSize = CGSizeMake(200, 200);
    CGPoint trainingViewButtonOrigin = CGPointMake(((3 * self.frame.size.width) / 4) - (trainingViewButtonSize.width / 2), ((2 * self.frame.size.height) / 4) - (trainingViewButtonSize.height / 2));
    
    [_trainingViewButton setFrame:CGRectMake(trainingViewButtonOrigin.x, trainingViewButtonOrigin.y, trainingViewButtonSize.width, trainingViewButtonSize.height)];
    [_trainingViewButton setImage:[UIImage imageNamed:@"training.png"] forState:UIControlStateNormal];
    
    
    
    CGSize playerViewButtonSize = CGSizeMake(captureViewButtonSize.width, captureViewButtonSize.height);
    CGPoint playerViewButtonOrigin = CGPointMake(((3 * self.frame.size.width) / 4) - (captureViewButtonSize.width / 2), ((3 * self.frame.size.height) / 4) - (captureViewButtonSize.height / 2));
    
    [_playerViewButton setFrame:CGRectMake(playerViewButtonOrigin.x, playerViewButtonOrigin.y, playerViewButtonSize.width, playerViewButtonSize.height)];
    [_playerViewButton setImage:[UIImage imageNamed:@"tennisPlayer.png"] forState:UIControlStateNormal];
    
    _profileButton.style = UIBarButtonItemStylePlain;
    _profileButton.title = @"Profile";
    
    
    CGSize captureViewInformationsLabelSize = CGSizeMake(self.frame.size.width / 2 - (defaultMargin * 4), 100);
    CGPoint captureViewInformationsLabelOrigin = CGPointMake((self.frame.size.width / 4) - (captureViewInformationsLabelSize.width / 2), (self.frame.size.height / 4) - (captureViewButtonSize.height / 2));
    [_captureViewInformationsLabel setFrame:CGRectMake(captureViewInformationsLabelOrigin.x, captureViewInformationsLabelOrigin.y, captureViewInformationsLabelSize.width, captureViewInformationsLabelSize.height)];
    
    _captureViewInformationsLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _captureViewInformationsLabel.numberOfLines = 3;
    
    NSMutableAttributedString *captureViewInformationsLabelText = [[NSMutableAttributedString alloc] initWithString:@"Record your players to analyze their motions and compare them with your own !"];
    [captureViewInformationsLabelText addAttribute:NSFontAttributeName
                                value:[UIFont systemFontOfSize:20.0]
                                range:NSMakeRange(0, [captureViewInformationsLabelText length])];
    [captureViewInformationsLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [captureViewInformationsLabelText length])];
    
    [_captureViewInformationsLabel setAttributedText:captureViewInformationsLabelText];
    
    CGSize trainingViewInformationsLabelSize = CGSizeMake(self.frame.size.width / 2 - (defaultMargin * 4), 100);
    CGPoint trainingViewInformationsLabelOrigin = CGPointMake((self.frame.size.width / 4) - (captureViewInformationsLabelSize.width / 2), ((2 * self.frame.size.height) / 4) - (trainingViewButtonSize.height / 2));
    [_trainingsViewInformationsLabel setFrame:CGRectMake(trainingViewInformationsLabelOrigin.x, trainingViewInformationsLabelOrigin.y, trainingViewInformationsLabelSize.width, trainingViewInformationsLabelSize.height)];
    
    _trainingsViewInformationsLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _trainingsViewInformationsLabel.numberOfLines = 3;
    
    NSMutableAttributedString *trainingViewInformationsLabelText = [[NSMutableAttributedString alloc] initWithString:@"Manage yours trainings, organize your players in each training, process and watch their videos !"];
    [trainingViewInformationsLabelText addAttribute:NSFontAttributeName
                                             value:[UIFont systemFontOfSize:20.0]
                                             range:NSMakeRange(0, [trainingViewInformationsLabelText length])];
    [trainingViewInformationsLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [trainingViewInformationsLabelText length])];
    
    [_trainingsViewInformationsLabel setAttributedText:trainingViewInformationsLabelText];
    
    CGSize playerViewInformationsLabelSize = CGSizeMake(self.frame.size.width / 2 - (defaultMargin * 4), 100);
    CGPoint playerViewInformationsLabelOrigin = CGPointMake((self.frame.size.width / 4) - (captureViewInformationsLabelSize.width / 2), ((3 * self.frame.size.height) / 4) - (captureViewButtonSize.height / 2));
    [_playersViewInformationsLabel setFrame:CGRectMake(playerViewInformationsLabelOrigin.x, playerViewInformationsLabelOrigin.y, playerViewInformationsLabelSize.width, playerViewInformationsLabelSize.height)];
    
    _playersViewInformationsLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _playersViewInformationsLabel.numberOfLines = 3;
    
    NSMutableAttributedString *playerViewInformationsLabelText = [[NSMutableAttributedString alloc] initWithString:@"Manage your player set, view their statistics on different base (motions, progress) on different periods (weekly, monthly...) !"];
    [playerViewInformationsLabelText addAttribute:NSFontAttributeName
                                              value:[UIFont systemFontOfSize:20.0]
                                              range:NSMakeRange(0, [playerViewInformationsLabelText length])];
    [playerViewInformationsLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [playerViewInformationsLabelText length])];
    
    [_playersViewInformationsLabel setAttributedText:playerViewInformationsLabelText];
}

- (void)layout
{
    [super layout];
    
    [self prepareForUse];
    
    [self addSubview:_captureViewButton];
    [self addSubview:_trainingViewButton];
    [self addSubview:_playerViewButton];
    
    [self addSubview:_captureViewInformationsLabel];
    [self addSubview:_trainingsViewInformationsLabel];
    [self addSubview:_playersViewInformationsLabel];
}

- (void)prepareForUse
{
    [self prepareView];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, 2.0f);
    CGContextMoveToPoint(context,  rect.size.width / 2, 75);
    CGContextAddLineToPoint(context, rect.size.width / 2, rect.size.height - 40);
    CGContextStrokePath(context);
}

@end
