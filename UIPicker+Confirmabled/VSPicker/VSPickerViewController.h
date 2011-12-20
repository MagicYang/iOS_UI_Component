//
//  VSPickerViewController.h
//  VSPicker
//
//  Created by MagicYang on 3/11/11.
//  Copyright 2011 百度. All rights reserved.
//

#import <UIKit/UIKit.h>


@class  VSPickerView;

@interface VSPickerViewController : UIViewController<UIPickerViewDelegate> {
    VSPickerView *picker;
}

@end
