//
//  LetterMatchStageView.swift
//  imNotARobot
//
//  Created by 이정우 on 2023/03/24.
//

import UIKit

protocol LetterMatchStageViewDelegate {
    func stageClear()
}

class LetterMatchStageView: UIView {
    
    @IBOutlet weak var answerTextField : UITextField!
    @IBOutlet weak var matchView : CapchaView!
    @IBOutlet weak var verifyButton : UIButton!
    
    let nibName = "LetterMatchStageView"
    var delegate: LetterMatchStageViewDelegate?
    var preventButtonTouch = false
    var matchVal = "";
    

    override func draw(_ rect: CGRect) {
        self.layer.borderWidth = 2
        self.layer.borderColor = CGColor(red: 195/255, green: 195/255, blue: 195/255, alpha: 1)
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
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
        setLetterMatchView()
    }
    
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func setLetterMatchView(){
        matchVal = implementCapcha(capchaView: matchView)
    }
    
    @IBAction func touchUpInsideVerifyButton(){
        if preventButtonTouch {
            return
        }
        let result = (matchVal == answerTextField.text)
        if result{
            preventButtonTouch = true
            stageClear()
        }else{
            failAnimation()
        }
    }
    
    func failAnimation(){
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-10.0, 10.0, -10.0, 10.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        self.layer.add(animation, forKey: "shake")
    }
    
    func implementCapcha(capchaView : CapchaView) -> String{
        let capchaLabel = UILabel(frame: CGRect(x: 0, y: 0, width: capchaView.frame.width, height: capchaView.frame.height))
        
        let randomSize = Int.random(in: 5...8)
        let stringList = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString = String((0 ..< randomSize).map{ _ in stringList.randomElement()! })
        
        capchaLabel.text = randomString
        capchaLabel.font = UIFont.systemFont(ofSize: 45)
        capchaLabel.textColor = .black
        capchaLabel.textAlignment = .center
        
        capchaView.addSubview(capchaLabel)
        
        return randomString
    }
    
    func stageClear(){
        if let del = delegate {
            del.stageClear()
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            UIView.animate(withDuration: 1, animations: {
                self.alpha = 0
            })
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.removeFromSuperview()
            }
        }
    }

}

class CapchaView : UIView{
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath()
        path.lineWidth = 5
        path.move(to: CGPoint(x: 10, y: CGFloat.random(in: 20...self.frame.height-20)))
        path.addLine(to: CGPoint(x: self.frame.maxX-10, y: CGFloat.random(in: 20...self.frame.height-20)))
        path.close()
        path.stroke()
    }
}


