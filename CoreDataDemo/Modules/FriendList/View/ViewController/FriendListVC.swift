//
//  TestVC.swift
//  CoreDataDemo
//
//  Created by Ankit Verma on 26/07/23.
//

import UIKit
import CoreData

/// View Controller for FriendListScreen
class FriendListVC: UIViewController {

    // MARK: - Variables
    
    private let viewModel = FriendListViewModel()

    // MARK: - IB Outlets

    @IBOutlet private weak var friendListTableView: UITableView!

    // MARK: - View Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetups()
    }
}

// MARK: - Functions

private extension FriendListVC {
    func initialSetups() {
        setupNavigation()
        setupTableView()
        setupAddFriendButton()
        setObserver()
    }
    
    func setObserver() {
        viewModel.friends.bind { friends in
            DispatchQueue.main.async { [weak self] in
                guard let self else {
                    return
                }
                self.friendListTableView.reloadData()
            }
        }
    }

    func setupNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = R.string.friendsList.navigationItemTitle()
    }

    func setupTableView() {
        friendListTableView.delegate = self
        friendListTableView.dataSource = self
        friendListTableView.register(R.nib.friendTVCell)
    }

    func setupAddFriendButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addFriendButtonTapped))
    }

    @objc private func addFriendButtonTapped() {
        let alert = UIAlertController(title: R.string.friendsList.addFriendAlertTitle(),
                                      message: R.string.friendsList.addFriendAlertMessage(),
                                      preferredStyle: .alert)

        let saveAction = UIAlertAction(title: R.string.friendsList.addFriendAlertSave(),
                                       style: .default) { [weak self] _ in

            guard let textField = alert.textFields?.first,
                  let nameToSave = textField.text,
                  let self else {
                return
            }
            let friend = Friend(name: nameToSave)
            self.viewModel.addFriend(friend)
        }

        let cancelAction = UIAlertAction(title: R.string.friendsList.addFriendAlertCancel(),
                                         style: .cancel)

        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)

        present(alert, animated: true)
    }
}

// MARK: - TableView Datasource & Delegate Methods

extension FriendListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.friends.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.friendTVCell,
                                                       for: indexPath) else {
            return UITableViewCell()
        }
        let friend = viewModel.friends.value[indexPath.row]
        cell.configure(with: friend)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let alert = UIAlertController(title: R.string.friendsList.editFriendAlertTitle(),
                                      message: R.string.friendsList.editFriendAlertMessage(),
                                      preferredStyle: .alert)

        let saveAction = UIAlertAction(title: R.string.friendsList.editFriendAlertSave(),
                                       style: .default) { [weak self] _ in

            guard let textField = alert.textFields?.first,
                  let nameToSave = textField.text,
                  let self else {
                return
            }

            var friend = self.viewModel.friends.value[indexPath.row]
            friend.name = nameToSave
            self.viewModel.updateFriend(friend)
        }

        let cancelAction = UIAlertAction(title: R.string.friendsList.editFriendAlertCancel(),
                                         style: .cancel)

        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)

        present(alert, animated: true)
    }

    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive,
                                        title: R.string.friendsList.deleteFriendActionTitle()) { [weak self] _, _, _ in
            guard let self else {
                return
            }
            let friendToRemove = self.viewModel.friends.value[indexPath.row]
            self.viewModel.deteleFriend(friendToRemove)
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}
