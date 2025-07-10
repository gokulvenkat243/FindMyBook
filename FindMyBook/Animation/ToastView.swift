//
//  ToastView.swift
//  FindMyBook
//
//  Created by gokul v on 10/07/25.
//

import UIKit

class ToastView: UIView {

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    init(message: String) {
        super.init(frame: .zero)
        self.setupView(message: message)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView(message: String) {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true

        messageLabel.text = message
        self.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}

