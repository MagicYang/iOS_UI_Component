//
//  VSPickerView.m
//  VSPicker
//
//  Created by MagicYang on 3/11/11.
//  Copyright 2011 百度. All rights reserved.
//

#import "VSPickerView.h"


#define PickerH 216
#define ScreenHeight [[UIScreen mainScreen] applicationFrame].size.height


@interface VSPickerView(Private)

- (void)initIndexPath;
- (void)setCurrentIndexPath;
- (void)scrollToPreviousIndexPath;

@end



@implementation VSPickerView

@synthesize target = _target;
@synthesize cancelAction, finishAction;
@synthesize selectedIndexPath = _selectedIndexPath;

- (void)dealloc {
    [_toolbar release];
    [_selectedIndexPath release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:CGRectMake(0, 844, 320, PickerH)])) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        // init toolbar
        _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 800, 320, 44)];
        _toolbar.barStyle = UIBarStyleBlack;
        NSString *uglyCode = @"                                             ";  // use to take the space
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelAction:)];
        UIBarButtonItem *nullItem = [[UIBarButtonItem alloc] initWithTitle:uglyCode style:UIBarButtonItemStylePlain target:nil action:nil];
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *confirmItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(finishAction:)];
        nullItem.enabled = NO;
        [_toolbar setItems:[NSArray arrayWithObjects:cancelItem, spaceItem, nullItem, spaceItem, confirmItem, nil]];
        [cancelItem release];
        [spaceItem release];
        [nullItem release];
        [confirmItem release];
        
        [self initIndexPath];
    }
    
    return self;
}

- (void)initIndexPath {
    NSUInteger colCount = [self numberOfComponents];
    NSUInteger *indexes = malloc(sizeof(NSUInteger) * colCount);
    for (int i = 0; i < colCount; i++) {
        indexes[i] = 0;
    }
    self.selectedIndexPath = [NSIndexPath indexPathWithIndexes:indexes length:colCount];
    free(indexes);
}

- (void)setCurrentIndexPath {
    NSUInteger colCount = [self numberOfComponents];
    NSUInteger *indexes = malloc(sizeof(NSUInteger) * colCount);
    for (int i = 0; i < colCount; i++) {
        indexes[i] = [self selectedRowInComponent:i];
    }
    self.selectedIndexPath = [NSIndexPath indexPathWithIndexes:indexes length:colCount];
    free(indexes);
}

- (void)scrollToPreviousIndexPath {
    NSUInteger colCount = [self numberOfComponents];
    NSUInteger *indexes = malloc(sizeof(NSUInteger) * colCount);;
    [_selectedIndexPath getIndexes:indexes];
    for (int i = 0; i < colCount; i++) {
        [self selectRow:indexes[i] inComponent:i animated:NO];
    }
    free(indexes);
}

- (void)showAnimationStart {
    [[[UIApplication sharedApplication] keyWindow] addSubview:_toolbar];
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
}

- (void)hideAnmiationStop {
    [_toolbar removeFromSuperview];
    [self removeFromSuperview];
}

- (void)showInView:(UIView *)view Animation:(BOOL)animated {
    if (animated) {
        self.frame = CGRectMake(0, view.frame.size.height + 44, 320, PickerH);
        _toolbar.frame = CGRectMake(0, view.frame.size.height, 320, 44);
        [self showAnimationStart];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.frame = CGRectMake(0, ScreenHeight - PickerH + 20, 320, PickerH);
        _toolbar.frame = CGRectMake(0, ScreenHeight - PickerH + 20 - 44, 320, 44);
        [UIView commitAnimations];
    } else {
        [self showAnimationStart];
    }
}

- (void)hideWithAnimation:(BOOL)animated {
    if (animated) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDidStopSelector:@selector(hideAnmiationStop)];
        self.frame = CGRectMake(0, ScreenHeight + 20 + 44, 320, PickerH);
        _toolbar.frame = CGRectMake(0, ScreenHeight + 20 , 320, 44);
        [UIView commitAnimations];
    } else {
        [self hideAnmiationStop];
    }
}

- (void)cancelAction:(id)sender {
    // recover previous selection
    [self scrollToPreviousIndexPath];
    
    if ([_target respondsToSelector:@selector(cancelPick:)]) {
        [_target performSelector:@selector(cancelPick:) withObject:self];
    }
}

- (void)finishAction:(id)sender {
    // update selected index path
    [self setCurrentIndexPath];
    
    if ([_target respondsToSelector:@selector(finishPick:)]) {
        [_target performSelector:@selector(finishPick:) withObject:self];
    }
}

@end