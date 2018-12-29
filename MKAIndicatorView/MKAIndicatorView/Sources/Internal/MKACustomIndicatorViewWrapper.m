//
//  MKACustomIndicatorViewWrapper.m
//  MKAIndicatorView
//
//  Created by Masaki Ando on 2018/12/29.
//  Copyright (c) 2018 Hituzi Ando. All rights reserved.
//

#import "MKACustomIndicatorViewWrapper.h"

@interface MKACustomIndicatorViewWrapper ()

@property (nonatomic) UIView *containerView;
@property (nonatomic) UIImageView *imageView;

@end

@implementation MKACustomIndicatorViewWrapper

- (instancetype)init {
    self = [super init];

    if (self) {
        _containerView = [UIView new];
        _imageView = [UIImageView new];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_containerView addSubview:_imageView];
        _duration = MKAIndicatorViewDefaultAnimationDuration;
        _repeatCount = MKAIndicatorViewDefaultRepeatCount;
    }

    return self;
}

#pragma mark - MKAIndicatorInterface

- (UIView *)view {
    return self.containerView;
}

- (void)startAnimating {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = self.duration;
    animation.repeatCount = self.repeatCount;
    animation.fromValue = @(0);
    animation.toValue = @(2.0 * M_PI);
    // Do not restore when animation ends.
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self.imageView.layer addAnimation:animation forKey:MKAIndicatorViewRotationAnimationKey];
}

- (void)stopAnimating {
    [self.imageView.layer removeAnimationForKey:MKAIndicatorViewRotationAnimationKey];
}

#pragma mark - public method

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
    self.containerView.bounds = (CGRect) { CGPointZero, image.size };
}

@end
