//
// MIT License
//
// Copyright (c) 2018-present Hituzi Ando
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
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
@property (nonatomic) MKAIndicatorType indicatorType;

@end

@implementation MKAIndicator

static MKAIndicator *_defaultIndicator = nil;

+ (void)setDefaultIndicator:(MKAIndicator *)indicator {
    @synchronized (self) {
        [_defaultIndicator hideForcibly];

        _defaultIndicator = indicator;
    }
}

+ (instancetype)defaultIndicator {
    @synchronized (self) {
        if (!_defaultIndicator) {
            @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                           reason:@"Default indicator is not set. Execute `+setDefaultIndicator:` method before execute `+defaultIndicator` method."
                                         userInfo:nil];
        }

        return _defaultIndicator;
    }
}

+ (instancetype)currentIndicator {
    static MKAIndicator *indicator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        indicator = [MKAIndicator new];
    });

    return indicator;
}

+ (instancetype)basicIndicatorWithActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)style {
    MKAIndicator *indicator = [MKAIndicator new];
    indicator.indicatorType = MKAIndicatorTypeBasic;
    [((MKAActivityIndicatorViewWrapper *) indicator.indicatorView) setActivityIndicatorViewStyleAndResize:style];

    return indicator;
}

+ (instancetype)customIndicatorWithIndicatorViewImage:(UIImage *)image {
    MKAIndicator *indicator = [MKAIndicator new];
    indicator.indicatorType = MKAIndicatorTypeCustom;
    [((MKACustomIndicatorViewWrapper *) indicator.indicatorView) setImage:image];

    return indicator;
}

+ (instancetype)spriteAnimationIndicatorWithIndicatorViewImages:(NSArray<UIImage *> *)images {
    MKAIndicator *indicator = [MKAIndicator new];
    indicator.indicatorType = MKAIndicatorTypeSpriteAnimation;
    [((MKASpriteAnimationIndicatorViewWrapper *) indicator.indicatorView) setSpriteImagesWithArray:images];

    return indicator;
}

+ (instancetype)spriteAnimationIndicatorWithIndicatorViewImagesFormat:(NSString *)format count:(NSInteger)count {
    MKAIndicator *indicator = [MKAIndicator new];
    indicator.indicatorType = MKAIndicatorTypeSpriteAnimation;
    [((MKASpriteAnimationIndicatorViewWrapper *) indicator.indicatorView) setSpriteImagesWithFormat:format count:count];

    return indicator;
}

+ (instancetype)onlyStatusBarIndicator {
    MKAIndicator *indicator = [MKAIndicator new];
    indicator.indicatorType = MKAIndicatorTypeOnlyStatusBar;

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

- (instancetype)setSize:(CGSize)size {
    if (self.isVisible) {
        return self;
    }

    self.indicatorView.view.bounds = (CGRect) { CGPointZero, size };

    return self;
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

- (instancetype)setAnimationDuration:(double)duration {
    if (self.isVisible) {
        return self;
    }

    if (self.indicatorType == MKAIndicatorTypeCustom) {
        ((MKACustomIndicatorViewWrapper *) self.indicatorView).duration = duration;
    }
    else if (self.indicatorType == MKAIndicatorTypeSpriteAnimation) {
        ((MKASpriteAnimationIndicatorViewWrapper *) self.indicatorView).duration = duration;
    }

    return self;
}

- (instancetype)setAnimationRepeatCount:(NSInteger)repeatCount {
    if (self.isVisible) {
        return self;
    }

    if (self.indicatorType == MKAIndicatorTypeCustom) {
        ((MKACustomIndicatorViewWrapper *) self.indicatorView).repeatCount = repeatCount;
    }
    else if (self.indicatorType == MKAIndicatorTypeSpriteAnimation) {
        ((MKASpriteAnimationIndicatorViewWrapper *) self.indicatorView).repeatCount = repeatCount;
    }

    return self;
}

- (instancetype)addBackgroundView:(UIView *)bgView {
    if (self.isVisible) {
        return self;
    }

    bgView.center = CGPointMake(self.indicatorView.view.frame.size.width * .5f,
                                self.indicatorView.view.frame.size.height * .5f);
    [self.indicatorView.view addSubview:bgView];
    [self.indicatorView.view sendSubviewToBack:bgView];

    return self;
}

- (instancetype)addBlackBackgroundView {
    // Makes a slightly enlarged background than the indicator.
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                              0,
                                                              self.indicatorView.view.frame.size.width * 1.2f,
                                                              self.indicatorView.view.frame.size.height * 1.2f)];
    bgView.layer.cornerRadius = 5.f;
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.7f];

    return [self addBackgroundView:bgView];
}

- (instancetype)alsoStatusBarIndicator {
    if (self.isVisible) {
        return self;
    }

    self.withStatusBarIndicator = YES;

    return self;
}

@end
