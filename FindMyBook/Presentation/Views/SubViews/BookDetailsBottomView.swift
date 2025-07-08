//
//  BookDetailsBottomView.swift
//  FindMyBook
//
//  Created by gokul v on 05/07/25.
//

import UIKit

final class BookDetailBottomView: UIView {

    private var publishedTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Published"
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()

    private var publishedValueLabel: UILabel = {
        let label = UILabel()
        label.text = "2018-10-16"
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()

    private var publisherTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Publisher"
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()

    private var publisherValueLabel: UILabel = {
        let label = UILabel()
        label.text = "CRC Press"
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()

    private var pageCountTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Page Count"
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()

    private var pageCountValueLabel: UILabel = {
        let label = UILabel()
        label.text = "320"
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()

    private let stackView: UIStackView = {
        let stack: UIStackView = UIStackView.construct()
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .center
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        self.addSubviews(stackView)
        self.stackView.addArrangedSubview(createRow(keyLabel: &publishedTitleLabel, valueLabel: &publishedValueLabel))
        self.stackView.addArrangedSubview(createRow(keyLabel: &publisherTitleLabel, valueLabel: &publisherValueLabel))
        self.stackView.addArrangedSubview(createRow(keyLabel: &pageCountTitleLabel, valueLabel: &pageCountValueLabel))
        self.applyConstraints()
    }

    private func applyConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),

            publishedTitleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 5),
            publisherTitleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 5),
            pageCountTitleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 5),

            publishedValueLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -5),
            publisherValueLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -5),
            pageCountValueLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -5),
        ])
    }

    private func createRow(keyLabel: inout UILabel, valueLabel: inout UILabel) -> UIStackView {
        let stackView: UIStackView = UIStackView.construct()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.addArrangedSubview(keyLabel)
        stackView.addArrangedSubview(valueLabel)
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 1
        stackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        stackView.layer.cornerRadius = 12
        stackView.clipsToBounds = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        return stackView
    }

    func configureBottomViewData(data: BookDetailsPageData) {
        publishedValueLabel.text = data.publishedDate
        publisherValueLabel.text = data.publisher
        pageCountValueLabel.text = "\(data.pageCount ?? 0)"
    }
}
