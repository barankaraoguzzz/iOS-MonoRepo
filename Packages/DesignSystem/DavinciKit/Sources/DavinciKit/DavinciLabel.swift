//
//  DavinciLabel.swift
//  DavinciKit
//
//  Created by BTCYZ465 on 18.07.2025.
//

import UIKit

public final class DavinciLabel: UILabel {
    public enum LabelStyle {
        case title, body, footnote
    }

    public var style: LabelStyle = .body {
        didSet { applyStyle() }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        applyStyle()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyStyle()
    }

    private func applyStyle() {
        switch style {
        case .title:
            font = .systemFont(ofSize: 24, weight: .bold)
            textColor = .label
        case .body:
            font = .systemFont(ofSize: 16, weight: .regular)
            textColor = .label
        case .footnote:
            font = .systemFont(ofSize: 12, weight: .light)
            textColor = .secondaryLabel
        }
    }
}
