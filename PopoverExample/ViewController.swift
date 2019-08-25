//
//  ViewController.swift
//  PopoverExample
//
//  Created by Hajime Imamura on 2019/08/25.
//  Copyright © 2019 imamurh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func actionBarButtonItemTapped(_ sender: UIBarButtonItem) {
        let vc = PopoverMenuViewController.instantiate() { [weak self] in
            print("Selected Menu Item: \($0)")
            self?.dismiss(animated: true)
        }
        vc.modalPresentationStyle = .popover
        vc.popoverPresentationController?.barButtonItem = sender
        vc.popoverPresentationController?.permittedArrowDirections = .up
        vc.popoverPresentationController?.backgroundColor = UIColor(white: 1, alpha: 0.8)
        vc.popoverPresentationController?.delegate = self
        present(vc, animated: true)
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        guard presentedViewController == nil else {
            dismiss(animated: true)
            return
        }
        let vc = PopoverMenuViewController.instantiate() { [weak self] in
            print("Selected Menu Item: \($0)")
            self?.dismiss(animated: true)
        }
        vc.modalPresentationStyle = .popover
        vc.popoverPresentationController?.sourceView = sender.superview
        vc.popoverPresentationController?.sourceRect = sender.frame
        vc.popoverPresentationController?.permittedArrowDirections = .up
        vc.popoverPresentationController?.delegate = self

        vc.popoverPresentationController?.popoverBackgroundViewClass = PopoverMenuBackgroundView.self

        present(vc, animated: true)
    }
}

extension ViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}
