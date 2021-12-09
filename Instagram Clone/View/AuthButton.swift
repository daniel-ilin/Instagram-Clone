//
//  AuthButton.swift
//  Instagram Clone
//
//  Created by Daniel Ilin on 02.12.2021.
//

import Foundation
import UIKit

class AuthButton: UIButton {
    
    init() {
        super.init(frame: CGRect.zero)
        setTitleColor(.white, for: .normal)
        backgroundColor = .systemPurple.withAlphaComponent(0.4)
        layer.cornerRadius = 5
        setHeight(50)
        isEnabled = false
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
