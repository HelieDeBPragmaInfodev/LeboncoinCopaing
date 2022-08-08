//
//  CategorieElement.swift
//  LeBonCoingCopaing
//
//  Created by Hélie de Bernis on 03/08/2022.
//

import Foundation

// MARK: - ListingElement
struct ListingElement: Decodable {
    let id, category_id: Int
    let title, description: String
    let price: Double
    let images_url: ImagesURL
    let creation_date: String
    let is_urgent: Bool
    let siret: String?
}

// MARK: - ImagesURL
struct ImagesURL: Decodable {
    let small, thumb: String?
}
