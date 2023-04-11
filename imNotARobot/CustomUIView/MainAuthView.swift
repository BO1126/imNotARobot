//
//  MainAuthView.swift
//  imNotARobot
//
//  Created by 이정우 on 2023/03/17.
//

import UIKit
import Lottie

protocol ReusableViewDelegate {
    func touchUpInsideCheckbox()
}


class MainAuthView: UIView, ReusableViewDelegate {
    
    @IBOutlet weak var checkboxButton : UIButton!
    
    let nibName = "MainAuthView"
    var delegate: ReusableViewDelegate?
    var loadingAnimationView : AnimationView = AnimationView()
    
    override func draw(_ rect: CGRect) {
        self.alpha = 0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            UIView.animate(withDuration: 0.5, animations: {
                self.alpha = 1
            })
        }
        self.backgroundColor = UIColor(named: "BackgroundGrayColor")
        self.layer.borderWidth = 2
        self.layer.borderColor = CGColor(red: 195/255, green: 195/255, blue: 195/255, alpha: 1)
        
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        
        checkboxButton.layer.borderWidth = 3
        checkboxButton.layer.borderColor = CGColor(red: 195/255, green: 195/255, blue: 195/255, alpha: 1)
        checkboxButton.clipsToBounds = true
        checkboxButton.layer.cornerRadius = 3
    }
    
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
    
    func stageClear(){
        let stageLevel = UserDefaults.standard.integer(forKey: "stageLevel")
        UserDefaults.standard.set(stageLevel+1, forKey: "stageLevel")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            self.loadingAnimationView.removeFromSuperview()
            let animationView : AnimationView = .init(name: "checkmarkLottie")
            animationView.frame = self.checkboxButton.frame
            self.addSubview(animationView)
            
            animationView.play()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
                UIView.animate(withDuration: 1, animations: {
                    self.alpha = 0
                })
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.removeFromSuperview()
                }
            }
        }
    }

    
    @IBAction func touchUpInsideCheckbox(){
        loadingAnimationView = .init(name: "authLoadingLottie")
        self.addSubview(loadingAnimationView)
        loadingAnimationView.frame = checkboxButton.frame
        loadingAnimationView.play()
        loadingAnimationView.loopMode = .loop
        checkboxButton.layer.borderWidth = 0
        checkboxButton.backgroundColor = .clear
        
        if let del = delegate {
            del.touchUpInsideCheckbox()
        }
    }

}
