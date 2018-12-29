//
//  MKAIndicator.m
//  MKAIndicatorView
//
//  Created by Masaki Ando
//  Copyright (c) 2018 Hituzi Ando. All rights reserved.
//

#import "MKAIndicator.h"

#import "MKAActivityIndicatorViewWrapper.h"
#import "MKACustomIndicatorViewWrapper.h"
#import "MKAIndicatorInterface.h"
#import "MKAOnlyStatusBarIndicatorViewWrapper.h"
#import "MKASpriteAnimationIndicatorViewWrapper.h"

@interface MKAIndicator ()

@property (nonatomic) id <MKAIndicatorInterface> indicatorView;
@property (nonatomic) NSUInteger count;

@end

@implementation MKAIndicator

+ (instancetype)defaultIndicator {
    static MKAIndicator *indicator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        indicator = [MKAIndicator new];
    });

    return indicator;
}

- (instancetype)init {
    self = [super init];

    if (self) {
        _indicatorView = [MKAActivityIndicatorViewWrapper new];
        _indicatorType = MKAIndicatorTypeBasic;
    }

    return self;
}

#pragma mark - property

- (BOOL)isVisible {
    return self.count > 0;
}

- (void)setWithStatusBarIndicator:(BOOL)withStatusBarIndicator {
    if (self.indicatorType == MKAIndicatorTypeOnlyStatusBar) {
        _withStatusBarIndicator = YES;
    }
    else {
        _withStatusBarIndicator = withStatusBarIndicator;
    }
}

- (void)setIndicatorType:(MKAIndicatorType)indicatorType {
    if (self.isVisible) {
        return;
    }

    _indicatorType = indicatorType;

    if (indicatorType == MKAIndicatorTypeCustom) {
        _indicatorView = [MKACustomIndicatorViewWrapper new];
        _withStatusBarIndicator = NO;
    }
    else if (indicatorType == MKAIndicatorTypeSpriteAnimation) {
        _indicatorView = [MKASpriteAnimationIndicatorViewWrapper new];
        _withStatusBarIndicator = NO;
    }
    else if (indicatorType == MKAIndicatorTypeOnlyStatusBar) {
        _indicatorView = [MKAOnlyStatusBarIndicatorViewWrapper new];
        _withStatusBarIndicator = YES;
    }
    else {
        _indicatorView = [MKAActivityIndicatorViewWrapper new];
        _withStatusBarIndicator = NO;
    }
}

#pragma mark - public method

- (void)startAnimating:(BOOL)animating
                inView:(UIView *)view
     withTouchDisabled:(BOOL)touchDisabled {

    [self startAnimating:animating inView:view atPoint:view.center withTouchDisabled:touchDisabled];
}

- (void)startAnimating:(BOOL)animating
                inView:(UIView *)view
               atPoint:(CGPoint)point
     withTouchDisabled:(BOOL)touchDisabled {

    if (animating) {
        [self showInView:view atPoint:point withTouchDisabled:touchDisabled];
    }
    else {
        [self hide];
    }
}

- (void)showInView:(UIView *)view withTouchDisabled:(BOOL)touchDisabled {
    [self showInView:view atPoint:view.center withTouchDisabled:touchDisabled];
}

- (void)showInView:(UIView *)view atPoint:(CGPoint)point withTouchDisabled:(BOOL)touchDisabled {
    ++self.count;

    if (self.count == 1) {
        self.indicatorView.view.center = point;

        [view addSubview:self.indicatorView.view];
        [view bringSubviewToFront:self.indicatorView.view];

        [self.indicatorView startAnimating];

        if (touchDisabled && ![UIApplication sharedApplication].isIgnoringInteractionEvents) {
            // Disables user touch events.
            [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        }

        if (self.withStatusBarIndicator) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        }
    }
}

- (void)hide {
    if (!self.isVisible) {
        return;
    }

    --self.count;

    if (self.count == 0) {
        [self.indicatorView stopAnimating];

        [self.indicatorView.view removeFromSuperview];

        if ([UIApplication sharedApplication].isIgnoringInteractionEvents) {
            // Enables user touch events.
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }

        if (self.withStatusBarIndicator) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }
    }
}

- (void)hideForcibly {
    if (!self.isVisible) {
        return;
    }

    self.count = 0;

    [self.indicatorView stopAnimating];

    [self.indicatorView.view removeFromSuperview];

    if ([UIApplication sharedApplication].isIgnoringInteractionEvents) {
        // Enables user touch events.
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    }

    if (self.withStatusBarIndicator) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
}

- (void)setSize:(CGSize)size {
    if (self.isVisible) {
        return;
    }

    self.indicatorView.view.bounds = (CGRect) { CGPointZero, size };
}

- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)style {
    if (self.isVisible) {
        return;
    }

    if (self.indicatorType == MKAIndicatorTypeBasic) {
        [((MKAActivityIndicatorViewWrapper *) self.indicatorView) setActivityIndicatorViewStyleAndResize:style];
    }
}

- (void)setCustomIndicatorViewImage:(UIImage *)image {
    if (self.isVisible) {
        return;
    }

    if (self.indicatorType == MKAIndicatorTypeCustom) {
        [((MKACustomIndicatorViewWrapper *) self.indicatorView) setImage:image];
    }
}

- (void)setSpriteAnimationIndicatorViewImages:(NSArray<UIImage *> *)images {
    if (self.isVisible) {
        return;
    }

    if (self.indicatorType == MKAIndicatorTypeSpriteAnimation) {
        [((MKASpriteAnimationIndicatorViewWrapper *) self.indicatorView) setSpriteImagesWithArray:images];
    }
}

- (void)setSpriteAnimationIndicatorViewImagesWithFormat:(NSString *)format count:(NSInteger)count {
    if (self.isVisible) {
        return;
    }

    if (self.indicatorType == MKAIndicatorTypeSpriteAnimation) {
        [((MKASpriteAnimationIndicatorViewWrapper *) self.indicatorView) setSpriteImagesWithFormat:format count:count];
    }
}

- (void)setAnimationDuration:(double)duration {
    if (self.isVisible) {
        return;
    }

    if (self.indicatorType == MKAIndicatorTypeCustom) {
        ((MKACustomIndicatorViewWrapper *) self.indicatorView).duration = duration;
    }
    else if (self.indicatorType == MKAIndicatorTypeSpriteAnimation) {
        ((MKASpriteAnimationIndicatorViewWrapper *) self.indicatorView).duration = duration;
    }
}

- (void)setAnimationRepeatCount:(NSInteger)repeatCount {
    if (self.isVisible) {
        return;
    }

    if (self.indicatorType == MKAIndicatorTypeCustom) {
        ((MKACustomIndicatorViewWrapper *) self.indicatorView).repeatCount = repeatCount;
    }
    else if (self.indicatorType == MKAIndicatorTypeSpriteAnimation) {
        ((MKASpriteAnimationIndicatorViewWrapper *) self.indicatorView).repeatCount = repeatCount;
    }
}

- (void)addBackgroundView:(UIView *)bgView {
    if (self.isVisible) {
        return;
    }

    bgView.center = CGPointMake(self.indicatorView.view.frame.size.width * .5f,
                                self.indicatorView.view.frame.size.height * .5f);
    [self.indicatorView.view addSubview:bgView];
    [self.indicatorView.view sendSubviewToBack:bgView];
}

- (void)addBlackBackgroundView {
    // Makes a slightly enlarged background than the indicator.
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                              0,
                                                              self.indicatorView.view.frame.size.width * 1.2f,
                                                              self.indicatorView.view.frame.size.height * 1.2f)];
    bgView.layer.cornerRadius = 5.f;
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.7f];

    [self addBackgroundView:bgView];
}

@end
