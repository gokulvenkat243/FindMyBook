//
//  BooksDetailsViewController.swift
//  FindMyBook
//
//  Created by gokul v on 05/07/25.
//

import UIKit

class BookDetailsViewController: UIViewController {

    private var scrollView: UIScrollView = {
        let scrollView: UIScrollView = UIScrollView.construct()
        scrollView.backgroundColor = .systemGray6
        return scrollView
    }()

    private var contentView: UIView = {
        let view: UIView = UIView.construct()
        view.backgroundColor = .systemGray6
        return view
    }()

    private let bookImageView: UIImageView = {
        let imageView: UIImageView = UIImageView.construct()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label: UILabel = UILabel.construct()
        label.text = "The Midnight Library"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()

    private let subTitleLabel: UILabel = {
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

    private let descriptionLabel: UILabel = {
        let label: UILabel = UILabel.construct()
        label.text = "James Clear"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        self.setupViews()
    }

    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        self.applyConstraints()
    }

    private func applyConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -70),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
    }
}
