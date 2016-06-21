//
//  UIProfileView.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 19/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIProfileView.h"

@implementation UIProfileView

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _informationsPaneLabel = [[UIBaseLabel alloc] init];
        
        _referenceMotionsPaneLabel = [[UIBaseLabel alloc] init];
        _referenceMotionsTableView = [[UITableView alloc] init];
        
        _processAllReferenceMotionsButton = [[UIBaseButton alloc] init];
        _goToRecordingViewButton = [[UIBaseButton alloc] init];
        
        _nameTextField = [[UIBaseTextField alloc] init];
        _nameTextFieldLabel = [[UIBaseLabel alloc] init];
        
        _firstNameTextField = [[UIBaseTextField alloc] init];
        _firstNameTextFieldLabel = [[UIBaseLabel alloc] init];
        
        _changePasswordPaneLabel = [[UIBaseLabel alloc] init];
        
        _oldPasswordTextFieldLabel = [[UIBaseLabel alloc] init];
        _oldPasswordTextField = [[UIBaseTextField alloc] init];
        
        _passwordNewTextFieldLabel = [[UIBaseLabel alloc] init];
        _passwordNewTextField = [[UIBaseTextField alloc] init];
        
        _passwordNewAgainTextFieldLabel = [[UIBaseLabel alloc] init];
        _passwordNewAgainTextField = [[UIBaseTextField alloc] init];
        
        _saveModificationsButton = [[UIBaseButton alloc] init];
        
        _selectedForehandReferenceMotionLabel = [[UIBaseLabel alloc] init];
        _forehandReferenceMotionPickerView = [[UIPickerView alloc] init];
        
        _selectedBackhandReferenceMotionLabel = [[UIBaseLabel alloc] init];
        _backhandReferenceMotionPickerView = [[UIPickerView alloc] init];
        
        _selectedServiceReferenceMotionLabel = [[UIBaseLabel alloc] init];
        _serviceReferenceMotionPickerView = [[UIPickerView alloc] init];
    }
    
    return self;
}

- (void)prepareView
{
    CGFloat defaultMargin = 40.f;
    
    CGSize referenceMotionsTableViewSize = CGSizeMake(400, self.frame.size.height / 2 - defaultMargin);
    CGPoint referenceMotionsTableViewOrigin = CGPointMake(self.frame.size.width - defaultMargin - referenceMotionsTableViewSize.width, defaultMargin + 75);
    
    [_referenceMotionsTableView setFrame:CGRectMake(referenceMotionsTableViewOrigin.x, referenceMotionsTableViewOrigin.y, referenceMotionsTableViewSize.width, referenceMotionsTableViewSize.height)];
    [_referenceMotionsTableView setScrollEnabled:YES];
    [_referenceMotionsTableView setAllowsSelection:NO];
    [_referenceMotionsTableView setBackgroundColor:[UIColor clearColor]];
    _referenceMotionsTableView.layer.borderColor = [UIColor whiteColor].CGColor;
    _referenceMotionsTableView.layer.borderWidth = 1.0f;
    
    // ugly fix for fucking table view
    _referenceMotionsTableView.contentInset = UIEdgeInsetsMake(-50, 0, 0, 0);
    
    CGSize selectedForehandReferenceMotionLabelSize = CGSizeMake(190, 30);
    CGPoint selectedForehandReferenceMotionLabelOrigin = CGPointMake(referenceMotionsTableViewOrigin.x, referenceMotionsTableViewOrigin.y + referenceMotionsTableViewSize.height + defaultMargin);
    
    [_selectedForehandReferenceMotionLabel setFrame:CGRectMake(selectedForehandReferenceMotionLabelOrigin.x, selectedForehandReferenceMotionLabelOrigin.y, selectedForehandReferenceMotionLabelSize.width, selectedForehandReferenceMotionLabelSize.height)];
    
    NSMutableAttributedString *selectedForehandReferenceMotionLabelText = [[NSMutableAttributedString alloc] initWithString:@"Reference forehand: "];
    [selectedForehandReferenceMotionLabelText addAttribute:NSFontAttributeName
                                               value:[UIFont systemFontOfSize:18.0]
                                               range:NSMakeRange(0, [selectedForehandReferenceMotionLabelText length])];
    [selectedForehandReferenceMotionLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [selectedForehandReferenceMotionLabelText length])];
    
    [_selectedForehandReferenceMotionLabel setAttributedText:selectedForehandReferenceMotionLabelText];
    
    CGPoint forehandReferenceMotionPickerViewOrigin = CGPointMake(selectedForehandReferenceMotionLabelOrigin.x + selectedForehandReferenceMotionLabelSize.width, selectedForehandReferenceMotionLabelOrigin.y );
    CGSize forehandReferenceMotionPickerViewSize = CGSizeMake(200, 50);
    
    [_forehandReferenceMotionPickerView setFrame:CGRectMake(forehandReferenceMotionPickerViewOrigin.x, forehandReferenceMotionPickerViewOrigin.y, forehandReferenceMotionPickerViewSize.width, forehandReferenceMotionPickerViewSize.height)];
    _forehandReferenceMotionPickerView.showsSelectionIndicator = YES;
    _forehandReferenceMotionPickerView.layer.borderColor = [UIColor whiteColor].CGColor;
    _forehandReferenceMotionPickerView.layer.borderWidth = 1;
    [_forehandReferenceMotionPickerView selectRow:0 inComponent:0 animated:YES];
    _forehandReferenceMotionPickerView.tag = REFERENCE_FOREHAND_PICKERVIEW_TAG;
    
    CGSize selectedBackhandReferenceMotionLabelSize = CGSizeMake(selectedForehandReferenceMotionLabelSize.width, 30);
    CGPoint selectedBackhandReferenceMotionLabelOrigin = CGPointMake(selectedForehandReferenceMotionLabelOrigin.x, selectedForehandReferenceMotionLabelOrigin.y + selectedForehandReferenceMotionLabelSize.height + defaultMargin);
    
    [_selectedBackhandReferenceMotionLabel setFrame:CGRectMake(selectedBackhandReferenceMotionLabelOrigin.x, selectedBackhandReferenceMotionLabelOrigin.y, selectedBackhandReferenceMotionLabelSize.width, selectedBackhandReferenceMotionLabelSize.height)];
    
    NSMutableAttributedString *selectedBackhandReferenceMotionLabelText = [[NSMutableAttributedString alloc] initWithString:@"Reference backhand: "];
    [selectedBackhandReferenceMotionLabelText addAttribute:NSFontAttributeName
                                                     value:[UIFont systemFontOfSize:18.0]
                                                     range:NSMakeRange(0, [selectedBackhandReferenceMotionLabelText length])];
    [selectedBackhandReferenceMotionLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [selectedBackhandReferenceMotionLabelText length])];
    
    [_selectedBackhandReferenceMotionLabel setAttributedText:selectedBackhandReferenceMotionLabelText];
    
    CGPoint backhandReferenceMotionPickerViewOrigin = CGPointMake(selectedBackhandReferenceMotionLabelOrigin.x + selectedBackhandReferenceMotionLabelSize.width, selectedBackhandReferenceMotionLabelOrigin.y );
    CGSize backhandReferenceMotionPickerViewSize = CGSizeMake(forehandReferenceMotionPickerViewSize.width, 50);
    
    [_backhandReferenceMotionPickerView setFrame:CGRectMake(backhandReferenceMotionPickerViewOrigin.x, backhandReferenceMotionPickerViewOrigin.y, backhandReferenceMotionPickerViewSize.width, backhandReferenceMotionPickerViewSize.height)];
    _backhandReferenceMotionPickerView.showsSelectionIndicator = YES;
    _backhandReferenceMotionPickerView.layer.borderColor = [UIColor whiteColor].CGColor;
    _backhandReferenceMotionPickerView.layer.borderWidth = 1;
    [_backhandReferenceMotionPickerView selectRow:0 inComponent:0 animated:YES];
    _backhandReferenceMotionPickerView.tag = REFERENCE_BACKHAND_PICKERVIEW_TAG;
    
    CGSize selectedServiceReferenceMotionLabelSize = CGSizeMake(selectedForehandReferenceMotionLabelSize.width, 30);
    CGPoint selectedServiceReferenceMotionLabelOrigin = CGPointMake(selectedBackhandReferenceMotionLabelOrigin.x, selectedBackhandReferenceMotionLabelOrigin.y + selectedBackhandReferenceMotionLabelSize.height + defaultMargin);
    
    [_selectedServiceReferenceMotionLabel setFrame:CGRectMake(selectedServiceReferenceMotionLabelOrigin.x, selectedServiceReferenceMotionLabelOrigin.y, selectedServiceReferenceMotionLabelSize.width, selectedServiceReferenceMotionLabelSize.height)];
    
    NSMutableAttributedString *selectedServiceReferenceMotionLabelText = [[NSMutableAttributedString alloc] initWithString:@"Reference service: "];
    [selectedServiceReferenceMotionLabelText addAttribute:NSFontAttributeName
                                                     value:[UIFont systemFontOfSize:18.0]
                                                     range:NSMakeRange(0, [selectedServiceReferenceMotionLabelText length])];
    [selectedServiceReferenceMotionLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [selectedServiceReferenceMotionLabelText length])];
    
    [_selectedServiceReferenceMotionLabel setAttributedText:selectedServiceReferenceMotionLabelText];
    
    CGPoint serviceReferenceMotionPickerViewOrigin = CGPointMake(selectedServiceReferenceMotionLabelOrigin.x + selectedServiceReferenceMotionLabelSize.width, selectedServiceReferenceMotionLabelOrigin.y );
    CGSize serviceReferenceMotionPickerViewSize = CGSizeMake(forehandReferenceMotionPickerViewSize.width, 50);
    
    [_serviceReferenceMotionPickerView setFrame:CGRectMake(serviceReferenceMotionPickerViewOrigin.x, serviceReferenceMotionPickerViewOrigin.y, serviceReferenceMotionPickerViewSize.width, serviceReferenceMotionPickerViewSize.height)];
    _serviceReferenceMotionPickerView.showsSelectionIndicator = YES;
    _serviceReferenceMotionPickerView.layer.borderColor = [UIColor whiteColor].CGColor;
    _serviceReferenceMotionPickerView.layer.borderWidth = 1;
    [_serviceReferenceMotionPickerView selectRow:0 inComponent:0 animated:YES];
    _serviceReferenceMotionPickerView.tag = REFERENCE_SERVICE_PICKERVIEW_TAG;
    
    CGSize referenceMotionsPaneLabelSize = CGSizeMake(170, 30);
    CGPoint referenceMotionsPaneLabelOrigin = CGPointMake(referenceMotionsTableViewOrigin.x, referenceMotionsTableViewOrigin.y - defaultMargin);
    
    [_referenceMotionsPaneLabel setFrame:CGRectMake(referenceMotionsPaneLabelOrigin.x, referenceMotionsPaneLabelOrigin.y, referenceMotionsPaneLabelSize.width, referenceMotionsPaneLabelSize.height)];
    
    NSMutableAttributedString *referenceMotionsPaneLabelText = [[NSMutableAttributedString alloc] initWithString:@"Reference motions"];
    [referenceMotionsPaneLabelText addAttribute:NSFontAttributeName
                               value:[UIFont systemFontOfSize:20.0]
                               range:NSMakeRange(0, [referenceMotionsPaneLabelText length])];
    [referenceMotionsPaneLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [referenceMotionsPaneLabelText length])];
    
    [_referenceMotionsPaneLabel setAttributedText:referenceMotionsPaneLabelText];
    
    // setting process all videos button
    
    CGSize processAllReferenceVideosButtonSize = CGSizeMake(100, 30);
    CGPoint processAllReferenceVideosButtonOrigin = CGPointMake(referenceMotionsPaneLabelOrigin.x + referenceMotionsPaneLabelSize.width, referenceMotionsPaneLabelOrigin.y);
    [_processAllReferenceMotionsButton setFrame:CGRectMake(processAllReferenceVideosButtonOrigin.x, processAllReferenceVideosButtonOrigin.y, processAllReferenceVideosButtonSize.width, processAllReferenceVideosButtonSize.height)];
    
    NSMutableAttributedString *processAllReferenceVideosButtonTitle = [[NSMutableAttributedString alloc] initWithString:@"Process all"];
    [processAllReferenceVideosButtonTitle addAttribute:NSFontAttributeName
                                        value:[UIFont systemFontOfSize:15.0]
                                        range:NSMakeRange(0, [processAllReferenceVideosButtonTitle length])];
    [processAllReferenceVideosButtonTitle addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:(0 / 255.f) green:(122 / 255.f) blue:(255 / 255.f) alpha:1.f] range:NSMakeRange(0, [processAllReferenceVideosButtonTitle length])];
    
    [_processAllReferenceMotionsButton setAttributedTitle:processAllReferenceVideosButtonTitle forState:UIControlStateNormal];
    
    // setting recording view button
    
    CGSize recordingViewButtonSize = CGSizeMake(150, 30);
    CGPoint recordingViewButtonOrigin = CGPointMake(processAllReferenceVideosButtonOrigin.x + processAllReferenceVideosButtonSize.width, processAllReferenceVideosButtonOrigin.y);
    
    [_goToRecordingViewButton setFrame:CGRectMake(recordingViewButtonOrigin.x, recordingViewButtonOrigin.y, recordingViewButtonSize.width, recordingViewButtonSize.height)];
    
    NSMutableAttributedString *recordingViewButtonTitle = [[NSMutableAttributedString alloc] initWithString:@"Go to recording"];
    [recordingViewButtonTitle addAttribute:NSFontAttributeName
                                     value:[UIFont systemFontOfSize:15.0]
                                     range:NSMakeRange(0, [recordingViewButtonTitle length])];
    [recordingViewButtonTitle addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:(0 / 255.f) green:(122 / 255.f) blue:(255 / 255.f) alpha:1.f] range:NSMakeRange(0, [recordingViewButtonTitle length])];
    
    [_goToRecordingViewButton setAttributedTitle:recordingViewButtonTitle forState:UIControlStateNormal];
    
    CGSize informationsPaneLabelSize = CGSizeMake(150, 30);
    CGPoint informationsPaneLabelOrigin = CGPointMake(defaultMargin, referenceMotionsTableViewOrigin.y - defaultMargin);
    
    [_informationsPaneLabel setFrame:CGRectMake(informationsPaneLabelOrigin.x, informationsPaneLabelOrigin.y, informationsPaneLabelSize.width, informationsPaneLabelSize.height)];
    
    NSMutableAttributedString *informationsPaneLabelText = [[NSMutableAttributedString alloc] initWithString:@"My informations"];
    [informationsPaneLabelText addAttribute:NSFontAttributeName
                                          value:[UIFont systemFontOfSize:20.0]
                                          range:NSMakeRange(0, [informationsPaneLabelText length])];
    [informationsPaneLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [informationsPaneLabelText length])];
    
    [_informationsPaneLabel setAttributedText:informationsPaneLabelText];
    
    
    CGSize nameTextFieldLabelSize = CGSizeMake(200, 30);
    CGPoint nameTextFieldLabelOrigin = CGPointMake(defaultMargin, informationsPaneLabelOrigin.y + informationsPaneLabelSize.height + defaultMargin);
    
    [_nameTextFieldLabel setFrame:CGRectMake(nameTextFieldLabelOrigin.x, nameTextFieldLabelOrigin.y, nameTextFieldLabelSize.width, nameTextFieldLabelSize.height)];
    
    NSMutableAttributedString *nameTextFieldLabelText = [[NSMutableAttributedString alloc] initWithString:@"Name: "];
    [nameTextFieldLabelText addAttribute:NSFontAttributeName
                                      value:[UIFont systemFontOfSize:20.0]
                                      range:NSMakeRange(0, [nameTextFieldLabelText length])];
    [nameTextFieldLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [nameTextFieldLabelText length])];
    
    [_nameTextFieldLabel setAttributedText:nameTextFieldLabelText];
    
    CGPoint nameTextFieldOrigin = CGPointMake(nameTextFieldLabelOrigin.x + nameTextFieldLabelSize.width + defaultMargin, informationsPaneLabelOrigin.y + informationsPaneLabelSize.height + defaultMargin);
    CGSize nameTextFieldSize = CGSizeMake(200, 40);
    
    [_nameTextField setFrame:CGRectMake(nameTextFieldOrigin.x, nameTextFieldOrigin.y, nameTextFieldSize.width, nameTextFieldSize.height)];
    _nameTextField.backgroundColor = [UIColor colorWithRed:(133 / 255.f) green:(123 / 255.f) blue:(129 / 255.f) alpha:1.f];
    [_nameTextField setTextColor:[UIColor whiteColor]];
    _nameTextField.layer.cornerRadius = 8.0f;
    _nameTextField.layer.masksToBounds = YES;
    _nameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    CGSize firstNameTextFieldLabelSize = CGSizeMake(nameTextFieldLabelSize.width, 30);
    CGPoint firstNameTextFieldLabelOrigin = CGPointMake(defaultMargin, nameTextFieldLabelOrigin.y + nameTextFieldLabelSize.height + defaultMargin);
    
    [_firstNameTextFieldLabel setFrame:CGRectMake(firstNameTextFieldLabelOrigin.x, firstNameTextFieldLabelOrigin.y, firstNameTextFieldLabelSize.width, firstNameTextFieldLabelSize.height)];
    
    NSMutableAttributedString *firstNameTextFieldLabelText = [[NSMutableAttributedString alloc] initWithString:@"First name: "];
    [firstNameTextFieldLabelText addAttribute:NSFontAttributeName
                                   value:[UIFont systemFontOfSize:20.0]
                                   range:NSMakeRange(0, [firstNameTextFieldLabelText length])];
    [firstNameTextFieldLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [firstNameTextFieldLabelText length])];
    
    [_firstNameTextFieldLabel setAttributedText:firstNameTextFieldLabelText];
    
    
    CGPoint firstNameTextFieldOrigin = CGPointMake(firstNameTextFieldLabelOrigin.x + firstNameTextFieldLabelSize.width + defaultMargin, firstNameTextFieldLabelOrigin.y);
    CGSize firstNameTextFieldSize = CGSizeMake(200, 40);
    
    [_firstNameTextField setFrame:CGRectMake(firstNameTextFieldOrigin.x, firstNameTextFieldOrigin.y, firstNameTextFieldSize.width, firstNameTextFieldSize.height)];
    _firstNameTextField.backgroundColor = [UIColor colorWithRed:(133 / 255.f) green:(123 / 255.f) blue:(129 / 255.f) alpha:1.f];
    [_firstNameTextField setTextColor:[UIColor whiteColor]];
    _firstNameTextField.layer.cornerRadius = 8.0f;
    _firstNameTextField.layer.masksToBounds = YES;
    _firstNameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    CGSize changePasswordPaneLabelSize = CGSizeMake(170, 30);
    CGPoint changePasswordPaneLabelOrigin = CGPointMake(defaultMargin, firstNameTextFieldLabelOrigin.y + firstNameTextFieldSize.height + defaultMargin);
    
    [_changePasswordPaneLabel setFrame:CGRectMake(changePasswordPaneLabelOrigin.x, changePasswordPaneLabelOrigin.y, changePasswordPaneLabelSize.width, changePasswordPaneLabelSize.height)];
    
    NSMutableAttributedString *changePasswordPaneLabelText = [[NSMutableAttributedString alloc] initWithString:@"Change password"];
    [changePasswordPaneLabelText addAttribute:NSFontAttributeName
                                          value:[UIFont systemFontOfSize:20.0]
                                          range:NSMakeRange(0, [changePasswordPaneLabelText length])];
    [changePasswordPaneLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [changePasswordPaneLabelText length])];
    
    [_changePasswordPaneLabel setAttributedText:changePasswordPaneLabelText];
    
    CGSize oldPasswordTextFieldLabelSize = CGSizeMake(nameTextFieldLabelSize.width, 30);
    CGPoint oldPasswordTextFieldLabelOrigin = CGPointMake(defaultMargin, changePasswordPaneLabelOrigin.y + changePasswordPaneLabelSize.height + defaultMargin);
    
    [_oldPasswordTextFieldLabel setFrame:CGRectMake(oldPasswordTextFieldLabelOrigin.x, oldPasswordTextFieldLabelOrigin.y, oldPasswordTextFieldLabelSize.width, oldPasswordTextFieldLabelSize.height)];
    
    NSMutableAttributedString *oldPasswordTextFieldLabelText = [[NSMutableAttributedString alloc] initWithString:@"Old password: "];
    [oldPasswordTextFieldLabelText addAttribute:NSFontAttributeName
                                        value:[UIFont systemFontOfSize:20.0]
                                        range:NSMakeRange(0, [oldPasswordTextFieldLabelText length])];
    [oldPasswordTextFieldLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [oldPasswordTextFieldLabelText length])];
    
    [_oldPasswordTextFieldLabel setAttributedText:oldPasswordTextFieldLabelText];
    
    CGPoint oldPasswordTextFieldOrigin = CGPointMake(oldPasswordTextFieldLabelOrigin.x + oldPasswordTextFieldLabelSize.width + defaultMargin, oldPasswordTextFieldLabelOrigin.y);
    CGSize oldPasswordTextFieldSize = CGSizeMake(200, 40);
    
    [_oldPasswordTextField setFrame:CGRectMake(oldPasswordTextFieldOrigin.x, oldPasswordTextFieldOrigin.y, oldPasswordTextFieldSize.width, oldPasswordTextFieldSize.height)];
    _oldPasswordTextField.backgroundColor = [UIColor colorWithRed:(133 / 255.f) green:(123 / 255.f) blue:(129 / 255.f) alpha:1.f];
    [_oldPasswordTextField setTextColor:[UIColor whiteColor]];
    _oldPasswordTextField.layer.cornerRadius = 8.0f;
    _oldPasswordTextField.layer.masksToBounds = YES;
    _oldPasswordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    CGSize newPasswordTextFieldLabelSize = CGSizeMake(nameTextFieldLabelSize.width, 30);
    CGPoint newPasswordTextFieldLabelOrigin = CGPointMake(defaultMargin, oldPasswordTextFieldOrigin.y + oldPasswordTextFieldLabelSize.height + defaultMargin);
    
    [_passwordNewTextFieldLabel setFrame:CGRectMake(newPasswordTextFieldLabelOrigin.x, newPasswordTextFieldLabelOrigin.y, newPasswordTextFieldLabelSize.width, newPasswordTextFieldLabelSize.height)];
    
    NSMutableAttributedString *newPasswordTextFieldLabelText = [[NSMutableAttributedString alloc] initWithString:@"New password: "];
    [newPasswordTextFieldLabelText addAttribute:NSFontAttributeName
                                          value:[UIFont systemFontOfSize:20.0]
                                          range:NSMakeRange(0, [newPasswordTextFieldLabelText length])];
    [newPasswordTextFieldLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [newPasswordTextFieldLabelText length])];
    
    [_passwordNewTextFieldLabel setAttributedText:newPasswordTextFieldLabelText];
    
    CGPoint newPasswordTextFieldOrigin = CGPointMake(newPasswordTextFieldLabelOrigin.x + newPasswordTextFieldLabelSize.width + defaultMargin, newPasswordTextFieldLabelOrigin.y);
    CGSize newPasswordTextFieldSize = CGSizeMake(200, 40);
    
    [_passwordNewTextField setFrame:CGRectMake(newPasswordTextFieldOrigin.x, newPasswordTextFieldOrigin.y, newPasswordTextFieldSize.width, newPasswordTextFieldSize.height)];
    _passwordNewTextField.backgroundColor = [UIColor colorWithRed:(133 / 255.f) green:(123 / 255.f) blue:(129 / 255.f) alpha:1.f];
    [_passwordNewTextField setTextColor:[UIColor whiteColor]];
    _passwordNewTextField.layer.cornerRadius = 8.0f;
    _passwordNewTextField.layer.masksToBounds = YES;
    _passwordNewTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    CGSize newPasswordAgainTextFieldLabelSize = CGSizeMake(nameTextFieldLabelSize.width, 30);
    CGPoint newPasswordAgainTextFieldLabelOrigin = CGPointMake(defaultMargin, newPasswordTextFieldOrigin.y + newPasswordTextFieldLabelSize.height + defaultMargin);
    
    [_passwordNewAgainTextFieldLabel setFrame:CGRectMake(newPasswordAgainTextFieldLabelOrigin.x, newPasswordAgainTextFieldLabelOrigin.y, newPasswordAgainTextFieldLabelSize.width, newPasswordAgainTextFieldLabelSize.height)];
    
    NSMutableAttributedString *newPasswordAgainTextFieldLabelText = [[NSMutableAttributedString alloc] initWithString:@"New password again: "];
    [newPasswordAgainTextFieldLabelText addAttribute:NSFontAttributeName
                                          value:[UIFont systemFontOfSize:20.0]
                                          range:NSMakeRange(0, [newPasswordAgainTextFieldLabelText length])];
    [newPasswordAgainTextFieldLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [newPasswordAgainTextFieldLabelText length])];
    
    [_passwordNewAgainTextFieldLabel setAttributedText:newPasswordAgainTextFieldLabelText];
    
    
    CGPoint newPasswordAgainTextFieldOrigin = CGPointMake(newPasswordAgainTextFieldLabelOrigin.x + newPasswordAgainTextFieldLabelSize.width + defaultMargin, newPasswordAgainTextFieldLabelOrigin.y);
    CGSize newPasswordAgainTextFieldSize = CGSizeMake(200, 40);
    
    [_passwordNewAgainTextField setFrame:CGRectMake(newPasswordAgainTextFieldOrigin.x, newPasswordAgainTextFieldOrigin.y, newPasswordAgainTextFieldSize.width, newPasswordAgainTextFieldSize.height)];
    _passwordNewAgainTextField.backgroundColor = [UIColor colorWithRed:(133 / 255.f) green:(123 / 255.f) blue:(129 / 255.f) alpha:1.f];
    [_passwordNewAgainTextField setTextColor:[UIColor whiteColor]];
    _passwordNewAgainTextField.layer.cornerRadius = 8.0f;
    _passwordNewAgainTextField.layer.masksToBounds = YES;
    _passwordNewAgainTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    CGSize saveModificationsButtonSize = CGSizeMake(150, 50);
    CGPoint saveModificationsButtonOrigin = CGPointMake(self.frame.size.width / 4 - (saveModificationsButtonSize.width / 2), newPasswordAgainTextFieldLabelOrigin.y + newPasswordAgainTextFieldLabelSize.height + (defaultMargin * 2));
    
    
    [_saveModificationsButton setFrame:CGRectMake(saveModificationsButtonOrigin.x, saveModificationsButtonOrigin.y, saveModificationsButtonSize.width, saveModificationsButtonSize.height)];
    _saveModificationsButton.backgroundColor = [UIColor colorWithRed:(0 / 255.f) green:(122 / 255.f) blue:(255 / 255.f) alpha:1.f];
    _saveModificationsButton.layer.cornerRadius = 8.0f;
    _saveModificationsButton.layer.masksToBounds = YES;
    [_saveModificationsButton.titleLabel setTextColor:[UIColor whiteColor]];
    
    NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:@"Save modifications"];
    [attributedTitle addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [attributedTitle length])];
    [attributedTitle addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.f] range:NSMakeRange(0, attributedTitle.length)];
    
    [_saveModificationsButton setAttributedTitle:attributedTitle forState:UIControlStateNormal];
}

- (void)layout
{
    [super layout];
    
    [self prepareForUse];
    
    [self addSubview:_referenceMotionsTableView];
    [self addSubview:_referenceMotionsPaneLabel];
    
    [self addSubview:_processAllReferenceMotionsButton];
    [self addSubview:_goToRecordingViewButton];
    
    [self addSubview:_informationsPaneLabel];
    [self addSubview:_nameTextFieldLabel];
    [self addSubview:_nameTextField];
    [self addSubview:_firstNameTextFieldLabel];
    [self addSubview:_firstNameTextField];
    [self addSubview:_changePasswordPaneLabel];
    [self addSubview:_oldPasswordTextFieldLabel];
    [self addSubview:_oldPasswordTextField];
    [self addSubview:_passwordNewTextFieldLabel];
    [self addSubview:_passwordNewTextField];
    [self addSubview:_passwordNewAgainTextFieldLabel];
    [self addSubview:_passwordNewAgainTextField];
    [self addSubview:_saveModificationsButton];
    
    [self addSubview:_selectedForehandReferenceMotionLabel];
    [self addSubview:_forehandReferenceMotionPickerView];
    [self addSubview:_selectedBackhandReferenceMotionLabel];
    [self addSubview:_backhandReferenceMotionPickerView];
    [self addSubview:_selectedServiceReferenceMotionLabel];
    [self addSubview:_serviceReferenceMotionPickerView];
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
