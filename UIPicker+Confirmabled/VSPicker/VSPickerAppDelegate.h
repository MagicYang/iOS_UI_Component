//
//  VSPickerAppDelegate.h
//  VSPicker
//
//  Created by MagicYang on 3/11/11.
//  Copyright 2011 百度. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VSPickerViewController;

@interface VSPickerAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet VSPickerViewController *viewController;

@end
