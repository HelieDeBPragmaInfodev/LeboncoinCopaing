//
//  DetailViewController.swift
//  LeBonCoingCopaing
//
//  Created by Hélie de Bernis on 08/08/2022.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    let detailViewModel = DetailViewModel()
    fileprivate let notificationCenter = NotificationCenter.default
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let btnDismiss = UIButton()
    let imageViewFull = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let dateLabel = UILabel()
    let priceLabel = UILabel()
    
    //MARK: ViewControllers Delegate Methods
    
    override func viewDidLoad() {
        self.setUpUserInterface()
        self.startObservingNotificationFromNotificationCenter()
            self.detailViewModel.loadFullScreenImage()
        
    }
    
    deinit {
        self.removeDetailViewObservers()
    }
    
    override func viewDidLayoutSubviews() {
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor).isActive = true
        
        let contentViewCenterY = contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        contentViewCenterY.priority = .defaultLow
        
        let contentViewHeight = contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
        contentViewHeight.priority = .defaultLow
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentViewCenterY.isActive = true
        contentViewHeight.isActive = true
        
        
        imageViewFull.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        imageViewFull.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageViewFull.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        imageViewFull.contentMode = .scaleAspectFit
        imageViewFull.layer.masksToBounds = true
        
        btnDismiss.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        btnDismiss.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10).isActive = true
        btnDismiss.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btnDismiss.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        titleLabel.topAnchor.constraint(equalTo: imageViewFull.bottomAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: imageViewFull.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20).isActive = true
        
        priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: imageViewFull.leadingAnchor, constant: 20).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: imageViewFull.leadingAnchor, constant: 20).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: imageViewFull.leadingAnchor, constant: 20).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: imageViewFull.trailingAnchor, constant: -20).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -50).isActive = true
        
    }
    
    //MARK: Life Cycle Methods
    fileprivate func setUpUserInterface() {
        
        self.view.backgroundColor = .white
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        btnDismiss.translatesAutoresizingMaskIntoConstraints = false
        imageViewFull.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        scrollView.isUserInteractionEnabled = true
        contentView.isUserInteractionEnabled = true
        
        scrollView.alwaysBounceVertical = true
        
        btnDismiss.addTarget(self, action:#selector(btnDismissTaped), for: .touchUpInside)
        btnDismiss.setBackgroundImage(UIImage(systemName: "xmark.circle.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btnDismiss.tintColor = .black
        
        imageViewFull.image = self.detailViewModel.currentListingViewData?.bigThumbsImage ?? UIImage(systemName: "camera.metering.unknown")!
        
        titleLabel.text = self.detailViewModel.currentListingViewData?.title
        priceLabel.text = "\(self.detailViewModel.currentListingViewData?.price ?? 0) €"
        dateLabel.text = self.detailViewModel.currentListingViewData?.creationDateString
        descriptionLabel.text = self.detailViewModel.currentListingViewData?.description
        
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        dateLabel.numberOfLines = 1
        dateLabel.font = UIFont.systemFont(ofSize: 16)
        
        priceLabel.numberOfLines = 1
        priceLabel.font = UIFont.systemFont(ofSize: 16)
        
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.sizeToFit()
        
        
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        self.view.addSubview(btnDismiss)
        
        contentView.addSubview(imageViewFull)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(descriptionLabel)
        
    }
    
    fileprivate func startObservingNotificationFromNotificationCenter() {
        self.notificationCenter.addObserver(forName:  Notification.Name(rawValue: NotificationCenterKeys.userDidReceivedFullScreenThumbnail) , object: nil, queue: .main) { [weak self] notification in
            
            self?.refreshFullView()
        }
    }
    
    fileprivate func removeDetailViewObservers() {
        print("Remove Observer on Detail View Controller")
        self.notificationCenter.removeObserver(self)
    }
    
    fileprivate func refreshFullView() {
        self.imageViewFull.image = self.detailViewModel.currentListingViewData?.bigThumbsImage
    }
    
    @objc func btnDismissTaped() {
        self.dismiss(animated: true)
    }
    
}
