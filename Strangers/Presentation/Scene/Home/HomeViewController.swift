//
//  HomeViewController.swift
//  Strangers
//
//  Created by Robihamanto on 17/08/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController, Storyboarded {
    
    weak var coordinator: HomeCoordinator?
    private var viewModel: HomeViewModel!
    private var loadMore = false
    private var users = [User]()
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel()
        
        bindViewModel()
        setupTableView()
    }
    
    func setupTableView() {
        tableView?.delegate = self
        tableView?.dataSource = self
        let nib = UINib(nibName: UserTableViewCell.reusableIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: UserTableViewCell.reusableIdentifier)
    }
    
    private func bindViewModel() {
        let outputs = viewModel.output
        
        outputs.users.subscribe(onNext: {[weak self] users in
            self?.users = users
            self?.tableView.reloadData()
            }).disposed(by: disposeBag)
        
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let user = users[indexPath.row]
        //coordinator?.navigateToUserDetail(to: user.id ?? 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        let maxRow = users.count - 5
        
        if row == maxRow {
            viewModel
                .input
                .loadMore
                .accept(true)
        }
        
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
