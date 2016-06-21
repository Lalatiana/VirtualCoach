//
//  UIProfileView.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 19/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIBaseView.h"
#import "UIBaseLabel.h"
#import "UIBaseTextField.h"
#import "UIBaseButton.h"
#import "UIProfileViewController.h"

@interface UIProfileView : UIBaseView

@property (nonatomic, strong) UIBaseLabel *informationsPaneLabel;

@property (nonatomic, strong) UIBaseLabel *nameTextFieldLabel;
@property (nonatomic, strong) UIBaseTextField *nameTextField;
@property (nonatomic, strong) UIBaseLabel *firstNameTextFieldLabel;
@property (nonatomic, strong) UIBaseTextField  *firstNameTextField;

@property (nonatomic, strong) UIBaseLabel *changePasswordPaneLabel;
@property (nonatomic, strong) UIBaseLabel *oldPasswordTextFieldLabel;
@property (nonatomic, strong) UIBaseTextField *oldPasswordTextField;
@property (nonatomic, strong) UIBaseLabel *passwordNewTextFieldLabel;
@property (nonatomic, strong) UIBaseTextField *passwordNewTextField;
@property (nonatomic, strong) UIBaseLabel *passwordNewAgainTextFieldLabel;
@property (nonatomic, strong) UIBaseTextField *passwordNewAgainTextField;

@property (nonatomic, strong) UIBaseButton *saveModificationsButton;

@property (nonatomic, strong) UIBaseLabel *referenceMotionsPaneLabel;
@property (nonatomic, strong) UIBaseButton *processAllReferenceMotionsButton;
@property (nonatomic, strong) UIBaseButton *goToRecordingViewButton;

@property (nonatomic, strong) UIBaseLabel *selectedForehandReferenceMotionLabel;
@property (nonatomic, strong) UIPickerView *forehandReferenceMotionPickerView;
@property (nonatomic, strong) UIBaseLabel *selectedBackhandReferenceMotionLabel;
@property (nonatomic, strong) UIPickerView *backhandReferenceMotionPickerView;
@property (nonatomic, strong) UIBaseLabel *selectedServiceReferenceMotionLabel;
@property (nonatomic, strong) UIPickerView *serviceReferenceMotionPickerView;

@property (nonatomic, strong) UITableView *referenceMotionsTableView;

@end
