//
//  MKASpriteAnimationIndicatorViewWrapper.h
//  MKAIndicatorView
//
//  Created by Masaki Ando on 2018/12/29.
//  Copyright (c) 2018 Hituzi Ando. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MKAIndicatorInterface.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKASpriteAnimationIndicatorViewWrapper : NSObject <MKAIndicatorInterface>

@property (nonatomic) double duration;
@property (nonatomic) NSInteger repeatCount;

- (void)setSpriteImagesWithFormat:(NSString *)format count:(NSInteger)count;
- (void)setSpriteImagesWithArray:(NSArray<UIImage *> *)images;

@end

NS_ASSUME_NONNULL_END
