//
//  UITrainingView.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 22/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UITrainingView.h"

@implementation UITrainingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _trainingsTableView = [[UITableView alloc] init];
        _playersTableView = [[UITableView alloc] init];
        _videosTableView = [[UITableView alloc] init];
        
        _recordingViewButton = [[UIBaseButton alloc] init];
        _processAllVideosButton = [[UIBaseButton alloc] init];
        _addPlayerToTrainingButton = [[UIBaseButton alloc] init];
        _removeSelectedPlayerButton = [[UIBaseButton alloc] init];
        
        _trainingsPanelLabel = [[UIBaseLabel alloc] init];
        _videosPanelLabel = [[UIBaseLabel alloc] init];
        _playersPanelLabel = [[UIBaseLabel alloc] init];
        
        _processVideoProgressView = [[UIProcessProgressView alloc] init];
        _multipleProcessVideoProgressView = [[UIMultipleProcessProgressView alloc] init];
    }
    
    return self;
}

- (void)prepareView
{
    CGFloat defaultMargin = 40.f;
    
    // setting table views
    
    CGPoint trainingsTableViewOrigin = CGPointMake(defaultMargin, defaultMargin + 75);
    CGSize trainingsTableViewSize = CGSizeMake(400, self.frame.size.height - (trainingsTableViewOrigin.y + defaultMargin));
    
    [_trainingsTableView setFrame:CGRectMake(trainingsTableViewOrigin.x, trainingsTableViewOrigin.y, trainingsTableViewSize.width, trainingsTableViewSize.height)];
    [_trainingsTableView setScrollEnabled:YES];
    [_trainingsTableView setBackgroundColor:[UIColor clearColor]];
    _trainingsTableView.layer.borderColor = [UIColor whiteColor].CGColor;
    _trainingsTableView.layer.borderWidth = 1.0f;
    
    // ugly fix for fucking table view
    _trainingsTableView.contentInset = UIEdgeInsetsMake(-50, 0, 0, 0);
    
    CGSize videosTableViewSize = CGSizeMake(400, 300);
    CGPoint videosTableViewOrigin = CGPointMake(self.frame.size.width - (defaultMargin + videosTableViewSize.width), self.frame.size.height - (defaultMargin + videosTableViewSize.height));
    
    [_videosTableView setFrame:CGRectMake(videosTableViewOrigin.x, videosTableViewOrigin.y, videosTableViewSize.width, videosTableViewSize.height)];
    [_videosTableView setScrollEnabled:YES];
    [_videosTableView setAllowsSelection:NO];
    [_videosTableView setBackgroundColor:[UIColor clearColor]];
    _videosTableView.layer.borderColor = [UIColor whiteColor].CGColor;
    _videosTableView.layer.borderWidth = 1.0f;
    
    CGPoint playersTableViewOrigin = CGPointMake(videosTableViewOrigin.x, defaultMargin + 75);
    CGSize playersTableViewSize = CGSizeMake(300, 250);
    
    [_playersTableView setFrame:CGRectMake(playersTableViewOrigin.x, playersTableViewOrigin.y, playersTableViewSize.width, playersTableViewSize.height)];
    [_playersTableView setScrollEnabled:YES];
    [_playersTableView setBackgroundColor:[UIColor clearColor]];
    _playersTableView.layer.borderColor = [UIColor whiteColor].CGColor;
    _playersTableView.layer.borderWidth = 1.0f;
    //_playersTableView.contentInset = UIEdgeInsetsMake(0, 74, 0, 0);
    
    // setting video pane label
    
    CGSize videoPaneLabelSize = CGSizeMake(150, 30);
    CGPoint videoPaneLabelOrigin = CGPointMake(videosTableViewOrigin.x, videosTableViewOrigin.y - defaultMargin);
    
    [_videosPanelLabel setFrame:CGRectMake(videoPaneLabelOrigin.x, videoPaneLabelOrigin.y, videoPaneLabelSize.width, videoPaneLabelSize.height)];
    
    NSMutableAttributedString *videoPaneLabelText = [[NSMutableAttributedString alloc] initWithString:@"Videos"];
    [videoPaneLabelText addAttribute:NSFontAttributeName
                                        value:[UIFont systemFontOfSize:20.0]
                                        range:NSMakeRange(0, [videoPaneLabelText length])];
    [videoPaneLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [videoPaneLabelText length])];
    
    [_videosPanelLabel setAttributedText:videoPaneLabelText];
    
    // setting process all videos button
    
    CGSize processAllVideosButtonSize = CGSizeMake(100, 30);
    CGPoint processAllVideosButtonOrigin = CGPointMake(videoPaneLabelOrigin.x + videoPaneLabelSize.width, videoPaneLabelOrigin.y);
    [_processAllVideosButton setFrame:CGRectMake(processAllVideosButtonOrigin.x, processAllVideosButtonOrigin.y, processAllVideosButtonSize.width, processAllVideosButtonSize.height)];
    
    NSMutableAttributedString *processAllVideosButtonTitle = [[NSMutableAttributedString alloc] initWithString:@"Process all"];
    [processAllVideosButtonTitle addAttribute:NSFontAttributeName
                                        value:[UIFont systemFontOfSize:15.0]
                                        range:NSMakeRange(0, [processAllVideosButtonTitle length])];
    [processAllVideosButtonTitle addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:(0 / 255.f) green:(122 / 255.f) blue:(255 / 255.f) alpha:1.f] range:NSMakeRange(0, [processAllVideosButtonTitle length])];
    
    [_processAllVideosButton setAttributedTitle:processAllVideosButtonTitle forState:UIControlStateNormal];
    
    // setting recording view button
    
    CGSize recordingViewButtonSize = CGSizeMake(150, 30);
    CGPoint recordingViewButtonOrigin = CGPointMake(processAllVideosButtonOrigin.x + processAllVideosButtonSize.width, processAllVideosButtonOrigin.y);
    
    [_recordingViewButton setFrame:CGRectMake(recordingViewButtonOrigin.x, recordingViewButtonOrigin.y, recordingViewButtonSize.width, recordingViewButtonSize.height)];
    
    NSMutableAttributedString *recordingViewButtonTitle = [[NSMutableAttributedString alloc] initWithString:@"Go to recording"];
    [recordingViewButtonTitle addAttribute:NSFontAttributeName
                                     value:[UIFont systemFontOfSize:15.0]
                                     range:NSMakeRange(0, [recordingViewButtonTitle length])];
    [recordingViewButtonTitle addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:(0 / 255.f) green:(122 / 255.f) blue:(255 / 255.f) alpha:1.f] range:NSMakeRange(0, [recordingViewButtonTitle length])];
    
    [_recordingViewButton setAttributedTitle:recordingViewButtonTitle forState:UIControlStateNormal];
    
    // setting players pane label
    
    CGSize playersPaneLabelSize = CGSizeMake(80, 30);
    CGPoint playersPaneLabelOrigin = CGPointMake(playersTableViewOrigin.x, playersTableViewOrigin.y - defaultMargin);
    
    [_playersPanelLabel setFrame:CGRectMake(playersPaneLabelOrigin.x, playersPaneLabelOrigin.y, playersPaneLabelSize.width, playersPaneLabelSize.height)];
    
    NSMutableAttributedString *playersPaneLabelText = [[NSMutableAttributedString alloc] initWithString:@"Players"];
    [playersPaneLabelText addAttribute:NSFontAttributeName
                               value:[UIFont systemFontOfSize:20.0]
                               range:NSMakeRange(0, [playersPaneLabelText length])];
    [playersPaneLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [playersPaneLabelText length])];
    
    [_playersPanelLabel setAttributedText:playersPaneLabelText];
    
    // setting trainings pane label
    
    CGSize trainingsPaneLabelSize = CGSizeMake(90, 30);
    CGPoint trainingsPaneLabelOrigin = CGPointMake(trainingsTableViewOrigin.x, trainingsTableViewOrigin.y - defaultMargin);
    
    [_trainingsPanelLabel setFrame:CGRectMake(trainingsPaneLabelOrigin.x, trainingsPaneLabelOrigin.y, trainingsPaneLabelSize.width, trainingsPaneLabelSize.height)];
    
    NSMutableAttributedString *trainingsPaneLabelText = [[NSMutableAttributedString alloc] initWithString:@"Trainings"];
    [trainingsPaneLabelText addAttribute:NSFontAttributeName
                                 value:[UIFont systemFontOfSize:20.0]
                                 range:NSMakeRange(0, [trainingsPaneLabelText length])];
    [trainingsPaneLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [trainingsPaneLabelText length])];
    
    [_trainingsPanelLabel setAttributedText:trainingsPaneLabelText];
    
    // setting players buttons management
    
    CGSize addPlayerToTrainingSize = CGSizeMake(80, 30);
    CGPoint addPlayerToTrainingOrigin = CGPointMake(playersPaneLabelOrigin.x + playersPaneLabelSize.width, playersPaneLabelOrigin.y);
    [_addPlayerToTrainingButton setFrame:CGRectMake(addPlayerToTrainingOrigin.x, addPlayerToTrainingOrigin.y, addPlayerToTrainingSize.width, addPlayerToTrainingSize.height)];
    
    NSMutableAttributedString *addPlayerToTrainingButtonTitle = [[NSMutableAttributedString alloc] initWithString:@"Add"];
    [addPlayerToTrainingButtonTitle addAttribute:NSFontAttributeName
                                            value:[UIFont systemFontOfSize:15.0]
                                            range:NSMakeRange(0, [addPlayerToTrainingButtonTitle length])];
    [addPlayerToTrainingButtonTitle addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:(0 / 255.f) green:(122 / 255.f) blue:(255 / 255.f) alpha:1.f] range:NSMakeRange(0, [addPlayerToTrainingButtonTitle length])];
    
    [_addPlayerToTrainingButton setAttributedTitle:addPlayerToTrainingButtonTitle forState:UIControlStateNormal];
    
    CGSize removeSelectedPlayerButtonSize = CGSizeMake(80, 30);
    CGPoint removeSelectedPlayerButtonOrigin = CGPointMake(addPlayerToTrainingOrigin.x + addPlayerToTrainingSize.width, addPlayerToTrainingOrigin.y);
    [_removeSelectedPlayerButton setFrame:CGRectMake(removeSelectedPlayerButtonOrigin.x, removeSelectedPlayerButtonOrigin.y, removeSelectedPlayerButtonSize.width, removeSelectedPlayerButtonSize.height)];
    
    NSMutableAttributedString *removeSelectedPlayerButtonTitle = [[NSMutableAttributedString alloc] initWithString:@"Remove"];
    [removeSelectedPlayerButtonTitle addAttribute:NSFontAttributeName
                                           value:[UIFont systemFontOfSize:15.0]
                                           range:NSMakeRange(0, [removeSelectedPlayerButtonTitle length])];
    [removeSelectedPlayerButtonTitle addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:(252 / 255.f) green:(61 / 255.f) blue:(57 / 255.f) alpha:1.f] range:NSMakeRange(0, [removeSelectedPlayerButtonTitle length])];
    
    [_removeSelectedPlayerButton setAttributedTitle:removeSelectedPlayerButtonTitle forState:UIControlStateNormal];
    
    // setting process progress view
    
    CGSize processVideoProgressViewSize = CGSizeMake(350, 150);
    CGPoint processVideoProgressViewOrigin = CGPointMake(([UIScreen mainScreen].bounds.size.width - processVideoProgressViewSize.width) / 2, ([UIScreen mainScreen].bounds.size.height - processVideoProgressViewSize.height) / 2);
    
    [_processVideoProgressView setFrame:CGRectMake(processVideoProgressViewOrigin.x, processVideoProgressViewOrigin.y, processVideoProgressViewSize.width, processVideoProgressViewSize.height)];
    
    // setting multiple process progress view
    
    CGSize multipleProcessVideoProgressViewSize = CGSizeMake(350, (processVideoProgressViewSize.height * 2) - defaultMargin);
    CGPoint multipleProcessVideoProgressViewOrigin = CGPointMake(([UIScreen mainScreen].bounds.size.width - multipleProcessVideoProgressViewSize.width) / 2, ([UIScreen mainScreen].bounds.size.height - multipleProcessVideoProgressViewSize.height) / 2);
    
    [_multipleProcessVideoProgressView setFrame:CGRectMake(multipleProcessVideoProgressViewOrigin.x, multipleProcessVideoProgressViewOrigin.y, multipleProcessVideoProgressViewSize.width, multipleProcessVideoProgressViewSize.height)];
}

- (void)layout
{
    [super layout];
    
    
    
    [self prepareForUse];
    
    [_processVideoProgressView layout];
    [_multipleProcessVideoProgressView layout];
    
    [self addSubview:_trainingsTableView];
    [self addSubview:_playersTableView];
    [self addSubview:_videosTableView];
    [self addSubview:_recordingViewButton];
    [self addSubview:_processAllVideosButton];
    [self addSubview:_videosPanelLabel];
    [self addSubview:_playersPanelLabel];
    [self addSubview:_addPlayerToTrainingButton];
    [self addSubview:_removeSelectedPlayerButton];
    [self addSubview:_trainingsPanelLabel];
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
