//
//  MKAActivityIndicatorViewWrapper.h
//  MKAIndicatorView
//
//  Created by Masaki Ando on 2018/12/29.
//  Copyright (c) 2018 Hituzi Ando. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MKAIndicatorInterface.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKAActivityIndicatorViewWrapper : NSObject <MKAIndicatorInterface>

- (void)setActivityIndicatorViewStyleAndResize:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle;

@end

NS_ASSUME_NONNULL_END
