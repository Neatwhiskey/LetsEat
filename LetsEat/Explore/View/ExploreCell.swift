//
//  ExploreCell.swift
//  LetsEat
//
//  Created by Jamaaldeen Opasina on 02/02/2024.
//

import UIKit

class ExploreCell: UICollectionViewCell {
    
    @IBOutlet var exploreNameLabel: UILabel!
    @IBOutlet var exploreImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        exploreImageView.layer.cornerRadius = 9
        exploreImageView.layer.masksToBounds = true
    }
    
}
