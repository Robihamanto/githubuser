//
//  HomeViewController.swift
//  Strangers
//
//  Created by Robihamanto on 17/08/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?
    private var viewModel: HomeViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var data = ["anjay", "anjuy", "ashiyap"]
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = HomeViewModel(fetchUsersUseCase: FetchUsersUseCase(userRepository: UserRepository()))
        viewModel.fetchUsers { result in
            self.users = result
            self.tableView.reloadData()
        }
        
        setupView()
        registerNib()
        
        tableView?.delegate = self
        tableView?.dataSource = self
    }
    
    func setupView() {
        navigationItem.rightBarButtonItems = [UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addUserDidTap))]
    }
    
    func registerNib() {
        let nib = UINib(nibName: UserTableViewCell.reusableIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: UserTableViewCell.reusableIdentifier)
    }
    
    
    @objc func addUserDidTap() {
        coordinator?.navigateToSetting()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.navigateToUserDetail(to: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: UserTableViewCell.reusableIdentifier,
            for: indexPath) as? UserTableViewCell else { return UITableViewCell() }
        
        cell.updateView(user: users[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
}
