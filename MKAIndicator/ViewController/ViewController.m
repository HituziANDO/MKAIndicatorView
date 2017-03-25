//
//  ViewController.m
//  MKAIndicator
//
//  Created by Masaki Ando on 2016/12/15.
//  Copyright © 2016年 Hituzi Ando. All rights reserved.
//

#import "ViewController.h"

#import "MKAIndicator.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *basicButton;
@property (weak, nonatomic) IBOutlet UIButton *customButton;
@property (weak, nonatomic) IBOutlet UIButton *spriteAnimationButton;
@property (weak, nonatomic) IBOutlet UIButton *onlyStatusBarButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *touchDisabledButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // この画面を離れる時は強制的にインディケータを終了する
    [[MKAIndicator defaultIndicator] hideForcibly];
}

#pragma mark - IBAction

- (IBAction)basicButtonClicked:(id)sender {
    MKAIndicator *indicator = [MKAIndicator defaultIndicator];
    
    // 表示中は設定を変更できないため一旦停止する
    [indicator hide];
    
    // 標準のインディケータのセットアップ
    indicator.indicatorType = MKAIndicatorTypeBasic;
    [indicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [indicator addBlackBackgroundView];
    
    // ステータスバーには表示しない
    indicator.withStatusBarIndicator = NO;
    
    // 表示開始
    [indicator showInView:self.view withTouchDisabled:NO];
}

- (IBAction)customButtonClicked:(id)sender {
    MKAIndicator *indicator = [MKAIndicator defaultIndicator];
    
    // 表示中は設定を変更できないため一旦停止する
    [indicator hide];
    
    // カスタムイメージ・インディケータのセットアップ
    indicator.indicatorType = MKAIndicatorTypeCustom;
    [indicator setCustomIndicatorViewImage:[UIImage imageNamed:@"spinner"]];
    
    // ステータスバーには表示しない
    indicator.withStatusBarIndicator = NO;
    
    // 表示開始
    [indicator showInView:self.view withTouchDisabled:NO];
}

- (IBAction)spriteAnimationButtonClicked:(id)sender {
    MKAIndicator *indicator = [MKAIndicator defaultIndicator];
    
    // 表示中は設定を変更できないため一旦停止する
    [indicator hide];
    
    // スプライトアニメーション・インディケータのセットアップ
    indicator.indicatorType = MKAIndicatorTypeSpriteAnimation;
    [indicator setSpriteAnimationIndicatorViewImagesWithFormat:@"indicator%zd" count:8];
    [indicator setAnimationDuration:.5];
    
    // ステータスバーには表示しない
    indicator.withStatusBarIndicator = NO;
    
    // 表示開始
    [indicator showInView:self.view withTouchDisabled:NO];
}

- (IBAction)onlyStatusBarClicked:(id)sender {
    MKAIndicator *indicator = [MKAIndicator defaultIndicator];
    
    // 表示中は設定を変更できないため一旦停止する
    [indicator hide];
    
    // ステータスバーにだけ表示するタイプ
    // 内部で .withStatusBarIndicator = YES をセットしている
    indicator.indicatorType = MKAIndicatorTypeOnlyStatusBar;
    
    // 表示開始
    [indicator showInView:self.view withTouchDisabled:NO];
}

- (IBAction)touchDisabledClicked:(id)sender {
    MKAIndicator *indicator = [MKAIndicator defaultIndicator];
    
    // 表示中は設定を変更できないため一旦停止する
    [indicator hide];
    
    // 標準のインディケータのセットアップ
    indicator.indicatorType = MKAIndicatorTypeBasic;
    
    // ステータスバーには表示しない
    indicator.withStatusBarIndicator = NO;
    
    // 表示中はユーザ操作をできなくする
    [indicator showInView:self.view withTouchDisabled:YES];
    [NSTimer scheduledTimerWithTimeInterval:3.0 repeats:NO block:^(NSTimer * _Nonnull timer) {
        [indicator hide];
    }];
}

- (IBAction)stopButtonClicked:(id)sender {
    // 終了
    [[MKAIndicator defaultIndicator] hide];
}

@end
