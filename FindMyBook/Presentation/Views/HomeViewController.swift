//
//  ViewController.swift
//  FindMyBook
//
//  Created by gokul v on 17/05/25.
//

import UIKit


class HomeViewController: UIViewController {

    private let topView: UIView = {
        let view: UIView = UIView.construct()
        return view
    }()

    private let titleLabel: UILabel = {
        let label: UILabel = UILabel.construct()
        label.text = "FindMyBook"
        label.font = .systemFont(ofSize: 35, weight: .bold)
        return label
    }()

    private let searchBar: UISearchBar = {
        let searchBar: UISearchBar = UISearchBar.construct()
        searchBar.placeholder = "Search Books..."
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()

    private let popularLabel: UILabel = {
        let label: UILabel = UILabel.construct()
        label.text = "Popular Books"
        label.font = .systemFont(ofSize: 26, weight: .bold)
        return label
    }()

    private let tableView: UITableView = {
        let tableView: UITableView = UITableView.construct()
        tableView.rowHeight = 90
        tableView.separatorStyle = .none
        tableView.register(BooksTableViewCell.self, forCellReuseIdentifier: BooksTableViewCell.defaultReuseIdentifier)
        return tableView
    }()

    private var viewModel: BooksHomeViewModel

    init(viewModel: BooksHomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        self.setupViews()
        self.viewModel.fetchTrendingBooks()
        self.bindViewModel()
    }

    private func setupViews() {
        view.addSubviews(topView, tableView)
        topView.addSubviews(titleLabel, searchBar, popularLabel)
        self.applyConstructs()
    }

    private func applyConstructs() {
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 270),

            titleLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 100),
            titleLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor),

            searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            searchBar.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -10),
            searchBar.heightAnchor.constraint(equalToConstant: 50),

            popularLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 26),
            popularLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 20),
            popularLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor),

            tableView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func bindViewModel() {
        self.viewModel.updateBooksData = {
            self.tableView.reloadData()
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BooksTableViewCell.defaultReuseIdentifier, for: indexPath) as? BooksTableViewCell else {
            return UITableViewCell()
        }
        let data = viewModel.getBooksData(index: indexPath.row)
        cell.configure(data: data)
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = viewModel.getBooksData(index: indexPath.row)
        self.viewModel.showBookDetails(id: data.id)
    }
}


