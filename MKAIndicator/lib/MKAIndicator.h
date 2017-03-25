//
//  MKAIndicator.h
//
//  Created by Masaki Ando
//  Copyright © 2016年 Hituzi Ando. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MKAIndicatorType) {
    MKAIndicatorTypeBasic = 0,
    MKAIndicatorTypeCustom,
    MKAIndicatorTypeSpriteAnimation,
    MKAIndicatorTypeOnlyStatusBar
};

@interface MKAIndicator : NSObject
/**
 表示中ならばYESを返します
 */
@property (nonatomic, readonly) BOOL isVisible;
/**
 YESならばステータスバー上にもインディケータを表示します
 */
@property (nonatomic) BOOL withStatusBarIndicator;
/**
 インディケータのタイプを指定します。表示中は変更できません
 */
@property (nonatomic) MKAIndicatorType indicatorType;

/**
 シングルトンインスタンスを取得します
 */
+ (instancetype)defaultIndicator;

/**
 インディケータを表示/非表示します
 
 @param animating YESならば表示カウントを+1しインディケータを表示します。NOならば表示カウントを-1し、カウントが0になったらインディケータを隠します
 @param view 指定したビュー上にインディケータを表示します
 @param touchDisabled YESならばインディケータ表示中はユーザ操作できません
 */
- (void)startAnimating:(BOOL)animating inView:(UIView *)view withTouchDisabled:(BOOL)touchDisabled;
/**
 インディケータを表示/非表示します
 
 @param animating YESならば表示カウントを+1しインディケータを表示します。NOならば表示カウントを-1し、カウントが0になったらインディケータを隠します
 @param view 指定したビュー上にインディケータを表示します
 @param point 指定したビュー上でのインディケータの中心座標
 @param touchDisabled YESならばインディケータ表示中はユーザ操作できません
 */
- (void)startAnimating:(BOOL)animating inView:(UIView *)view atPoint:(CGPoint)point
     withTouchDisabled:(BOOL)touchDisabled;
/**
 表示カウントを+1しインディケータを表示します。複数回実行しても重複表示にはなりません
 
 @param view 指定したビュー上にインディケータを表示します
 @param touchDisabled YESならばインディケータ表示中はユーザ操作できません
 */
- (void)showInView:(UIView *)view withTouchDisabled:(BOOL)touchDisabled;
/**
 表示カウントを+1しインディケータを表示します。複数回実行しても重複表示にはなりません
 
 @param view 指定したビュー上にインディケータを表示します
 @param point 指定したビュー上でのインディケータの中心座標
 @param touchDisabled YESならばインディケータ表示中はユーザ操作できません
 */
- (void)showInView:(UIView *)view atPoint:(CGPoint)point withTouchDisabled:(BOOL)touchDisabled;
/**
 表示カウントを-1します。表示カウントが0になったらインディケータを隠します
 */
- (void)hide;
/**
 表示カウントを0にして強制的にインディケータを隠します
 */
- (void)hideForcibly;
/**
 インディケータのサイズを指定します。表示中は変更できません
 
 @param size ビューのサイズ
 */
- (void)setSize:(CGSize)size;
/**
 MKAIndicatorTypeをMKAIndicatorTypeBasicにした時のインディケータのスタイルを指定します。表示中は変更できません
 
 @param style 標準で用意されているインディケータのスタイル
 */
- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)style;
/**
 MKAIndicatorTypeをMKAIndicatorTypeCustomにした時のインディケータ画像を指定します。表示中は変更できません
 
 @param image インディケータ用の画像
 */
- (void)setCustomIndicatorViewImage:(UIImage *)image;
/**
 MKAIndicatorTypeをMKAIndicatorTypeSpriteAnimationにした時のインディケータ画像の配列を指定します。
 インディケータ画像のサイズは統一されている必要があります。なお、表示中は変更できません
 
 @param images インディケータ用の画像配列
 */
- (void)setSpriteAnimationIndicatorViewImages:(NSArray<UIImage *> *)images;
/**
 MKAIndicatorTypeをMKAIndicatorTypeSpriteAnimationにした時のインディケータ画像ファイル名フォーマットとコマ数を指定します。
 インディケータ画像のサイズは統一されている必要があります。なお、表示中は変更できません
 
 @param format "indicator%zd"のようなファイル名フォーマット。ファイル名には0からの連番が付いてる必要があります
 @param count コマ数
 */
- (void)setSpriteAnimationIndicatorViewImagesWithFormat:(NSString *)format count:(NSInteger)count;
/**
 MKAIndicatorTypeをMKAIndicatorTypeCustomまたはMKAIndicatorTypeSpriteAnimationにした時のアニメーション速度を指定します。
 表示中は変更できません
 
 @param duration アニメーション速度(小さい値ほど速い)
 */
- (void)setAnimationDuration:(double)duration;
/**
 MKAIndicatorTypeをMKAIndicatorTypeCustomまたはMKAIndicatorTypeSpriteAnimationにした時のアニメーションの繰り返し回数を指定します。
 表示中は変更できません
 
 @param repeatCount アニメーションの繰り返し回数
 */
- (void)setAnimationRepeatCount:(NSInteger)repeatCount;
/**
 インディケータに任意の背景を追加します。追加した背景は最背面にセットされます。表示中は変更できません
 
 @param bgView 背景ビュー
 */
- (void)addBackgroundView:(UIView *)bgView;
/**
 インディケータに黒背景を追加します。表示中は変更できません
 */
- (void)addBlackBackgroundView;
@end

NS_ASSUME_NONNULL_END
