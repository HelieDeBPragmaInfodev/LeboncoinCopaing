//
//  URLService.swift
//  LeBonCoingCopaing
//
//  Created by Hélie de Bernis on 03/08/2022.
//

import Foundation

class UrlServiceKeys {
    
    #if DEBUG
    static let categoriesAPIUrlString = "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json"
    static let listingAPIUrlString = "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json"
    static let swaggerAPIUrlString = " https://raw.githubusercontent.com/leboncoin/paperclip/master/swagger.yaml"
    #else
    static let categoriesAPIUrlString = "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json"
    static let listingAPIUrlString = "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json"
    static let swaggerAPIUrlString = " https://raw.githubusercontent.com/leboncoin/paperclip/master/swagger.yaml"
    #endif
}
