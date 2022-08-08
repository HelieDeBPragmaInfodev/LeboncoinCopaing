//
//  DetailViewModel.swift
//  LeBonCoingCopaing
//
//  Created by Hélie de Bernis on 08/08/2022.
//

import Foundation
import NotificationCenter

class DetailViewModel {
    
    fileprivate let networkSessionManager: NetworkSessionManager = NetworkSessionManager.shared
    fileprivate let notificationCenter = NotificationCenter.default
    public var currentListingViewData : ListingViewData? = nil
    
    init() {
    }
    
    public func loadFullScreenImage() {
        
        guard let currentListingViewData = self.currentListingViewData else {
            return
        }
        
        guard !currentListingViewData.isFullScreenThumbsAlreadyCached else {
            return
        }
        
        self.getFullScreenImageFromUrl(urlString: currentListingViewData.imagesUrl.thumb!) { [weak self] fullScreenImageDownloaded, image in
            
            guard let self = self else {
                return
            }
            
            
            
            if fullScreenImageDownloaded {
                guard let image = image else {
                    return
                }
                
                currentListingViewData.isFullScreenThumbsAlreadyCached = true
                currentListingViewData.bigThumbsImage = image
                self.userDidReceivedFullScreenThumb()
            }
        }
    }
    //MARK: Helpers
    fileprivate func userDidReceivedFullScreenThumb() {
        self.notificationCenter.post(name: Notification.Name(NotificationCenterKeys.userDidReceivedFullScreenThumbnail), object: nil)
    }
    
    
    fileprivate func getFullScreenImageFromUrl(urlString:String, completion:@escaping (Bool, UIImage?)-> Void) {
        networkSessionManager.sendHttpRequest(onMainThread: true, to: urlString) { result in
            switch result {
            case .success(let data):
                let image = UIImage(data: data)
                
                if let image = image {
                    completion(true, image)
                }else {
                    print(HTTPRequestError.imageDataDecodingError(withError: "Unable to create Image from datas received"))
                    completion(false, nil)
                }
                
                break
            case .failure(let error):
                print(error.localizedDescription)
                completion(false, nil)
                return
            }
        }
    }
    
    
}
