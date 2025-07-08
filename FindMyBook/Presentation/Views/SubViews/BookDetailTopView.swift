//
//  BookDetailsTopView.swift
//  FindMyBook
//
//  Created by gokul v on 05/07/25.
//

import UIKit

protocol InfoButtonsDelegate: AnyObject {
    func didTapInfoButton()
    func didTapReadPreviewButton()
}

final class BookDetailTopView: UIView {

    private let bookImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "EmptyBookImage") // Placeholder image
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Atomic Habits"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "A Contemporary Issues Approach"
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textAlignment = .center
        return label
    }()

    private let authorLabel: UILabel = {
        let label = UILabel()
        label.text = "James Clear"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        label.textColor = .systemGreen
        return label
    }()

    private let descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "A revolutionary approach to urfurf ruhrc rrijric crcikd ejeeocjeo neijcc rcijcirc rcirc ricnrc rcnr irnc rinrfjowk enceocecinc ricneicnhrufh fenrif nrfirjf  ircuiejdje hbchrc fherbc uerf eufue enduend ednec e efth yhrgh ththt huj et gtr ththr yhyhy ybuilding good habits and breaking bad ones."
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 0
        return label
    }()

    private let stackView: UIStackView = {
        let stack: UIStackView = UIStackView.construct()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .center
        return stack
    }()

    private let buttonsStackView: UIStackView = {
        let stack: UIStackView = UIStackView.construct()
        stack.axis = .horizontal
        stack.spacing = 20
        stack.alignment = .fill
        return stack
    }()

    private let readPreviewButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Read Book", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setImage(UIImage(systemName: "book"), for: .normal)
        button.tintColor = .systemBlue
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return button
    }()

    private let moreInfoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("More Info", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setImage(UIImage(systemName: "info.circle"), for: .normal)
        button.tintColor = .systemBlue
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return button
    }()

    weak var delegate: InfoButtonsDelegate?

    init() {
        super.init(frame: .zero)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        self.addSubview(stackView)
        [bookImageView, titleLabel, subTitleLabel, authorLabel, buttonsStackView, descriptionTitleLabel, descriptionLabel].forEach({ stackView.addArrangedSubview($0) })
        [readPreviewButton, moreInfoButton].forEach({ buttonsStackView.addArrangedSubview($0) })
        self.applyConstraints()
        self.addTargetToButtons()
    }

    private func addTargetToButtons() {
        moreInfoButton.addTarget(self, action: #selector(didTapInfoButton), for: .touchUpInside)
        readPreviewButton.addTarget(self, action: #selector(didTapReadPreviewButton), for: .touchUpInside)
    }

    private func applyConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),

            bookImageView.widthAnchor.constraint(equalToConstant: 250),
            bookImageView.heightAnchor.constraint(equalToConstant: 350),

            descriptionTitleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),

            readPreviewButton.heightAnchor.constraint(equalToConstant: 45),
            readPreviewButton.widthAnchor.constraint(equalTo: buttonsStackView.widthAnchor, multiplier: 1/2.1),
            moreInfoButton.heightAnchor.constraint(equalTo: readPreviewButton.heightAnchor),
            moreInfoButton.widthAnchor.constraint(equalTo: buttonsStackView.widthAnchor, multiplier: 1/2.1),
        ])
    }

    func configureTopViewData(data: BookDetailsPageData) {
        titleLabel.text = data.title
        subTitleLabel.text = data.subtitle
        authorLabel.text = data.authors?.joined(separator: ", ") ?? "Unknown"
        bookImageView.loadImage(imageUrl: data.thumbnail)
        descriptionLabel.text = data.description
    }

    @objc
    private func didTapInfoButton() {
        self.delegate?.didTapInfoButton()
    }

    @objc
    private func didTapReadPreviewButton() {
        self.delegate?.didTapReadPreviewButton()
    }
}
