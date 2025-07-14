//
//  HistoryTableViewCell.swift
//  FindMyBook
//
//  Created by gokul v on 14/07/25.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    private let titleLabel: UILabel = {
        let label: UILabel = UILabel.construct()
        label.text = "The Midnight Library"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()

    private let dateLabel: UILabel = {
        let label: UILabel = UILabel.construct()
        label.text = "James Clear"
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        contentView.addSubviews(titleLabel, dateLabel)
        self.applyConstraints()
    }

    private func applyConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    func configure(data: HistoryModel) {
        titleLabel.text = data.title
        dateLabel.text = "\(data.viewedDate)"
    }
}
