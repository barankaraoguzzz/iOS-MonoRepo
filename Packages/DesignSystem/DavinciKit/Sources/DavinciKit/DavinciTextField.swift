//
//  DavinciTextField.swift
//  DavinciKit
//
//  Created by BTCYZ465 on 18.07.2025.
//

import Foundation
import UIKit

public final class DavinciTextField: UITextField {
    public var padding = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        layer.cornerRadius = 6
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray4.cgColor
        font = .systemFont(ofSize: 16)
        clearButtonMode = .whileEditing
        autocorrectionType = .no
    }

    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
}
