//
//  DashboardServiceCollectionViewCell.swift
//  Peko
//
//  Created by Hardik Makwana on 01/04/24.
//

import UIKit

class DashboardServiceCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgContainerView: UIView!
    @IBOutlet weak var logoImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var titleHeightConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
