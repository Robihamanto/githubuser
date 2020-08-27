//
//  UserDetailsViewController.swift
//  Strangers
//
//  Created by Robihamanto on 17/08/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UserDetailsViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var userPhotoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UITextView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var linkLabelButton: UIButton!
    @IBOutlet weak var isStaff: UIView!
    @IBOutlet weak var isLoadingActivityIndicatior: UIActivityIndicatorView!
    
    weak var coordinator: UserCoordinator?
    var userID = 0
    
    private var viewModel: UserDetailsViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = UserDetailsViewModel(userID: userID)
        setupViews()
        bindViewModel()
    }
    
    private func bindViewModel() {
        let outputs = viewModel.output
        
        outputs.user.subscribe(onNext: { user in
            self.userPhotoImageView.kf.setImage(with: URL(string: user.avatar ?? ""))
            self.nameLabel.text = user.name ?? "N/A"
            self.bioLabel.text = user.bio ?? "N/A"
            self.usernameLabel.text = user.login ?? "N/A"
            self.locationLabel.text = user.location ?? "N/A"
            self.linkLabelButton.titleLabel?.text = user.url ?? "URL N/A"
            
            self.isStaff.isHidden = !(user.isAdmin ?? false)
            
            }).disposed(by: disposeBag)
        
        outputs.isLoading
            .bind(to:
                isLoadingActivityIndicatior
                .rx
                .isAnimating)
            .disposed(by: disposeBag)
        
        outputs.error.subscribe(onNext: { error in
            print(error)
            }).disposed(by: disposeBag)
    }
    
    func setupViews() {
        userPhotoImageView
            .layer
            .cornerRadius = userPhotoImageView.bounds.height / 2
    }
}
