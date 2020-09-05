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
    private var cellDataImageName = [["person.2", "person.2"], ["folder", "paperplane"], ["quote.bubble"]]

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
        
        let section = indexPath.section
        let row = indexPath.row
        
        let title = cellData[section][row]
        let imageName = cellDataImageName[section][row]
        
        let cell = SettingCell()
        cell.accessoryType = .disclosureIndicator
        cell.imageView?.image = UIImage(systemName: imageName)
        cell.textLabel?.text = title
        
        return cell
    }
    
    
}
