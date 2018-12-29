//
//  MKAActivityIndicatorViewWrapper.m
//  MKAIndicatorView
//
//  Created by Masaki Ando on 2018/12/29.
//  Copyright (c) 2018 Hituzi Ando. All rights reserved.
//

#import "MKAActivityIndicatorViewWrapper.h"

@interface MKAActivityIndicatorViewWrapper ()

@property (nonatomic) UIActivityIndicatorView *indicatorView;

@end

@implementation MKAActivityIndicatorViewWrapper

- (instancetype)init {
    self = [super init];

    if (self) {
        _indicatorView = [UIActivityIndicatorView new];
        [self setActivityIndicatorViewStyleAndResize:UIActivityIndicatorViewStyleGray];
    }

    return self;
}

#pragma mark - MKAIndicatorInterface

- (UIView *)view {
    return self.indicatorView;
}

- (void)startAnimating {
    [self.indicatorView startAnimating];
}

- (void)stopAnimating {
    [self.indicatorView stopAnimating];
}

#pragma mark - public method

- (void)setActivityIndicatorViewStyleAndResize:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle {
    self.indicatorView.activityIndicatorViewStyle = activityIndicatorViewStyle;

    // Adjusts the size of the view to the style.
    if (activityIndicatorViewStyle == UIActivityIndicatorViewStyleWhiteLarge) {
        self.indicatorView.bounds = CGRectMake(0, 0, 64.f, 64.f);
    }
    else {  // Gray or White
        self.indicatorView.bounds = CGRectMake(0, 0, 32.f, 32.f);
    }
}

@end
