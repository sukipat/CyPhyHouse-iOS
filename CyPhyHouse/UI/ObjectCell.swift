//
//  ObjectCell.swift
//  CyPhyHouse
//
//  Created by Suki on 2/26/20.
//  Copyright © 2020 CSL. All rights reserved.
//

import Foundation
import UIKit

class ObjectCell: UITableViewCell {
    // MARK: - Properties
    let objectImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIImageView.ContentMode.scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        return imageView
    }()

    let objectLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        return label
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(objectLabel)
        objectLabel.heightAnchor.constraint(equalToConstant: 32.0).isActive = true
        objectLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        objectLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        contentView.addSubview(objectImage)
        objectImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        objectImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        objectImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        objectImage.bottomAnchor.constraint(equalTo: objectLabel.topAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
