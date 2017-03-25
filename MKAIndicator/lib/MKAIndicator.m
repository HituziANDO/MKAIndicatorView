//
//  MKAIndicator.m
//
//  Created by Masaki Ando
//  Copyright © 2016年 Hituzi Ando. All rights reserved.
//

#import "MKAIndicator.h"

static NSString * const RotationAnimationKey = @"rotationAnimation";
static const double DefaultAnimationDuration = 1.0;
static const float DefaultRepeatCount = INT_MAX;    // 無限に回り続けるかのように非常に大きい値にする

#pragma mark - MKAIndicatorInterface

@protocol MKAIndicatorInterface <NSObject>
- (UIView *)view;
- (void)startAnimating;
- (void)stopAnimating;
@end

#pragma mark - MKAActivityIndicatorViewWrapper

@interface MKAActivityIndicatorViewWrapper : NSObject <MKAIndicatorInterface>
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

- (UIView *)view {
    return self.indicatorView;
}

- (void)startAnimating {
    [self.indicatorView startAnimating];
}

- (void)stopAnimating {
    [self.indicatorView stopAnimating];
}

- (void)setActivityIndicatorViewStyleAndResize:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle {
    self.indicatorView.activityIndicatorViewStyle = activityIndicatorViewStyle;
    // スタイルに合わせてビューの大きさを調整する
    if (activityIndicatorViewStyle == UIActivityIndicatorViewStyleWhiteLarge) {
        self.indicatorView.bounds = CGRectMake(0, 0, 64.f, 64.f);
    }
    else {  // Gray or White
        self.indicatorView.bounds = CGRectMake(0, 0, 32.f, 32.f);
    }
}

@end

#pragma mark - MKACustomIndicatorViewWrapper

@interface MKACustomIndicatorViewWrapper : NSObject <MKAIndicatorInterface>
@property (nonatomic) UIView *containerView;
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) double duration;
@property (nonatomic) float repeatCount;
@end

@implementation MKACustomIndicatorViewWrapper

- (instancetype)init {
    self = [super init];
    if (self) {
        _containerView = [UIView new];
        _imageView = [UIImageView new];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_containerView addSubview:_imageView];
        _duration = DefaultAnimationDuration;
        _repeatCount = DefaultRepeatCount;
    }
    return self;
}

- (UIView *)view {
    return self.containerView;
}

- (void)startAnimating {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = self.duration;
    animation.repeatCount = self.repeatCount;
    animation.fromValue = @(0);
    animation.toValue = @(2.0 * M_PI);
    // アニメーション終了時に元に戻さないようにする
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self.imageView.layer addAnimation:animation forKey:RotationAnimationKey];
}

- (void)stopAnimating {
    [self.imageView.layer removeAnimationForKey:RotationAnimationKey];
}

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
    self.containerView.bounds = (CGRect) { CGPointZero, image.size };
}

@end

#pragma mark - MKASpriteAnimationIndicatorViewWrapper

@interface MKASpriteAnimationIndicatorViewWrapper : NSObject <MKAIndicatorInterface>
@property (nonatomic) UIView *containerView;
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) double duration;
@property (nonatomic) NSInteger repeatCount;
@property (nonatomic, copy, readonly) NSMutableArray<UIImage *> *images;
@end

@implementation MKASpriteAnimationIndicatorViewWrapper

- (instancetype)init {
    self = [super init];
    if (self) {
        _containerView = [UIView new];
        _imageView = [UIImageView new];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_containerView addSubview:_imageView];
        _duration = DefaultAnimationDuration;
        _repeatCount = 0;   // 無限
        _images = [NSMutableArray array];
    }
    return self;
}

- (UIView *)view {
    return self.containerView;
}

- (void)startAnimating {
    self.imageView.animationImages = self.images;
    self.imageView.animationDuration = self.duration;
    self.imageView.animationRepeatCount = self.repeatCount;
    [self.imageView startAnimating];
}

- (void)stopAnimating {
    [self.imageView stopAnimating];
}

- (void)setSpriteImagesWithFormat:(NSString *)format count:(NSInteger)count {
    if (!format || count <= 0) {
        return;
    }
    
    [self.images removeAllObjects];
    
    // formatは"indicator%zd"のような文字列
    for (NSInteger i = 0; i < count; i++) {
        [self.images addObject:[UIImage imageNamed:[NSString stringWithFormat:format, i]]];
    }
    
    self.containerView.bounds = (CGRect) { CGPointZero, self.images[0].size };
}

- (void)setSpriteImagesWithArray:(NSArray<UIImage *> *)images {
    if (!images || images.count == 0) {
        return;
    }
    
    [self.images removeAllObjects];
    [self.images addObjectsFromArray:images];
    
    self.containerView.bounds = (CGRect) { CGPointZero, self.images[0].size };
}

@end

#pragma mark - MKAOnlyStatusBarIndicatorViewWrapper

@interface MKAOnlyStatusBarIndicatorViewWrapper : NSObject <MKAIndicatorInterface>

@end

@implementation MKAOnlyStatusBarIndicatorViewWrapper

- (UIView *)view {
    return nil;
}

- (void)startAnimating {
}

- (void)stopAnimating {
}

@end

#pragma mark - MKAIndicator

@interface MKAIndicator ()
@property (nonatomic) id<MKAIndicatorInterface> indicatorView;
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

- (void)setIndicatorType:(MKAIndicatorType)indicatorType {
    // 表示中は何もしない
    if (self.isVisible) {
        return;
    }
    
    _indicatorType = indicatorType;
    if (indicatorType == MKAIndicatorTypeCustom) {
        _indicatorView = [MKACustomIndicatorViewWrapper new];
    }
    else if (indicatorType == MKAIndicatorTypeSpriteAnimation) {
        _indicatorView = [MKASpriteAnimationIndicatorViewWrapper new];
    }
    else if (indicatorType == MKAIndicatorTypeOnlyStatusBar) {
        _indicatorView = [MKAOnlyStatusBarIndicatorViewWrapper new];
        // 強制的にONにする
        self.withStatusBarIndicator = YES;
    }
    else {
        _indicatorView = [MKAActivityIndicatorViewWrapper new];
    }
}

#pragma mark - public

- (void)startAnimating:(BOOL)animating inView:(UIView *)view withTouchDisabled:(BOOL)touchDisabled {
    [self startAnimating:animating inView:view atPoint:view.center withTouchDisabled:touchDisabled];
}

- (void)startAnimating:(BOOL)animating inView:(UIView *)view atPoint:(CGPoint)point
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
    
    // 重複表示しないようにする
    if (self.count == 1) {
        self.indicatorView.view.center = point;
        
        [view addSubview:self.indicatorView.view];
        [view bringSubviewToFront:self.indicatorView.view];
        
        [self.indicatorView startAnimating];
        
        if (touchDisabled && ![UIApplication sharedApplication].isIgnoringInteractionEvents) {
            // タッチイベントの無効化
            [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        }
        
        if (self.withStatusBarIndicator) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        }
    }
}

- (void)hide {
    // 表示されていないならば何もしない
    if (!self.isVisible) {
        return;
    }
    
    --self.count;
    
    if (self.count == 0) {
        [self.indicatorView stopAnimating];
        
        [self.indicatorView.view removeFromSuperview];
        
        if ([UIApplication sharedApplication].isIgnoringInteractionEvents) {
            // タッチイベントの有効化
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }
        
        if (self.withStatusBarIndicator) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }
    }
}

- (void)hideForcibly {
    // 表示されていないならば何もしない
    if (!self.isVisible) {
        return;
    }
    
    self.count = 0;
    
    [self.indicatorView stopAnimating];
    
    [self.indicatorView.view removeFromSuperview];
    
    if ([UIApplication sharedApplication].isIgnoringInteractionEvents) {
        // タッチイベントの有効化
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
    // インディケータより少し拡大した背景を作る
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                              0,
                                                              self.indicatorView.view.frame.size.width * 1.2f,
                                                              self.indicatorView.view.frame.size.height * 1.2f)];
    bgView.layer.cornerRadius = 5.f;
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.7f];
    
    [self addBackgroundView:bgView];
}

@end
