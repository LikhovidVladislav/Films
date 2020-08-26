//
//  FilmsListTableViewCell.swift
//  FIlmsTest
//
//  Created by Влад Лиховид on 17.06.2020.
//  Copyright © 2020 Влад Лиховид. All rights reserved.
//

import UIKit
import Kingfisher

class FilmsListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var desriptionLabel: UILabel!
    
    var imageUrlPath: String? {
        didSet {
            guard let imageUrlPath = imageUrlPath else { return }
            
            posterImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500" + imageUrlPath))
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
        
    }

}
