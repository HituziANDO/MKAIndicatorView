//
//  ViewController.swift
//  MKAIndicatorViewSwiftSample
//
//  Created by Masaki Ando on 2018/12/30.
//  Copyright © 2018年 Hituzi Ando. All rights reserved.
//

import UIKit
import MKAIndicatorView

class ViewController: UIViewController {

    @IBOutlet weak var basicButton:           UIButton!
    @IBOutlet weak var customButton:          UIButton!
    @IBOutlet weak var spriteAnimationButton: UIButton!
    @IBOutlet weak var touchDisabledButton:   UIButton!
    @IBOutlet weak var onlyStatusBarButton:   UIButton!
    @IBOutlet weak var stopButton:            UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // When leaving this screen, forcibly terminate the indicator.
        MKAIndicator.default().hideForcibly()
    }

    /// MARK: - IBAction

    @IBAction func basicButtonClicked(_ sender: Any) {
        let indicator = MKAIndicator.default()

        indicator.hide()

        // Setup basic indicator.
        indicator.indicatorType = .basic
        indicator.setActivityIndicatorViewStyle(.whiteLarge)
        indicator.addBlackBackgroundView()

        // Also display on the status bar.
        indicator.withStatusBarIndicator = true

        // Show.
        indicator.show(in: self.view, withTouchDisabled: false)
    }

    @IBAction func customButtonClicked(_ sender: Any) {
        let indicator = MKAIndicator.default()

        indicator.hide()

        // Setup custom indicator.
        indicator.indicatorType = .custom
        indicator.setCustomIndicatorViewImage(UIImage(named: "spinner")!)

        // Show.
        indicator.show(in: self.view, withTouchDisabled: false)
    }

    @IBAction func spriteAnimationButtonClicked(_ sender: Any) {
        let indicator = MKAIndicator.default()

        indicator.hide()

        // Setup sprite animation indicator.
        indicator.indicatorType = .spriteAnimation
        indicator.setSpriteAnimationIndicatorViewImagesWithFormat("indicator%zd", count: 8)
        indicator.setAnimationDuration(0.5)

        // Show.
        indicator.show(in: self.view, withTouchDisabled: false)
    }

    @IBAction func touchDisabledButtonClicked(_ sender: Any) {
        let indicator = MKAIndicator.default()

        indicator.hide()

        // Setup basic indicator.
        indicator.indicatorType = .basic

        // Disable user touch actions when displaying.
        indicator.show(in: self.view, withTouchDisabled: true)
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { timer in indicator.hide() }
    }

    @IBAction func onlyStatusBarButtonClicked(_ sender: Any) {
        let indicator = MKAIndicator.default()

        indicator.hide()

        // Setup only status bar indicator.
        indicator.indicatorType = .onlyStatusBar

        // Show.
        indicator.show(in: self.view, withTouchDisabled: false)
    }

    @IBAction func stopButtonClicked(_ sender: Any) {
        // Hide if needed.
        MKAIndicator.default().hide()
    }
}
