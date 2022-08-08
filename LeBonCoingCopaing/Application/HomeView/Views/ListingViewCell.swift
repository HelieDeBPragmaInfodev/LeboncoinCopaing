//
//  ListingViewCell.swift
//  LeBonCoingCopaing
//
//  Created by Hélie de Bernis on 08/08/2022.
//

import Foundation
import UIKit

class ListingViewCell: UITableViewCell {
    
    let smallThumbImageView = UIImageView()
    let urgentImageView = UIImageView()
    let titleLabel = UILabel()
    let priceLabel = UILabel()
    let categorieLabel = UILabel()
    let creationDateLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.setUpUserInterface()
    }
    
    
    fileprivate func setUpUserInterface () {
        

        smallThumbImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        categorieLabel.translatesAutoresizingMaskIntoConstraints = false
        creationDateLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        urgentImageView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(smallThumbImageView)
        contentView.addSubview(urgentImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(categorieLabel)
        contentView.addSubview(creationDateLabel)
        
        
        smallThumbImageView.heightAnchor.constraint(equalToConstant: 150.0).isActive = true
        smallThumbImageView.widthAnchor.constraint(equalToConstant: 150.0).isActive = true
        smallThumbImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        smallThumbImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        smallThumbImageView.contentMode = .scaleAspectFit
        smallThumbImageView.layer.cornerRadius = Dimension.listingCellCornerRadius
        smallThumbImageView.layer.masksToBounds = true
        
        urgentImageView.heightAnchor.constraint(equalToConstant: Dimension.listingCellThumbsUrgentHeight).isActive = true
        urgentImageView.widthAnchor.constraint(equalToConstant: Dimension.listingCellThumbsUrgentWidth).isActive = true
        urgentImageView.topAnchor.constraint(equalTo: self.smallThumbImageView.topAnchor, constant: 5).isActive = true
        urgentImageView.leadingAnchor.constraint(equalTo: self.smallThumbImageView.leadingAnchor, constant: 5).isActive = true
        
        urgentImageView.contentMode = .scaleAspectFit
        urgentImageView.layer.cornerRadius = Dimension.listingCellThumbsUrgentCornerRadius
        urgentImageView.image = UIImage(systemName: "clock")?.withRenderingMode(.alwaysTemplate)
        urgentImageView.tintColor = .orange
        urgentImageView.layer.masksToBounds = true
        
        titleLabel.topAnchor.constraint(equalTo: smallThumbImageView.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: smallThumbImageView.trailingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        priceLabel.numberOfLines = 1
        priceLabel.font = UIFont.boldSystemFont(ofSize: 12)
        priceLabel.textColor = .green
        
        
        
        categorieLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor).isActive = true
        categorieLabel.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor).isActive = true
        categorieLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        categorieLabel.numberOfLines = 1
        categorieLabel.font = UIFont.systemFont(ofSize: 12)
        categorieLabel.textColor = .lightGray
        
        creationDateLabel.topAnchor.constraint(equalTo: categorieLabel.bottomAnchor).isActive = true
        creationDateLabel.leadingAnchor.constraint(equalTo: categorieLabel.leadingAnchor).isActive = true
        creationDateLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        creationDateLabel.numberOfLines = 1
        creationDateLabel.font = UIFont.systemFont(ofSize: 12)
        creationDateLabel.textColor = .lightGray
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
