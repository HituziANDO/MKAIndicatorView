//
//  ViewController.m
//  MKAIndicatorViewSample
//
//  Created by Masaki Ando on 2018/12/30.
//  Copyright © 2018年 Hituzi Ando. All rights reserved.
//

#import <MKAIndicatorView/MKAIndicatorView.h>

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *basicButton;
@property (weak, nonatomic) IBOutlet UIButton *customButton;
@property (weak, nonatomic) IBOutlet UIButton *spriteAnimationButton;
@property (weak, nonatomic) IBOutlet UIButton *touchDisabledButton;
@property (weak, nonatomic) IBOutlet UIButton *onlyStatusBarButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    // When leaving this screen, forcibly terminate the indicator.
    [[MKAIndicator defaultIndicator] hideForcibly];
}

#pragma mark - IBAction

- (IBAction)basicButtonClicked:(id)sender {
    MKAIndicator *indicator = [MKAIndicator defaultIndicator];

    [indicator hide];

    // Setup basic indicator.
    indicator.indicatorType = MKAIndicatorTypeBasic;
    [indicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [indicator addBlackBackgroundView];

    // Also display on the status bar.
    indicator.withStatusBarIndicator = YES;

    // Show.
    [indicator showInView:self.view withTouchDisabled:NO];
}

- (IBAction)customButtonClicked:(id)sender {
    MKAIndicator *indicator = [MKAIndicator defaultIndicator];

    [indicator hide];

    // Setup custom indicator.
    indicator.indicatorType = MKAIndicatorTypeCustom;
    [indicator setCustomIndicatorViewImage:[UIImage imageNamed:@"spinner"]];

    // Show.
    [indicator showInView:self.view withTouchDisabled:NO];
}

- (IBAction)spriteAnimationButtonClicked:(id)sender {
    MKAIndicator *indicator = [MKAIndicator defaultIndicator];

    [indicator hide];

    // Setup sprite animation indicator.
    indicator.indicatorType = MKAIndicatorTypeSpriteAnimation;
    [indicator setSpriteAnimationIndicatorViewImagesWithFormat:@"indicator%zd" count:8];
    [indicator setAnimationDuration:.5];

    // Show.
    [indicator showInView:self.view withTouchDisabled:NO];
}

- (IBAction)touchDisabledButtonClicked:(id)sender {
    MKAIndicator *indicator = [MKAIndicator defaultIndicator];

    [indicator hide];

    // Setup basic indicator.
    indicator.indicatorType = MKAIndicatorTypeBasic;

    // Disable user touch actions when displaying.
    [indicator showInView:self.view withTouchDisabled:YES];
    [NSTimer scheduledTimerWithTimeInterval:3.0 repeats:NO block:^(NSTimer *_Nonnull timer) {
        [indicator hide];
    }];
}

- (IBAction)onlyStatusBarButtonClicked:(id)sender {
    MKAIndicator *indicator = [MKAIndicator defaultIndicator];

    [indicator hide];

    // Setup only status bar indicator.
    indicator.indicatorType = MKAIndicatorTypeOnlyStatusBar;

    // Show.
    [indicator showInView:self.view withTouchDisabled:NO];
}

- (IBAction)stopButtonClicked:(id)sender {
    // Hide if needed.
    [[MKAIndicator defaultIndicator] hide];
}

@end
