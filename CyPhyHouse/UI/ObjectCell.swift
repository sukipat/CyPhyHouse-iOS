//
//  ObjectCell.swift
//  CyPhyHouse
//
//  Created by Suki on 3/2/20.
//  Copyright © 2020 CSL. All rights reserved.
//

import Foundation
import UIKit

class ObjectCell: UITableViewCell {
    let objectImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIImageView.ContentMode.scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.addSubview(objectImage)
        objectImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        objectImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        objectImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        objectImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
