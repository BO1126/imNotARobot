//
//  Stage1SelectView.swift
//  imNotARobot
//
//  Created by 이정우 on 2023/03/21.
//

import UIKit

class Stage1SelectView: UIView {
    
    let nibName = "Stage1SelectView"
    @IBOutlet weak var imageView : UIImageView!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)

    }
    
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

}
