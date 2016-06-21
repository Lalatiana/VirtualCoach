//
//  UIAxis.m
//  VirtualCoach
//
//  Created by Bi ZORO on 15/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIAxis.h"

@implementation UIAxis

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame axis:nil];
}

- (instancetype)initWithFrame:(CGRect)frameRect axis:(Axis *)axis
{
    self = [super initWithFrame:frameRect];
    
    if (self)
    {
        _axis = axis;
        
        _titleUnit = [NSNumber numberWithInt:1];
        _lineColor = [UIColor blackColor];
        _lineWidth = [NSNumber numberWithInt:1];
        _unitSeparatorLineLength = [NSNumber numberWithInt:5];
        _titleInterval = [NSNumber numberWithInt:1];
    }
    
    return self;
}

- (void)drawRect:(CGRect)dirtyRect
{
    [super drawRect:dirtyRect];
}

- (void)undraw
{
    
}

@end
