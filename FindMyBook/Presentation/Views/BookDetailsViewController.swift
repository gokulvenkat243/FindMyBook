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
        return scrollView
    }()

    private var contentView: UIView = {
        let view: UIView = UIView.construct()
        return view
    }()

    private var bookDetailsTopView: BookDetailTopView = {
        let view: BookDetailTopView = BookDetailTopView()
        return view
    }()

    private var bookDetailsBottomView: BookDetailBottomView = {
        let view: BookDetailBottomView = BookDetailBottomView()
        return view
    }()

    private let stackView: UIStackView = {
        let stack: UIStackView = UIStackView.construct()
        stack.axis = .vertical
        stack.spacing = 25
        return stack
    }()

    private var viewModel: BookDetailsViewModel

    init(viewModel: BookDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Book Details"
        view.backgroundColor = .systemGray6
        self.setupViews()
        viewModel.fetchBookDetails()
        bookDetailsTopView.delegate = self
    }

    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(stackView)
        [bookDetailsTopView, bookDetailsBottomView].forEach { stackView.addArrangedSubview($0) }
        self.applyConstraints()
        self.bindViewModel()
    }

    private func applyConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            stackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }

    private func bindViewModel() {
        viewModel.updateBookDetailsData = { [self] data in
            self.bookDetailsTopView.configureTopViewData(data: data)
            self.bookDetailsBottomView.configureBottomViewData(data: data)
        }
    }

    @objc
    private func tapBackButton() {
        
    }
}

extension BookDetailsViewController: InfoButtonsDelegate {
    func didTapInfoButton() {
        if let link = viewModel.bookDetailsData?.infoLink, let url = URL(string: link) {
            return UIApplication.shared.open(url)
        }
    }
    
    func didTapReadPreviewButton() {
        if let link = viewModel.bookDetailsData?.webReaderLink, let url = URL(string: link) {
            return UIApplication.shared.open(url)
        }
    }
}
