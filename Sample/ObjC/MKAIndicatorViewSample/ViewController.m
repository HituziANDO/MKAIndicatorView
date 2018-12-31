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
    [[MKAIndicator currentIndicator] hideForcibly];
}

#pragma mark - IBAction

- (IBAction)basicButtonClicked:(id)sender {
    // Show basic indicator. Also display on the status bar.
    [[[[MKAIndicator basicIndicatorWithActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge]
                     addBlackBackgroundView]
                     alsoStatusBarIndicator]
                     showInView:self.view withTouchDisabled:NO];
}

- (IBAction)customButtonClicked:(id)sender {
    // Show custom indicator.
    [[[MKAIndicator customIndicatorWithIndicatorViewImage:[UIImage imageNamed:@"spinner"]]
                    setAnimationDuration:1.0]
                    showInView:self.view withTouchDisabled:NO];
}

- (IBAction)spriteAnimationButtonClicked:(id)sender {
    // Show sprite animation indicator.
    [[[MKAIndicator spriteAnimationIndicatorWithIndicatorViewImagesFormat:@"indicator%zd" count:8]
                    setAnimationDuration:.5]
                    showInView:self.view withTouchDisabled:NO];
}

- (IBAction)touchDisabledButtonClicked:(id)sender {
    // Show basic indicator. Disable user touch actions when displaying.
    [[MKAIndicator basicIndicatorWithActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray]
                   showInView:self.view withTouchDisabled:YES];

    [NSTimer scheduledTimerWithTimeInterval:3.0 repeats:NO block:^(NSTimer *_Nonnull timer) {
        [[MKAIndicator currentIndicator] hide];
    }];
}

- (IBAction)onlyStatusBarButtonClicked:(id)sender {
    // Show indicator on the status bar only.
    [[MKAIndicator onlyStatusBarIndicator] showInView:self.view withTouchDisabled:NO];
}

- (IBAction)stopButtonClicked:(id)sender {
    // Hide if needed.
    [[MKAIndicator currentIndicator] hide];
}

@end
