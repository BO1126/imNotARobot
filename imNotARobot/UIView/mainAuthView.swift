//
//  mainAuthView.swift
//  imNotARobot
//
//  Created by 이정우 on 2023/03/16.
//

import UIKit
class mainAuthView: UIView {
    @IBOutlet weak var checkboxButton : UIButton!

    override func draw(_ rect: CGRect) {
        self.layer.borderWidth = 2
        self.layer.borderColor = CGColor(red: 195/255, green: 195/255, blue: 195/255, alpha: 1)
        
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        
        checkboxButton.layer.borderWidth = 3
        checkboxButton.layer.borderColor = CGColor(red: 195/255, green: 195/255, blue: 195/255, alpha: 1)
        checkboxButton.clipsToBounds = true
        checkboxButton.layer.cornerRadius = 3
    }

}
