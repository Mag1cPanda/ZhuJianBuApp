//
//  ZJScrollView.m
//  ZhuJianBuApp
//
//  Created by Mag1cPanda on 2017/2/6.
//  Copyright © 2017年 Mag1cPanda. All rights reserved.
//

#import "ZJScrollView.h"

@implementation ZJScrollView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (self.contentOffset.x <= 0) {
        if ([otherGestureRecognizer.delegate isKindOfClass:NSClassFromString(@"_FDFullscreenPopGestureRecognizerDelegate")]) {
            return YES;
        }
    }
    return NO;
}


@end
