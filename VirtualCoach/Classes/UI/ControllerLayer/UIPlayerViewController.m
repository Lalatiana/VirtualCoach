//
//  UIPlayerViewController.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 15/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIPlayerViewController.h"
#import "UITrainingViewController.h"

@interface UIPlayerViewController ()

@property (nonatomic) NSInteger currentDay;
@property (nonatomic) NSInteger currentMonth;
@property (nonatomic) NSInteger currentYear;
@property (nonatomic) NSInteger currentWeekStartDay;
@property (nonatomic) NSInteger currentWeekEndDay;

@property (nonatomic, strong) NSArray *currentOrdinateAxisTitles;

@end

@implementation UIPlayerViewController

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _playerView = [[UIPlayerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        _curveDataPickerViewData = [[NSMutableArray alloc] initWithObjects:@"Forehands", @"Backhands", @"Services", @"Forehands (progress)", @"Backhands (progress)", @"Services (progress)", nil];
        
        _curvePeriodPickerViewData = [[NSMutableArray alloc] initWithObjects:@"Weekly", @"Monthly", @"Yearly", nil];
        
        _curveStylePickerViewData = [[NSMutableArray alloc] initWithObjects:@"Plots", @"Curves", @"Both", nil];
        
        [_playerView.dataPickerView setDelegate:self];
        [_playerView.dataPickerView setDataSource:self];
        
        [_playerView.periodPickerView setDelegate:self];
        [_playerView.periodPickerView setDataSource:self];
        
        [_playerView.stylePickerView setDelegate:self];
        [_playerView.stylePickerView setDataSource:self];
        
        [_playerView.playersTableView setDelegate:self];
        [_playerView.playersTableView setDataSource:self];
        
        [_playerView.trainingsTableView setDelegate:self];
        [_playerView.trainingsTableView setDataSource:self];
        
        self.view = _playerView;
        
        self.navigationItem.title = @"Players";
    }
    
    return self;
}

- (void)prepareForUse
{
    Axis *weeklyAxis = [Axis weeklyAxis];
    
    Axis *motionCountAxis = [Axis motionCountAxis];
    
    CoordinateSystem2D *weeklyCoordinateSystem = [[CoordinateSystem2D alloc] init];
    
    [weeklyCoordinateSystem.axes setObject:weeklyAxis forKey:@"absciss"];
    [weeklyCoordinateSystem.axes setObject:motionCountAxis forKey:@"ordinate"];
    
    [weeklyCoordinateSystem prepare];
    
    [_playerView.coordinateSystemView setCoordinateSystem:weeklyCoordinateSystem];
    
    [_playerView layout];
    
    _playerView.coordinateSystemView.abscissAxis.titles = [DateUtilities dayTitles];
    _currentOrdinateAxisTitles = [NSArray arrayWithObjects:@"100", @"200", @"300", @"400", @"500", @"600", @"700", @"800", @"900", @"1000", nil];
    _playerView.coordinateSystemView.ordinateAxis.titles = _currentOrdinateAxisTitles;
    
    NSInteger day = [DateUtilities currentDay];
    NSInteger month = [DateUtilities currentMonth];
    NSInteger year = [DateUtilities currentYear];
    
    _currentDay = day;
    _currentMonth = month;
    _currentYear = year;
    
    NSDate *selectedDate = [DateUtilities dateWithYear:year month:month day:day];
    NSDictionary *weekStartAndEndDates = [DateUtilities startAndEndDateOfWeekForDate:selectedDate];
    
    NSDate *startDate = [weekStartAndEndDates objectForKey:@"startDate"];
    NSDate *endDate = [weekStartAndEndDates objectForKey:@"endDate"];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:startDate];
    _currentWeekStartDay = [components day];
    components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:endDate];
    _currentWeekEndDay = [components day];
    
    NSLog(@"_currentWeekStartDay : %ld, _currentWeekEndDay : %ld", _currentWeekStartDay, _currentWeekEndDay);
    
    [_playerView.coordinateSystemView setCoordinateSystemTitle:[NSString stringWithFormat:@"%@ - %@", [DateUtilities stringWithDate:startDate], [DateUtilities stringWithDate:endDate]]];
    
    [_playerView.coordinateSystemView draw];
    
    //    Curve *curve = [[Curve alloc] init];
    //
    //        curve.values = [NSOrderedDictionary dictionaryWithObjects:
    //                        [NSArray arrayWithObjects:[NSNumber numberWithInt:516], [NSNumber numberWithInt:327], [NSNull null], [NSNull null], [NSNumber numberWithInt:628], [NSNumber numberWithInt:804], [NSNumber numberWithInt:173], nil]
    //                                                          forKeys:
    //                        _playerView.coordinateSystemView.abscissAxis.titles];
    //
    //
    //        UICurve *uicurve = [[UICurve alloc] initWithFrame:CGRectZero curve:curve];
    //        uicurve.lineColor = [UIColor whiteColor];
    //        uicurve.drawPoints = NO;
    //        uicurve.lineWidth = [NSNumber numberWithFloat:0.3];
    //
    //    [_playerView.coordinateSystemView drawCurve:uicurve];
}

- (void)viewWillAppear:(BOOL)animated
{
    // set table view controller datas
    
    _trainingsTableViewData = [NSMutableArray arrayWithObjects:@"Training1", @"Training2", @"Training3", @"Training4", @"Training5", @"Training6", @"Training7", @"Training8", @"Training9", @"Training10", @"Training11", @"Training12", nil];
    _playersTableViewData = [NSMutableArray arrayWithObjects:@"Joe", @"David", @"Luke", @"Steve P", @"Jeffrey", nil];
    
    _curvesViewPinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(twoFingerPinchOnCurveView:)];
    _curvesViewPinchGestureRecognizer.scale = 1;
    
    _curvesViewLeftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureRecognizerOnCurveView:)];
    _curvesViewLeftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    _curvesViewLeftSwipeGestureRecognizer.numberOfTouchesRequired = 1;
    
    _curvesViewRightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureRecognizerOnCurveView:)];
    _curvesViewRightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    _curvesViewRightSwipeGestureRecognizer.numberOfTouchesRequired = 1;
    
    
    [_playerView.coordinateSystemView addGestureRecognizer:_curvesViewPinchGestureRecognizer];
    [_playerView.coordinateSystemView addGestureRecognizer:_curvesViewLeftSwipeGestureRecognizer];
    [_playerView.coordinateSystemView addGestureRecognizer:_curvesViewRightSwipeGestureRecognizer];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger numberOfRows = -1;
    
    if (pickerView.tag == CURVE_DATA_PICKERVIEW_TAG)
        numberOfRows = [_curveDataPickerViewData count];
    
    else if (pickerView.tag == CURVE_PERIOD_PICKERVIEW_TAG)
        numberOfRows = [_curvePeriodPickerViewData count];
    
    else if (pickerView.tag == CURVE_STYLE_PICKERVIEW_TAG)
        numberOfRows = [_curveStylePickerViewData count];
    
    return numberOfRows;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView.tag == CURVE_DATA_PICKERVIEW_TAG)
    {
        NSLog(@"You selected this: %@", [_curveDataPickerViewData objectAtIndex:row]);
        
        NSString *selectedValue = [_curveDataPickerViewData objectAtIndex:row];
        
        Axis *ordinateAxis = nil;
        
        if ([selectedValue rangeOfString:@"progress"].location == NSNotFound)
        {
            ordinateAxis = [Axis motionCountAxis];
            
            _currentOrdinateAxisTitles = [NSArray arrayWithObjects:@"100", @"200", @"300", @"400", @"500", @"600", @"700", @"800", @"900", @"1000", nil];
            
            if ([selectedValue isEqualToString:@"Forehands"])
            {
                
            }
            
            else if ([selectedValue isEqualToString:@"Backhands"])
            {
                
            }
            
            else if ([selectedValue isEqualToString:@"Services"])
            {
                
            }
        }
        
        else
        {
            ordinateAxis = [Axis progressAxis];
            
            _currentOrdinateAxisTitles = [NSArray arrayWithObjects:@"10%", @"20%", @"30%", @"40%", @"50%", @"60%", @"70%", @"80%", @"90%", @"100%", nil];
            
            if ([selectedValue isEqualToString:@"Forehands (progress)"])
            {
                
            }
            
            else if ([selectedValue isEqualToString:@"Backhands (progress)"])
            {
                
            }
            
            else if ([selectedValue isEqualToString:@"Services (progress)"])
            {
                
            }
        }
        
        [_playerView.coordinateSystemView.coordinateSystem.axes setObject:ordinateAxis forKey:@"ordinate"];
        
        _playerView.coordinateSystemView.ordinateAxis.titles = _currentOrdinateAxisTitles;
        
        [_playerView.coordinateSystemView refreshCoordinateSystem];
        
        [_playerView.coordinateSystemView undraw];
        [_playerView.coordinateSystemView draw];
    }
    
    else if (pickerView.tag == CURVE_PERIOD_PICKERVIEW_TAG)
    {
        if ([[_curvePeriodPickerViewData objectAtIndex:row] isEqualToString:@"Weekly"])
        {
            Axis *weeklyAxis = [Axis weeklyAxis];
            
            [_playerView.coordinateSystemView.coordinateSystem.axes setObject:weeklyAxis forKey:@"absciss"];
            
            [_playerView.coordinateSystemView refreshCoordinateSystem];
            
            _playerView.coordinateSystemView.abscissAxis.titles = [DateUtilities dayTitles];
            //_playerView.coordinateSystemView.ordinateAxis.titles = _currentOrdinateAxisTitles;
            
            [_playerView.coordinateSystemView undraw];
            
            NSDate *selectedDate = [DateUtilities dateWithYear:_currentYear month:_currentMonth day:_currentDay];
            NSDictionary *weekStartAndEndDates = [DateUtilities startAndEndDateOfWeekForDate:selectedDate];
            
            NSDate *startDate = [weekStartAndEndDates objectForKey:@"startDate"];
            NSDate *endDate = [weekStartAndEndDates objectForKey:@"endDate"];
            
            [_playerView.coordinateSystemView setCoordinateSystemTitle:[NSString stringWithFormat:@"%@ - %@", [DateUtilities stringWithDate:startDate], [DateUtilities stringWithDate:endDate]]];
            
            [_playerView.coordinateSystemView draw];
        }
        
        else if ([[_curvePeriodPickerViewData objectAtIndex:row] isEqualToString:@"Monthly"])
        {
            Axis *monthlyAxis = [Axis monthlyAxisForMonth:_currentMonth];
            
            [_playerView.coordinateSystemView.coordinateSystem.axes setObject:monthlyAxis forKey:@"absciss"];
            
            [_playerView.coordinateSystemView refreshCoordinateSystem];
            
            _playerView.coordinateSystemView.abscissAxis.titles = [DateUtilities dayTitlesForMonth:_currentMonth];
            //_playerView.coordinateSystemView.ordinateAxis.titles = _currentOrdinateAxisTitles;
            
            [_playerView.coordinateSystemView undraw];
            
            [_playerView.coordinateSystemView setCoordinateSystemTitle:[DateUtilities monthFullTitle:_currentMonth forYear:_currentYear]];
            
            [_playerView.coordinateSystemView draw];
        }
        
        else if ([[_curvePeriodPickerViewData objectAtIndex:row] isEqualToString:@"Yearly"])
        {
            Axis *yearlyAxis = [Axis yearlyAxis];
            
            [_playerView.coordinateSystemView.coordinateSystem.axes setObject:yearlyAxis forKey:@"absciss"];
            
            [_playerView.coordinateSystemView refreshCoordinateSystem];
            
            _playerView.coordinateSystemView.abscissAxis.titles = [DateUtilities monthTitles];
            //_playerView.coordinateSystemView.ordinateAxis.titles = _currentOrdinateAxisTitles;
            
            [_playerView.coordinateSystemView undraw];
            
            [_playerView.coordinateSystemView setCoordinateSystemTitle:[DateUtilities yearFullTitle:_currentYear]];
            
            [_playerView.coordinateSystemView draw];
        }
    }
    
    
    else if (pickerView.tag == CURVE_STYLE_PICKERVIEW_TAG)
    {
        NSMutableArray *drawnCurvesArray = [NSMutableArray array];
        
        BOOL drawPoints = NO;
        BOOL drawLine = NO;
        
        for (UIView *subview in _playerView.coordinateSystemView.subviews)
        {
            if ([subview isMemberOfClass:[UICurve class]])
                [drawnCurvesArray addObject:subview];
        }
        
        if ([[_curveStylePickerViewData objectAtIndex:row] isEqualToString:@"Plots"])
        {
            drawPoints = YES;
            drawLine = NO;
        }
        
        
        else if ([[_curveStylePickerViewData objectAtIndex:row] isEqualToString:@"Curves"])
        {
            drawPoints = NO;
            drawLine = YES;
        }
        
        else if ([[_curveStylePickerViewData objectAtIndex:row] isEqualToString:@"Both"])
        {
            drawPoints = YES;
            drawLine = YES;
        }
        
        for (UICurve *curve in drawnCurvesArray)
        {
            [_playerView.coordinateSystemView removeCurve:curve];
            [curve undraw];
            curve.drawLine = drawLine;
            curve.drawPoints = drawPoints;
            [_playerView.coordinateSystemView drawCurve:curve];
        }
    }
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    NSString *rowItem = @"";
    
    if (pickerView.tag == CURVE_DATA_PICKERVIEW_TAG)
        rowItem = [_curveDataPickerViewData objectAtIndex:row];
    
    else if (pickerView.tag == CURVE_PERIOD_PICKERVIEW_TAG)
        rowItem = [_curvePeriodPickerViewData objectAtIndex:row];
    
    else if (pickerView.tag == CURVE_STYLE_PICKERVIEW_TAG)
        rowItem = [_curveStylePickerViewData objectAtIndex:row];
    
    UILabel *lblRow = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView bounds].size.width, 44.0f)];
    [lblRow setTextAlignment:NSTextAlignmentCenter];
    [lblRow setTextColor: [UIColor whiteColor]];
    [lblRow setText:rowItem];
    [lblRow setBackgroundColor:[UIColor clearColor]];
    
    return lblRow;
}


//

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *cellText = cell.textLabel.text;
    
    
    if (tableView.tag == TRAININGS_TABLEVIEW_TAG)
    {
        /** Example code to reload data according to a selection
         
         NSLog(@"Cell from TRAININGS TABLE CELL VIEW WAS SELECTED");
         
         _playersTableViewData = @[@"Training1Player1", @"Training1Player2", @"Training1Player3", @"Training1Player4"];
         _videosTableViewData = @[@"2016-05-25_11.00.47", @"2016-05-25_11.27.59", @"2016-06-05_10.10.07", @"2016-06-05_10.24.25"];
         
         [_trainingView.playersTableView reloadData];
         [_trainingView.videosTableView reloadData];
         
         **/
    }
    
    else if (tableView.tag == PLAYERS_TABLEVIEW_TAG)
    {
        NSDictionary *attributes = [(NSAttributedString *)_playerView.playerNameLabel.attributedText attributesAtIndex:0 effectiveRange:NULL];
        _playerView.playerNameLabel.attributedText = [[NSAttributedString alloc] initWithString:cellText attributes:attributes];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = -1;
    
    if (tableView.tag == TRAININGS_TABLEVIEW_TAG)
        numberOfRows = _trainingsTableViewData.count;
    
    else if (tableView.tag == PLAYERS_TABLEVIEW_TAG)
        numberOfRows = _playersTableViewData.count;
    
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell)
        cell = nil;
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        [cell.detailTextLabel setTextColor:[UIColor whiteColor]];
        [cell.detailTextLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [cell.detailTextLabel setNumberOfLines:0];
        [cell setBackgroundColor:[UIColor clearColor]];
    }
    
    if (tableView.tag == TRAININGS_TABLEVIEW_TAG)
    {
        [cell.textLabel setText:[_trainingsTableViewData objectAtIndex:indexPath.row]];
        [cell.detailTextLabel setText:@"Date: 00/00/9999\nLocation: Cergy-Pontoise"];
    }
    
    else if (tableView.tag == PLAYERS_TABLEVIEW_TAG)
    {
        [cell.textLabel setText:[_playersTableViewData objectAtIndex:indexPath.row]];
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 44.f;
    
    if (tableView.tag == TRAININGS_TABLEVIEW_TAG)
    {
        height += 40;
    }
    
    else if (tableView.tag == PLAYERS_TABLEVIEW_TAG)
    {
        height += 30;
    }
    
    return height;
}

- (void)twoFingerPinchOnCurveView:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    CGPoint point = [pinchGestureRecognizer locationInView:_playerView.coordinateSystemView];
    
    BOOL isYearlyCoordinateSystem = _playerView.coordinateSystemView.abscissAxis.titles.count == 12 ? YES : NO;
    BOOL isWeeklyCoordinateSystem = _playerView.coordinateSystemView.abscissAxis.titles.count == 7 ? YES : NO;
    BOOL isMonthlyCoordinateSystem = _playerView.coordinateSystemView.abscissAxis.titles.count != 12 && _playerView.coordinateSystemView.abscissAxis.titles.count != 7 ? YES : NO;
    
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        if (pinchGestureRecognizer.scale > 1)   // pinch out
        {
            NSString *winningTitle = [UICoordinateSystem2DUtilities titleForTouchLocation:point inCoordinateSystem:_playerView.coordinateSystemView];
            
            if (isYearlyCoordinateSystem) // if yearly coordinate system is displayed (yearly => monthly)
            {
                // do some stuff with curves, the following just changes the coordinate system
                
                _currentMonth = [DateUtilities monthForTitle:winningTitle];
                
                Axis *monthlyAxis = [Axis monthlyAxisForMonth:_currentMonth];
                
                [_playerView.coordinateSystemView.coordinateSystem.axes setObject:monthlyAxis forKey:@"absciss"];
                
                [_playerView.coordinateSystemView refreshCoordinateSystem];
                
                _playerView.coordinateSystemView.abscissAxis.titles = [DateUtilities dayTitlesForMonth:_currentMonth];
                
                [_playerView.coordinateSystemView undraw];
                
                [_playerView.coordinateSystemView setCoordinateSystemTitle:[DateUtilities monthFullTitle:_currentMonth forYear:_currentYear]];
                
                [_playerView.coordinateSystemView draw];
                
                [_playerView.periodPickerView selectRow:1 inComponent:0 animated:YES];
            }
            
            else if (isMonthlyCoordinateSystem) // if monthly coordinate system is displayed (monthly => weekly)
            {
                // do some stuff with curves, the following just changes the coordinate system
                
                Axis *weeklyAxis = [Axis weeklyAxis];
                
                [_playerView.coordinateSystemView.coordinateSystem.axes setObject:weeklyAxis forKey:@"absciss"];
                
                [_playerView.coordinateSystemView refreshCoordinateSystem];
                
                _playerView.coordinateSystemView.abscissAxis.titles = [DateUtilities dayTitles];
                
                [_playerView.coordinateSystemView undraw];
                
                // find week start and end date
                
                _currentDay = [winningTitle intValue];
                
                NSDate *selectedDate = [DateUtilities dateWithYear:_currentYear month:_currentMonth day:_currentDay];
                NSDictionary *weekStartAndEndDates = [DateUtilities startAndEndDateOfWeekForDate:selectedDate];
                
                NSDate *startDate = [weekStartAndEndDates objectForKey:@"startDate"];
                NSDate *endDate = [weekStartAndEndDates objectForKey:@"endDate"];
                
                NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:startDate];
                _currentWeekStartDay = [components day];
                components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:endDate];
                _currentWeekEndDay = [components day];
                
                [_playerView.coordinateSystemView setCoordinateSystemTitle:[NSString stringWithFormat:@"%@ - %@", [DateUtilities stringWithDate:startDate], [DateUtilities stringWithDate:endDate]]];
                
                [_playerView.coordinateSystemView draw];
                
                [_playerView.periodPickerView selectRow:0 inComponent:0 animated:YES];
            }
        }
        
        else    // pinch in
        {
            if (isWeeklyCoordinateSystem) // if weekly coordinate system is displayed (weekly => monthly)
            {
                // do some stuff with curves, the following just changes the coordinate system
                
                Axis *monthlyAxis = [Axis monthlyAxisForMonth:_currentMonth];
                
                [_playerView.coordinateSystemView.coordinateSystem.axes setObject:monthlyAxis forKey:@"absciss"];
                
                [_playerView.coordinateSystemView refreshCoordinateSystem];
                
                _playerView.coordinateSystemView.abscissAxis.titles = [DateUtilities dayTitlesForMonth:_currentMonth];
                
                [_playerView.coordinateSystemView undraw];
                
                [_playerView.coordinateSystemView setCoordinateSystemTitle:[DateUtilities monthFullTitle:_currentMonth forYear:_currentYear]];
                
                [_playerView.coordinateSystemView draw];
                
                [_playerView.periodPickerView selectRow:1 inComponent:0 animated:YES];
            }
            
            else if (isMonthlyCoordinateSystem) // if monthly coordinate system is displayed (monthly => yearly)
            {
                // do some stuff with curves, the following just changes the coordinate system
                
                Axis *yearlyAxis = [Axis yearlyAxis];
                
                [_playerView.coordinateSystemView.coordinateSystem.axes setObject:yearlyAxis forKey:@"absciss"];
                
                [_playerView.coordinateSystemView refreshCoordinateSystem];
                
                _playerView.coordinateSystemView.abscissAxis.titles = [DateUtilities monthTitles];
                
                [_playerView.coordinateSystemView undraw];
                
                [_playerView.coordinateSystemView setCoordinateSystemTitle:[DateUtilities yearFullTitle:_currentYear]];
                
                [_playerView.coordinateSystemView draw];
                
                [_playerView.periodPickerView selectRow:2 inComponent:0 animated:YES];
            }
        }
    }
}

- (void)swipeGestureRecognizerOnCurveView:(UISwipeGestureRecognizer *)swipeGestureRecognizer;
{
    BOOL isYearlyCoordinateSystem = _playerView.coordinateSystemView.abscissAxis.titles.count == 12 ? YES : NO;
    BOOL isWeeklyCoordinateSystem = _playerView.coordinateSystemView.abscissAxis.titles.count == 7 ? YES : NO;
    BOOL isMonthlyCoordinateSystem = _playerView.coordinateSystemView.abscissAxis.titles.count != 12 && _playerView.coordinateSystemView.abscissAxis.titles.count != 7 ? YES : NO;
    
    if (swipeGestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        if (swipeGestureRecognizer == _curvesViewLeftSwipeGestureRecognizer) // left swipe (we go in the future)
        {
            NSLog(@"Left swipe");
            
            if (isWeeklyCoordinateSystem) // some bugs when we change the year
            {
                NSDate *startDate = [DateUtilities dateWithYear:_currentYear month:_currentMonth day:_currentWeekStartDay];
                
                NSCalendar *cal = [NSCalendar currentCalendar];
                NSDate *tomorrow = [cal dateByAddingUnit:NSCalendarUnitDay
                                                   value:7
                                                  toDate:startDate
                                                 options:0];
                
                NSDictionary *startAndEndOfWeekDates = [DateUtilities startAndEndDateOfWeekForDate:tomorrow];
                
                NSDate *nextStartDate = [startAndEndOfWeekDates objectForKey:@"startDate"];
                NSDate *nextEndDate = [startAndEndOfWeekDates objectForKey:@"endDate"];
                
                NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:nextStartDate];
                _currentYear = [components year];
                _currentMonth = [components month];
                _currentWeekStartDay = [components day];
                components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:nextEndDate];
                _currentWeekEndDay = [components day];
                
                [_playerView.coordinateSystemView undraw];
                
                [_playerView.coordinateSystemView setCoordinateSystemTitle:[NSString stringWithFormat:@"%@ - %@", [DateUtilities stringWithDate:nextStartDate], [DateUtilities stringWithDate:nextEndDate]]];
                
                [_playerView.coordinateSystemView draw];
            }
            
            else if (isMonthlyCoordinateSystem)
            {
                if (_currentMonth < 12)
                {
                    _currentMonth++;
                }
                
                else
                {
                    _currentMonth = 1;
                    _currentYear++;
                }
                
                Axis *monthlyAxis = [Axis monthlyAxisForMonth:_currentMonth];
                
                [_playerView.coordinateSystemView.coordinateSystem.axes setObject:monthlyAxis forKey:@"absciss"];
                
                [_playerView.coordinateSystemView refreshCoordinateSystem];
                
                _playerView.coordinateSystemView.abscissAxis.titles = [DateUtilities dayTitlesForMonth:_currentMonth];
                
                [_playerView.coordinateSystemView undraw];
                
                [_playerView.coordinateSystemView setCoordinateSystemTitle:[DateUtilities monthFullTitle:_currentMonth forYear:_currentYear]];
                
                [_playerView.coordinateSystemView draw];
            }
            
            else if (isYearlyCoordinateSystem)
            {
                _currentYear++;
                
                [_playerView.coordinateSystemView undraw];
                
                [_playerView.coordinateSystemView setCoordinateSystemTitle:[DateUtilities yearFullTitle:_currentYear]];
                
                [_playerView.coordinateSystemView draw];
            }
        }
        
        else if (swipeGestureRecognizer == _curvesViewRightSwipeGestureRecognizer) // right swipe (we go in the past)
        {
            NSLog(@"Right swipe");
            
            if (isWeeklyCoordinateSystem) // big bug when we try to move on previous year
            {
                NSDate *endDate = [DateUtilities dateWithYear:_currentYear month:_currentMonth day:_currentWeekEndDay];
                
                NSCalendar *cal = [NSCalendar currentCalendar];
                NSDate *yesterday = [cal dateByAddingUnit:NSCalendarUnitDay
                                                   value:-7
                                                  toDate:endDate
                                                 options:0];
                
                NSDictionary *startAndEndOfWeekDates = [DateUtilities startAndEndDateOfWeekForDate:yesterday];
                
                NSDate *beforeStartDate = [startAndEndOfWeekDates objectForKey:@"startDate"];
                NSDate *beforeEndDate = [startAndEndOfWeekDates objectForKey:@"endDate"];
                
                NSLog(@"beforeStartDate : %@", beforeStartDate);
                NSLog(@"beforeEndDate : %@", beforeEndDate);
                
                NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:beforeEndDate];
                _currentYear = [components year];
                _currentMonth = [components month];
                _currentWeekEndDay = [components day];
                components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:beforeStartDate];
                _currentWeekStartDay = [components day];
                
                [_playerView.coordinateSystemView undraw];
                
                [_playerView.coordinateSystemView setCoordinateSystemTitle:[NSString stringWithFormat:@"%@ - %@", [DateUtilities stringWithDate:beforeStartDate], [DateUtilities stringWithDate:beforeEndDate]]];
                
                [_playerView.coordinateSystemView draw];
            }
            
            else if (isMonthlyCoordinateSystem)
            {
                if (_currentMonth > 1)
                {
                    _currentMonth--;
                }
                
                else
                {
                    _currentMonth = 12;
                    _currentYear--;
                }
                
                Axis *monthlyAxis = [Axis monthlyAxisForMonth:_currentMonth];
                
                [_playerView.coordinateSystemView.coordinateSystem.axes setObject:monthlyAxis forKey:@"absciss"];
                
                [_playerView.coordinateSystemView refreshCoordinateSystem];
                
                _playerView.coordinateSystemView.abscissAxis.titles = [DateUtilities dayTitlesForMonth:_currentMonth];
                
                [_playerView.coordinateSystemView undraw];
                
                [_playerView.coordinateSystemView setCoordinateSystemTitle:[DateUtilities monthFullTitle:_currentMonth forYear:_currentYear]];
                
                [_playerView.coordinateSystemView draw];
            }
            
            else if (isYearlyCoordinateSystem)
            {
                _currentYear--;
                
                [_playerView.coordinateSystemView undraw];
                
                [_playerView.coordinateSystemView setCoordinateSystemTitle:[DateUtilities yearFullTitle:_currentYear]];
                
                [_playerView.coordinateSystemView draw];
            }
        }
    }
}

@end
