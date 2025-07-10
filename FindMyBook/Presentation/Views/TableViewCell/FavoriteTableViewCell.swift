//
//  FavoriteTableViewCell.swift
//  FindMyBook
//
//  Created by gokul v on 09/07/25.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    private let bookImageView: UIImageView = {
        let imageView: UIImageView = UIImageView.construct()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "EmptyBookImage")
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label: UILabel = UILabel.construct()
        label.text = "The Midnight Library"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()

    private let authorLabel: UILabel = {
        let label: UILabel = UILabel.construct()
        label.text = "James Clear"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()

    private let ratingView: UIView = {
        let view: UIView = UIView.construct()
        view.backgroundColor = .red
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        contentView.addSubviews(bookImageView, titleLabel, authorLabel, ratingView)
        self.applyConstraints()
    }

    private func applyConstraints() {

        NSLayoutConstraint.activate([
            bookImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            bookImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            bookImageView.widthAnchor.constraint(equalToConstant: 80),
            bookImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            authorLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 10),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            ratingView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 15),
            ratingView.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 10),
            ratingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            ratingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }

    func configure(data: FavoriteBooksModel) {
        titleLabel.text = data.title
        authorLabel.text = data.author
    }
}
