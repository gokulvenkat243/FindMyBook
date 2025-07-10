//
//  FavoriteBooksViewController.swift
//  FindMyBook
//
//  Created by gokul v on 09/07/25.
//

import UIKit

class FavoriteBooksViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView: UITableView = UITableView.construct()
        tableView.rowHeight = 90
        tableView.separatorStyle = .none
        tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.defaultReuseIdentifier)
        return tableView
    }()

    private let noFavLabel: UILabel = {
        let label: UILabel = UILabel.construct()
        label.text = "No Favorites"
        label.isHidden = true
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()

    private var viewModel: FavoriteBooksViewModel

    init(viewModel: FavoriteBooksViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorite Books"
        view.addSubview(tableView)
        tableView.addSubview(noFavLabel)
        tableView.dataSource = self
        tableView.delegate = self
        self.applyConstraints()
        self.bindViewModel()
        self.viewModel.fetchFavoriteBooks()
        self.setupNoFavoriteLabel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchFavoriteBooks()
        self.setupNoFavoriteLabel()
    }

    private func applyConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            noFavLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            noFavLabel.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
        ])
    }

    private func setupNoFavoriteLabel() {
        if viewModel.numberOfItems() == 0 {
            noFavLabel.isHidden = false
            tableView.reloadData()
        } else {
            noFavLabel.isHidden = true
            tableView.reloadData()
        }
    }

    private func bindViewModel() {
        self.viewModel.onDataChanged = { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension FavoriteBooksViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.defaultReuseIdentifier, for: indexPath) as? FavoriteTableViewCell else {
            return UITableViewCell()
        }
        let data = viewModel.getBook(at: indexPath.row)
        cell.configure(data: data)
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = viewModel.getBook(at: indexPath.row)
        self.viewModel.showBookDetails(id: data.id)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeFavorite(at: indexPath.row)
            self.showToast(message: "Removed from Favorite💔")
            tableView.reloadData()
        }
    }
}
