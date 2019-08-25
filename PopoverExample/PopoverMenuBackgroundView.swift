//
//  PopoverMenuBackgroundView.swift
//  PopoverExample
//
//  Created by Hajime Imamura on 2019/08/25.
//  Copyright © 2019 imamurh. All rights reserved.
//

import UIKit

final class PopoverMenuBackgroundView: UIPopoverBackgroundView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = .clear
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowOpacity = 0
        setupPathLayer()
    }

    // MARK: - UIPopoverBackgroundViewMethods

    override static func arrowBase() -> CGFloat {
        return 20
    }

    override static func arrowHeight() -> CGFloat {
        return 10
    }

    override static func contentViewInsets() -> UIEdgeInsets {
        return .zero
    }

    // MARK: - Overriding UIPopoverBackgroundView properties

    private var _arrowOffset: CGFloat = 0
    override var arrowOffset: CGFloat {
        get { return _arrowOffset }
        set { _arrowOffset = newValue }
    }

    private var _arrowDirection: UIPopoverArrowDirection = .up
    override var arrowDirection: UIPopoverArrowDirection {
        get { return _arrowDirection }
        set { _arrowDirection = newValue }
    }

    // MARK: - Drawing

    private func setupPathLayer() {
        layer.sublayers?.forEach { $0.removeFromSuperlayer() }

        let rect = bounds
        let pathLayer = CAShapeLayer()
        pathLayer.frame = rect
        pathLayer.path = generatePath(rect, cornerRadius: 10).cgPath
        pathLayer.fillColor = UIColor(white: 1, alpha: 0.95).cgColor
        pathLayer.strokeColor = UIColor(white: 0.8, alpha: 1).cgColor
        pathLayer.lineWidth = 2
        layer.addSublayer(pathLayer)
    }

    private func generatePath(_ rect: CGRect, cornerRadius: CGFloat) -> UIBezierPath {
        let insets: UIEdgeInsets = {
            var insets = PopoverMenuBackgroundView.contentViewInsets()
            if _arrowDirection == .up {
                insets.top += PopoverMenuBackgroundView.arrowHeight()
            }
            return insets
        }()
        let topLeft     = CGPoint(x: insets.left,               y: insets.top)
        let topRight    = CGPoint(x: rect.maxX - insets.right,  y: insets.top)
        let bottomRight = CGPoint(x: rect.maxX - insets.right,  y: rect.maxY - insets.bottom)
        let bottomLeft  = CGPoint(x: insets.left,               y: rect.maxY - insets.bottom)

        let path = UIBezierPath()
        path.move(to: CGPoint(x: topLeft.x + cornerRadius, y: topLeft.y))
        if _arrowDirection == .up {
            let arrowBase = PopoverMenuBackgroundView.arrowBase()
            let arrowCenterX = rect.size.width / 2 + _arrowOffset
            path.addLine(to: CGPoint(x: arrowCenterX - arrowBase / 2, y: insets.top))
            path.addLine(to: CGPoint(x: arrowCenterX, y: 0))
            path.addLine(to: CGPoint(x: arrowCenterX + arrowBase / 2, y: insets.top))
        }
        path.addLine(to: CGPoint(x: topRight.x - cornerRadius, y: topRight.y))
        path.addQuadCurve(to: CGPoint(x: topRight.x, y: topRight.y + cornerRadius), controlPoint: topRight)

        path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y - cornerRadius))
        path.addQuadCurve(to: CGPoint(x: bottomRight.x - cornerRadius, y: bottomRight.y), controlPoint: bottomRight)

        path.addLine(to: CGPoint(x: bottomLeft.x + cornerRadius, y: bottomLeft.y))
        path.addQuadCurve(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y - cornerRadius), controlPoint: bottomLeft)

        path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y + cornerRadius))
        path.addQuadCurve(to: CGPoint(x: topLeft.x + cornerRadius, y: topLeft.y), controlPoint: topLeft)

        return path
    }
}
