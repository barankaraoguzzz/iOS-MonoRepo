//
//  DavinciTextField.swift
//  DavinciKit
//
//  Created by BTCYZ465 on 18.07.2025.
//

import UIKit

public final class DavinciButton: UIButton {
    public enum ButtonStyle {
        case primary, secondary, destructive
    }

    public var style: ButtonStyle = .primary {
        didSet { applyStyle() }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    public init() {
        super.init(frame: .zero)
        commonInit()
    }

    private func commonInit() {
        layer.cornerRadius = 8
        titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        applyStyle()
    }

    private func applyStyle() {
        switch style {
        case .primary:
            backgroundColor = .purple
            setTitleColor(.white, for: .normal)
        case .secondary:
            backgroundColor = .white
            setTitleColor(.purple, for: .normal)
            layer.borderWidth = 1
            layer.borderColor = UIColor.purple.cgColor
        case .destructive:
            backgroundColor = .systemRed
            setTitleColor(.white, for: .normal)
        }
    }
}
