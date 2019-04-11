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

        // Set default indicator.
        let indicator = MKAIndicator.basicIndicator(with: .gray)
        MKAIndicator.setDefault(indicator)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // When leaving this screen, forcibly terminate the indicator.
        MKAIndicator.default().hideForcibly()
    }

    /// MARK: - IBAction

    @IBAction func basicButtonClicked(_ sender: Any) {
        // Show basic indicator. Also display on the status bar.
        let indicator = MKAIndicator.basicIndicator(with: .whiteLarge)
                                    .addBlackBackgroundView()
                                    .alsoStatusBarIndicator()
        MKAIndicator.setDefault(indicator)
        MKAIndicator.default().show(in: self.view, withTouchDisabled: false)
    }

    @IBAction func customButtonClicked(_ sender: Any) {
        // Show custom indicator.
        let indicator = MKAIndicator.customIndicator(withIndicatorViewImage: UIImage(named: "spinner")!)
                                    .setAnimationDuration(1.0)
        MKAIndicator.setDefault(indicator)
        MKAIndicator.default().show(in: self.view, withTouchDisabled: false)
    }

    @IBAction func spriteAnimationButtonClicked(_ sender: Any) {
        // Show sprite animation indicator.
        let indicator = MKAIndicator.spriteAnimationIndicator(withIndicatorViewImagesFormat: "indicator%zd", count: 8)
                                    .setAnimationDuration(0.5)
        MKAIndicator.setDefault(indicator)
        MKAIndicator.default().show(in: self.view, withTouchDisabled: false)
    }

    @IBAction func touchDisabledButtonClicked(_ sender: Any) {
        // Show basic indicator. Disable user touch actions when displaying.
        let indicator = MKAIndicator.basicIndicator(with: .gray)
        MKAIndicator.setDefault(indicator)
        MKAIndicator.default().show(in: self.view, withTouchDisabled: true)

        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { timer in MKAIndicator.default().hide() }
    }

    @IBAction func onlyStatusBarButtonClicked(_ sender: Any) {
        // Show indicator on the status bar only.
        let indicator = MKAIndicator.onlyStatusBarIndicator()
        MKAIndicator.setDefault(indicator)
        MKAIndicator.default().show(in: self.view, withTouchDisabled: false)
    }

    @IBAction func stopButtonClicked(_ sender: Any) {
        // Hide if needed.
        MKAIndicator.default().hide()
    }
}
