//
//  ListingCellViewData.swift
//  LeBonCoingCopaing
//
//  Created by Hélie de Bernis on 08/08/2022.
//

import Foundation
import UIKit


class ListingViewData {
    let id, categoryId: Int
    let title, description: String
    let price: Double
    let imagesUrl: ImagesURL
    let creationDateString: String
    let isUrgent: Bool
    let siret: String?
    var isSmallThumbsAlreadyCached: Bool = false
    var isFullScreenThumbsAlreadyCached: Bool = false
    var smallThumbsImage: UIImage? = nil
    var bigThumbsImage: UIImage? = nil
    let categoryName: String
    
    init(listingElement: ListingElement, categoriesList: [CategorieElement]) {
        self.id = listingElement.id
        self.categoryId = listingElement.category_id
        self.price = listingElement.price
        self.title = listingElement.title
        self.description = listingElement.description
        self.imagesUrl = listingElement.images_url
        self.isUrgent = listingElement.is_urgent
        self.creationDateString = DateFormatterString.formatDateStringToDayMonthYearHourMin(dateString: listingElement.creation_date) 
        self.siret = listingElement.siret
        self.isSmallThumbsAlreadyCached = false
        let linkedCategory = categoriesList.first(where: {$0.id == listingElement.category_id})
        self.categoryName = (linkedCategory != nil) ? linkedCategory!.name : "Default Category"
    }
}
    
    

