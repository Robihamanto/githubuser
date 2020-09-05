//
//  SettingViewController.swift
//  Strangers
//
//  Created by Robihamanto on 17/08/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SettingViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var coordinator: SettingCoordinator?
    private let disposeBag = DisposeBag()
    private var viewModel: SettingViewModel!
    
    private var user: User?
    private var cellData = [["Followers", "Following"], ["Repositories", "Events"], ["Blog"]]

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SettingViewModel()
        
        setupViews()
        bindViewModel()
    }
    
    func setupViews() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func bindViewModel() {
        let outputs = viewModel.output
        
        outputs.user.subscribe(onNext: {[weak self] user in
            self?.user = user
            self?.tableView.reloadData()
            }).disposed(by: disposeBag)
    }

}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellData.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.backgroundColor = UIColor.systemGray6
        
        return view
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SettingCell()
        cell.accessoryType = .disclosureIndicator
        
        
        
        
        
        let section = indexPath.section
        let row = indexPath.row
        
        switch (section, row) {
        case (0,0):
            cell.imageView?.image = UIImage(systemName: "person.2")
            cell.textLabel?.text = cellData[section][row]
        case (0,1):
            cell.imageView?.image = UIImage(systemName: "person.2")
            cell.textLabel?.text = cellData[section][row]
        case (1,0):
            cell.imageView?.image = UIImage(systemName: "folder")
            cell.textLabel?.text = cellData[section][row]
        case (1,1):
            cell.imageView?.image = UIImage(systemName: "paperplane")
            cell.textLabel?.text = cellData[section][row]
        case (2,0):
            cell.imageView?.image = UIImage(systemName: "quote.bubble")
            cell.textLabel?.text = cellData[section][row]
        default:
            cell.imageView?.image = UIImage(systemName: "")
            cell.textLabel?.text = ""
        }
        
        return cell
    }
    
    
}
