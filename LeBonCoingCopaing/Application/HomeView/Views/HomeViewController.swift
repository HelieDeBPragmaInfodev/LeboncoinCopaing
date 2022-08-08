//
//  HomeViewController.swift
//  LeBonCoingCopaing
//
//  Created by Hélie de Bernis on 03/08/2022.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    fileprivate let homeViewModel = HomeViewModel()
    fileprivate let mainTableView = UITableView()
    fileprivate let cellReuseIdentifier = "mainTableCellIdentifier"
    fileprivate var currentHomeViewState: HomeViewState = .unload
    fileprivate let notificationCenter = NotificationCenter.default
    
    //MARK: ViewControllers Delegate Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentHomeViewState = .loading
        self.setUpUserInterface()
        self.startObservingNotificationFromNotificationCenter()
        homeViewModel.loadListing()
    }
    
    deinit {
        self.removeHomeViewObservers()
    }
    
    override func viewDidLayoutSubviews() {
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        mainTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    //MARK: Life Cycle Methods
    fileprivate func setUpUserInterface() {
        
        self.view.backgroundColor = .white
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(ListingViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.view.addSubview(mainTableView)
        
    }
    
    fileprivate func startObservingNotificationFromNotificationCenter() {
        self.notificationCenter.addObserver(forName:  Notification.Name(rawValue: NotificationCenterKeys.listOfListingReceivedSuccessfully) , object: nil, queue: .main) { [weak self] notification in
            self?.refreshFullView()
        }
        self.notificationCenter.addObserver(forName:  Notification.Name(rawValue: NotificationCenterKeys.userDidReceivedSmallThumbnail) , object: nil, queue: .main) { [weak self] notification in
            self?.refreshTableView()
        }
    }
    
    fileprivate func removeHomeViewObservers() {
        print("Remove Observer on Home View Controller")
        self.notificationCenter.removeObserver(self)
    }
    
    fileprivate func refreshFullView() {
        mainTableView.reloadData()
        self.currentHomeViewState = .loaded
    }
    
    fileprivate func refreshTableView() {
        mainTableView.reloadData()
    }
    
    //MARK: TableView Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.currentCategoryListViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ListingViewCell = mainTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)! as! ListingViewCell
        cell.smallThumbImageView.image = homeViewModel.getThumbsImageForListingViewDataAtIndex(index: indexPath.row)
        cell.titleLabel.text = self.homeViewModel.currentCategoryListViewData[indexPath.row].title
        cell.priceLabel.text = "\(self.homeViewModel.currentCategoryListViewData[indexPath.row].price) €"
        cell.urgentImageView.isHidden = self.homeViewModel.currentCategoryListViewData[indexPath.row].isUrgent
        cell.categorieLabel.text = self.homeViewModel.currentCategoryListViewData[indexPath.row].categoryName
        cell.creationDateLabel.text = self.homeViewModel.currentCategoryListViewData[indexPath.row].creationDateString
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewData = self.homeViewModel.currentCategoryListViewData[indexPath.row]
        let detailVc = DetailViewController()
        detailVc.detailViewModel.currentListingViewData = viewData
        detailVc.modalPresentationStyle = .overFullScreen
        self.present(detailVc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Dimension.listingCellHeight
    }
    
    
    
}


enum HomeViewState: Int {
    case unload = 0
    case loading = 1
    case loaded = 2
}

