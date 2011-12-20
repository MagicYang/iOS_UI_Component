//
//  VSPickerViewController.m
//  VSPicker
//
//  Created by MagicYang on 3/11/11.
//  Copyright 2011 百度. All rights reserved.
//

#import "VSPickerViewController.h"
#import "VSPickerView.h"


@implementation VSPickerViewController

- (void)dealloc
{
    [picker release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    picker = [[VSPickerView alloc] initWithFrame:CGRectZero];   // Frame set in picker itself
    picker.showsSelectionIndicator = YES;
    picker.delegate = self;
    picker.target   = self;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setFrame:CGRectMake(50, 50, 200, 40)];
    [btn setTitle:@"Show Picker" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pickerOut:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)pickerOut:(id)sender {
    [picker showInView:self.view Animation:YES];
}

- (void)cancelPick:(id)sender {
    [picker hideWithAnimation:YES];
}

- (void)finishPick:(id)sender {
    [picker hideWithAnimation:YES];
}

#pragma mark -
#pragma mark UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return 10;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
	return 125;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
	return 40;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"Item %d", row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    // do something u want
}


@end
