//
//  SelectView.swift
//  imNotARobot
//
//  Created by 이정우 on 2023/03/22.
//

import UIKit

class SelectView: UIView {

    override func draw(_ rect: CGRect) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectThisView(sender:)))
        self.addGestureRecognizer(tapGesture)
    }

    @objc func selectThisView(sender: UITapGestureRecognizer) {
        
    }
}
