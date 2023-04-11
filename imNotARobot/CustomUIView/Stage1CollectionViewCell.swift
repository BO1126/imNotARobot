//
//  Stage1CollectionViewCell.swift
//  imNotARobot
//
//  Created by 이정우 on 2023/03/20.
//

import UIKit

class Stage1CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView : UIImageView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
        
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    func setUpCell() {
           
    }
            
    func setUpImage() {
    }

}
