//
//  MKASpriteAnimationIndicatorViewWrapper.m
//  MKAIndicatorView
//
//  Created by Masaki Ando on 2018/12/29.
//  Copyright (c) 2018 Hituzi Ando. All rights reserved.
//

#import "MKASpriteAnimationIndicatorViewWrapper.h"

@interface MKASpriteAnimationIndicatorViewWrapper ()

@property (nonatomic) UIView *containerView;
@property (nonatomic) UIImageView *imageView;
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
        _duration = MKAIndicatorViewDefaultAnimationDuration;
        _repeatCount = 0;   // Infinite
        _images = [NSMutableArray array];
    }

    return self;
}

#pragma mark - MKAIndicatorInterface

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

#pragma mark - public method

- (void)setSpriteImagesWithFormat:(NSString *)format count:(NSInteger)count {
    if (!format || count <= 0) {
        return;
    }

    [self.images removeAllObjects];

    for (NSInteger i = 0; i < count; i++) {
        [self.images addObject:[UIImage imageNamed:[NSString stringWithFormat:format, i]]];
    }

    self.containerView.bounds = (CGRect) { CGPointZero, self.images[0].size };
}

- (void)setSpriteImagesWithArray:(NSArray<UIImage *> *)images {
    if (images.count <= 0) {
        return;
    }

    [self.images removeAllObjects];
    [self.images addObjectsFromArray:images];

    self.containerView.bounds = (CGRect) { CGPointZero, self.images[0].size };
}

@end
