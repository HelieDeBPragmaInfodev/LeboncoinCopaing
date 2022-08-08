//
//  Dimension.swift
//  LeBonCoingCopaing
//
//  Created by Hélie de Bernis on 08/08/2022.
//

import Foundation
import UIKit

class Dimension {
    
    static let listingCellCornerRadius: Double = {
            switch UIDevice.current.userInterfaceIdiom {
            case .phone:
                return 10
            case .pad:
                return 10
            default:
                return 10
            }
    }()
    
    static let listingCellHeight: Double = {
            switch UIDevice.current.userInterfaceIdiom {
            case .phone:
                return 170
            case .pad:
                return 170
            default:
                return 170
            }
    }()
    
    static let listingCellWidth: Double = {
            switch UIDevice.current.userInterfaceIdiom {
            case .phone:
                return UIScreen.main.bounds.width
            case .pad:
                return UIScreen.main.bounds.width
            default:
                return UIScreen.main.bounds.width
            }
    }()
    
    static let listingCellThumbsHeight: Double = {
            switch UIDevice.current.userInterfaceIdiom {
            case .phone:
                return 200
            case .pad:
                return 200
            default:
                return 200
            }
    }()
    
    static let listingCellThumbsUrgentHeight: Double = {
            switch UIDevice.current.userInterfaceIdiom {
            case .phone:
                return 20
            case .pad:
                return 20
            default:
                return 20
            }
    }()
    
    static let listingCellThumbsUrgentWidth: Double = {
            switch UIDevice.current.userInterfaceIdiom {
            case .phone:
                return 20
            case .pad:
                return 20
            default:
                return 20
            }
    }()
    
    static let listingCellThumbsUrgentCornerRadius: Double = {
            switch UIDevice.current.userInterfaceIdiom {
            case .phone:
                return 5
            case .pad:
                return 5
            default:
                return 5
            }
    }()

    
    
}


