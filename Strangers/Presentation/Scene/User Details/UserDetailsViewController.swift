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
import SafariServices

class UserDetailsViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var userPhotoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UITextView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var isStaff: UIView!
    @IBOutlet weak var isLoadingActivityIndicatior: UIActivityIndicatorView!
    
    weak var coordinator: HomeCoordinator?
    var userID = 0
    var user: User?
    
    private var viewModel: UserDetailsViewModel!
    private let disposeBag = DisposeBag()
    
    deinit {
        print("Class destroyed and memory can reallocated")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = UserDetailsViewModel(userID: userID)
        setupViews()
        bindViewModel()
    }
    
    private func bindViewModel() {
        let outputs = viewModel.output
        
        outputs.user.subscribe(onNext: {[weak self] user in
            self?.user = user
            self?.userPhotoImageView.kf.setImage(with: URL(string: user.avatar ?? ""))
            self?.nameLabel.text = user.name ?? "N/A"
            self?.bioLabel.text = user.bio ?? "N/A"
            self?.usernameLabel.text = user.login ?? "N/A"
            self?.locationLabel.text = user.location ?? "N/A"
            self?.linkLabel.text = user.blog ?? "URL N/A"
            
            self?.isStaff.isHidden = !(user.isAdmin ?? false)
            
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
        
        let linkTap = UITapGestureRecognizer(target: self, action: #selector(linkDidTap))
        linkLabel.addGestureRecognizer(linkTap)
    }
    
    
}

extension UserDetailsViewController: SFSafariViewControllerDelegate {
    
    @objc func linkDidTap() {
        let urlString = user?.blog ?? "https://come.co.id"

        if let url = URL(string: urlString) {
            let vc = SFSafariViewController(url: url)
            vc.delegate = self

            present(vc, animated: true)
        }
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
    
}
