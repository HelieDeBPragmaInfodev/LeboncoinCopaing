//
//  HomeViewModel.swift
//  LeBonCoingCopaing
//
//  Created by Hélie de Bernis on 03/08/2022.
//

import Foundation
import NotificationCenter

class HomeViewModel {
    
    fileprivate var currentListOfListing : [ListingElement]
    fileprivate var currentCategories : [CategorieElement]
    fileprivate let networkSessionManager: NetworkSessionManager = NetworkSessionManager.shared
    fileprivate let notificationCenter = NotificationCenter.default
    fileprivate var smallThumbsReceivedCounter: Int = 3
    
    public var currentCategoryListViewData : [ListingViewData]
    
    init() {
        self.currentListOfListing = []
        self.currentCategories = []
        self.currentCategoryListViewData = []
    }
    
    public func loadListing() {
        getCategoriesFromWebService { [weak self] categoriesListReceived, listOfCategories  in
            if categoriesListReceived {
                guard let listOfCategories = listOfCategories else {
                    print(HTTPRequestError.unknownError(withError: "The list of Categories received is nil"))
                    return
                }
                print("success to get categories list")
                self?.getListingFromWebService { [weak self] listingListReceived, listOflisting  in
                    if listingListReceived {
                        guard let listOflisting = listOflisting else {
                            print(HTTPRequestError.unknownError(withError: "The list of Listing received is nil"))
                            return
                        }
                        print("success to get listing list")
                        //print(listOflisting)
                        DispatchQueue.main.async {
                            self?.currentCategories = listOfCategories
                            self?.currentListOfListing = listOflisting
                            
                            for list in listOflisting {
                                let viewData = ListingViewData(listingElement: list, categoriesList: listOfCategories)
                                self?.currentCategoryListViewData.append(viewData)
                            }
                            
                            self?.notificationCenter.post(name: Notification.Name(NotificationCenterKeys.listOfListingReceivedSuccessfully), object: nil)
                        }
                        
                    }
                    
                }
            }
        }
    }
    
    public func getThumbsImageForListingViewDataAtIndex(index: Int) -> UIImage {
        
        guard self.currentCategoryListViewData.count > index else {
            return UIImage(systemName: "camera.metering.unknown")!
        }
        let viewData = self.currentCategoryListViewData[index]
        
        if viewData.isSmallThumbsAlreadyCached {
            return viewData.smallThumbsImage!
        }else {
            guard let imageLink = viewData.imagesUrl.small else {
                return UIImage(systemName: "camera.metering.unknown")!
            }
            var finalImageReturned = UIImage(systemName: "camera.metering.unknown")!
            
            
            self.getSmallThumbsFromUrl(urlString: imageLink) { [weak self] smallThumbsDownloaded, image in
                
                if smallThumbsDownloaded {
                    guard let image = image else {
                        finalImageReturned = UIImage(systemName: "camera.metering.unknown")!
                        return
                    }
                    let cropImage = self?.cropImage(sourceImage: image)
                    finalImageReturned = cropImage ?? finalImageReturned
                    viewData.isSmallThumbsAlreadyCached = true
                    viewData.smallThumbsImage = finalImageReturned
                    self?.userDidReceivedSmallThumbs()
                }
            }
            
            return finalImageReturned
        }
        
        
    }
    
    
    
    
    //MARK: Helpers
    fileprivate func userDidReceivedSmallThumbs() {
        
        smallThumbsReceivedCounter += 1
        if smallThumbsReceivedCounter > 5 {
            self.notificationCenter.post(name: Notification.Name(NotificationCenterKeys.userDidReceivedSmallThumbnail), object: nil)
            smallThumbsReceivedCounter = 0
        }
    }
    
    fileprivate func cropImage(sourceImage: UIImage) -> UIImage {
        
        // The shortest side
        let sideLength = min(
            sourceImage.size.width,
            sourceImage.size.height
        )

        // Determines the x,y coordinate of a centered
        // sideLength by sideLength square
        let sourceSize = sourceImage.size
        let xOffset = (sourceSize.width - sideLength) / 2.0
        let yOffset = (sourceSize.height - sideLength) / 2.0

        // The cropRect is the rect of the image to keep,
        // in this case centered
        let cropRect = CGRect(
            x: xOffset,
            y: yOffset,
            width: sideLength,
            height: sideLength
        ).integral

        // Center crop the image
        let sourceCGImage = sourceImage.cgImage!
        let croppedCGImage = sourceCGImage.cropping(
            to: cropRect
        )!
        
        // Use the cropped cgImage to initialize a cropped
        // UIImage with the same image scale and orientation
        let croppedImage = UIImage(
            cgImage: croppedCGImage,
            scale: sourceImage.imageRendererFormat.scale,
            orientation: sourceImage.imageOrientation
        )
        
        return croppedImage
    }
    
    
    fileprivate func getSmallThumbsFromUrl(urlString:String, completion:@escaping (Bool, UIImage?)-> Void) {
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
    
    fileprivate func getCategoriesFromWebService(completion:@escaping (Bool, [CategorieElement]?)-> Void) {
        networkSessionManager.sendHttpRequest(onMainThread: false, to: UrlServiceKeys.categoriesAPIUrlString) { result in
            switch result {
            case .success(let data):
                do {
                    let categorie = try JSONDecoder().decode([CategorieElement].self, from: data)
                    completion(true, categorie)
                }catch(let error){
                    print(HTTPRequestError.jsonDecodingError(withError: error.localizedDescription))
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
    
    fileprivate func getListingFromWebService(completion:@escaping (Bool, [ListingElement]?)-> Void) {
        networkSessionManager.sendHttpRequest(onMainThread: false, to: UrlServiceKeys.listingAPIUrlString) { result in
            switch result {
            case .success(let data):
                do {
                    let listing = try JSONDecoder().decode([ListingElement].self, from: data)
                    completion(true, listing)
                }catch(let error){
                    print(HTTPRequestError.jsonDecodingError(withError: error.localizedDescription))
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
