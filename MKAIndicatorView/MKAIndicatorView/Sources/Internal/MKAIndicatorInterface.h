//
//  MKAIndicatorInterface.h
//  MKAIndicatorView
//
//  Created by Masaki Ando on 2018/12/29.
//  Copyright (c) 2018 Hituzi Ando. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN NSString *const MKAIndicatorViewRotationAnimationKey;
UIKIT_EXTERN const double MKAIndicatorViewDefaultAnimationDuration;
UIKIT_EXTERN const float MKAIndicatorViewDefaultRepeatCount;

@protocol MKAIndicatorInterface <NSObject>

- (UIView *)view;
- (void)startAnimating;
- (void)stopAnimating;

@end

NS_ASSUME_NONNULL_END
