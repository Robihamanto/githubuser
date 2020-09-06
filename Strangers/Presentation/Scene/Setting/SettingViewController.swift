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
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.navigationBar.sizeToFit()
        }
    }
    
    private func setupViews() {
        title = "Setting"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    private func bindViewModel() {
        let outputs = viewModel.output
        
        outputs.user.subscribe(onNext: {[weak self] user in
            self?.user = user
            self?.tableView.reloadData()
            self?.updateProfile()
            }).disposed(by: disposeBag)
    }
    
    private func updateProfile() {
        nameLabel.text = self.user?.name
        companyLabel.text = self.user?.company
        locationLabel.text = self.user?.location
        
        guard let url = URL(string: user?.avatar ?? "") else { return }
        profileImageView.kf.setImage(with: url)
        profileImageView
            .layer
            .cornerRadius = profileImageView.bounds.height / 2 
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
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "profileCell")
        
        cell.accessoryType = .disclosureIndicator
        cell.imageView?.image = UIImage(systemName: imageName)
        cell.textLabel?.text = title
        
        if section == 0 && row == 0 {
            let followers = self.user?.followers ?? 0
            cell.detailTextLabel?.text = "\(followers)"
        }
        
        if section == 0 && row == 1 {
            let following = self.user?.following ?? 0
            cell.detailTextLabel?.text = "\(following)"
        }
        
        return cell
    }
    
}
