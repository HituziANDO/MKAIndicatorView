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

    // Set default indicator.
    MKAIndicator *indicator = [MKAIndicator basicIndicatorWithActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [MKAIndicator setDefaultIndicator:indicator];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    // When leaving this screen, forcibly terminate the indicator.
    [[MKAIndicator defaultIndicator] hideForcibly];
}

#pragma mark - IBAction

- (IBAction)basicButtonClicked:(id)sender {
    // Show basic indicator. Also display on the status bar.
    MKAIndicator *indicator = [[[MKAIndicator basicIndicatorWithActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge]
                                              addBlackBackgroundView]
                                              alsoStatusBarIndicator];
    [MKAIndicator setDefaultIndicator:indicator];
    [[MKAIndicator defaultIndicator] showInView:self.view withTouchDisabled:NO];
}

- (IBAction)customButtonClicked:(id)sender {
    // Show custom indicator.
    MKAIndicator *indicator = [[MKAIndicator customIndicatorWithIndicatorViewImage:[UIImage imageNamed:@"spinner"]]
                                             setAnimationDuration:1.0];
    [MKAIndicator setDefaultIndicator:indicator];
    [[MKAIndicator defaultIndicator] showInView:self.view withTouchDisabled:NO];
}

- (IBAction)spriteAnimationButtonClicked:(id)sender {
    // Show sprite animation indicator.
    MKAIndicator *indicator = [[MKAIndicator spriteAnimationIndicatorWithIndicatorViewImagesFormat:@"indicator%zd"
                                                                                             count:8]
                                             setAnimationDuration:.5];
    [MKAIndicator setDefaultIndicator:indicator];
    [[MKAIndicator defaultIndicator] showInView:self.view withTouchDisabled:NO];
}

- (IBAction)touchDisabledButtonClicked:(id)sender {
    // Show basic indicator. Disable user touch actions when displaying.
    MKAIndicator *indicator = [MKAIndicator basicIndicatorWithActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [MKAIndicator setDefaultIndicator:indicator];
    [[MKAIndicator defaultIndicator] showInView:self.view withTouchDisabled:YES];

    [NSTimer scheduledTimerWithTimeInterval:3.0 repeats:NO block:^(NSTimer *_Nonnull timer) {
        [[MKAIndicator defaultIndicator] hide];
    }];
}

- (IBAction)onlyStatusBarButtonClicked:(id)sender {
    // Show indicator on the status bar only.
    MKAIndicator *indicator = [MKAIndicator onlyStatusBarIndicator];
    [MKAIndicator setDefaultIndicator:indicator];
    [[MKAIndicator defaultIndicator] showInView:self.view withTouchDisabled:NO];
}

- (IBAction)stopButtonClicked:(id)sender {
    // Hide if needed.
    [[MKAIndicator defaultIndicator] hide];
}

@end
