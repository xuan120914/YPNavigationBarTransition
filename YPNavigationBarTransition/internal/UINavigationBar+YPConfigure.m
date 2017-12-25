//
//  UINavigationBar+YPConfigure.m
//  YPNavigationBarTransition
//
//  Created by Guoyin Lee on 24/12/2017.
//  Copyright © 2017 yiplee. All rights reserved.
//

#import "UINavigationBar+YPConfigure.h"
#import "YPBarConfiguration.h"
#import "UIImage+YPConfigure.h"
#import <objc/runtime.h>

@implementation UINavigationBar (YPConfigure)

- (void) yp_adjustWithBarStyle:(UIBarStyle)barStyle tintColor:(UIColor *)tintColor {
    self.barStyle = barStyle;
    self.tintColor = tintColor;
}

- (void) yp_applyBarConfiguration:(YPBarConfiguration *)configure {
    [self yp_adjustWithBarStyle:configure.barStyle tintColor:configure.tintColor];
    
    UIImage* const transpanrentImage = [UIImage yp_transparentImage];
    if (configure.transparent) {
        self.translucent = NO;
        [self setBackgroundImage:transpanrentImage forBarMetrics:UIBarMetricsDefault];
    } else {
        self.translucent = configure.translucent;
        UIImage* backgroundImage = configure.backgroundImage;
        if (!backgroundImage) {
            backgroundImage = [UIImage yp_imageWithColor:configure.backgroundColor];
        }
        
        [self setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    }
    
    self.shadowImage = transpanrentImage;
    
    [self setCurrentBarConfigure:configure];
}

- (YPBarConfiguration *) currentBarConfigure {
    return objc_getAssociatedObject(self, @selector(currentBarConfigure));
}

- (void) setCurrentBarConfigure:(YPBarConfiguration *)currentBarConfigure {
    objc_setAssociatedObject(self, @selector(currentBarConfigure), currentBarConfigure, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
