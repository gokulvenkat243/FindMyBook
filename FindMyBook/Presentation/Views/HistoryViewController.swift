//
//  HistoryViewController.swift
//  FindMyBook
//
//  Created by gokul v on 11/07/25.
//

import UIKit

class HistoryViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView: UITableView = UITableView.construct()
        tableView.rowHeight = 90
        tableView.separatorStyle = .singleLine
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.defaultReuseIdentifier)
        return tableView
    }()

    private let noHistoryLabel: UILabel = {
        let label: UILabel = UILabel.construct()
        label.text = "No History"
        label.isHidden = true
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()

    private var viewModel: HistoryViewModel

    init(viewModel: HistoryViewModel) {
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
        tableView.addSubview(noHistoryLabel)
        tableView.dataSource = self
        tableView.delegate = self
        self.applyConstraints()
        self.bindViewModel()
        self.setupNoHistoryLabel()
        self.viewModel.fetchHistory()
        self.setupBarButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchHistory()
        self.setupNoHistoryLabel()
    }

    private func applyConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            noHistoryLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            noHistoryLabel.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
        ])
    }

    private func setupNoHistoryLabel() {
        if viewModel.numberOfItems() == 0 {
            noHistoryLabel.isHidden = false
            tableView.reloadData()
        } else {
            noHistoryLabel.isHidden = true
            tableView.reloadData()
        }
    }

    private func bindViewModel() {
        self.viewModel.onDataChanged = { [weak self] in
            self?.tableView.reloadData()
        }
    }

    private func setupBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Clear All", style: .done, target: self, action: #selector(removeAllHistory))
    }

    @objc
    private func removeAllHistory() {
        self.viewModel.clearAllHistory()
    }
}

extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.defaultReuseIdentifier, for: indexPath) as? HistoryTableViewCell else {
            return UITableViewCell()
        }
        let data = viewModel.getItem(at: indexPath.row)
        cell.configure(data: data)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeParticularHistory(at: indexPath.row)
            self.showToast(message: "Removed from History💔")
            tableView.reloadData()
        }
    }
}
