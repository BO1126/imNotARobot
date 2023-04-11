//
//  Stage1View.swift
//  imNotARobot
//
//  Created by 이정우 on 2023/03/17.
//

import UIKit

protocol Stage1ViewDelegate {
    func stageClear()
}

class Stage1View: UIView{
    
    @IBOutlet weak var selectView1 : SelectView!
    @IBOutlet weak var selectView2 : SelectView!
    @IBOutlet weak var selectView3 : SelectView!
    @IBOutlet weak var selectView4 : SelectView!
    @IBOutlet weak var selectView5 : SelectView!
    @IBOutlet weak var selectView6 : SelectView!
    @IBOutlet weak var selectView7 : SelectView!
    @IBOutlet weak var selectView8 : SelectView!
    @IBOutlet weak var selectView9 : SelectView!
    @IBOutlet weak var subtitleLabel : UILabel!
    @IBOutlet weak var matchImageView : UIImageView!
    @IBOutlet weak var verifyButton : UIButton!
    
    let nibName = "Stage1View"
    var delegate: Stage1ViewDelegate?
    var stageLevel = 1
    var preventButtonTouch = false
    
    override func draw(_ rect: CGRect) {
        self.frame = CGRect(x: 0, y: 0, width: 300, height: 500)
        self.layer.borderWidth = 2
        self.layer.borderColor = CGColor(red: 195/255, green: 195/255, blue: 195/255, alpha: 1)
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        
        subtitleLabel.text = "Select all images below \nthat match this one:"
        
        verifyButton.clipsToBounds = true
        verifyButton.layer.cornerRadius = 2
        
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
        setSelectView()
    }
    
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func setSelectView(){
        let viewArr : [SelectView] = [selectView1,selectView2,selectView3,selectView4,selectView5,selectView6,selectView7,selectView8,selectView9]
        var imageArr : [String] = []
        stageLevel = UserDefaults.standard.integer(forKey: "stageLevel")
        switch(stageLevel){
        case 1:
            imageArr = ["chicken1","chicken2","chicken3","chicken4","chicken5","chicken6","chicken7","chicken8","chicken9"]
            matchImageView.image = UIImage(named: "dogMatchImage")
            break
        case 2:
            imageArr = ["muffin1","muffin2","muffin3","muffin4","muffin5","muffin6","muffin7","muffin8","muffin9"]
            matchImageView.image = UIImage(named: "dogMatchImage")
            break
        default: break
        }
        
        for i in 0...8{
            setSelectViewInfo(selectview: viewArr[i], imageName: imageArr[i])
        }
        
    }
    
    func setSelectViewInfo(selectview : UIView, imageName : String){
        selectview.layer.borderWidth = 3
        selectview.layer.borderColor = CGColor(red: 195/255, green: 195/255, blue: 195/255, alpha: 1)
        selectview.clipsToBounds = true
        selectview.layer.cornerRadius = 2
        let imageview = UIImageView()
        imageview.frame = CGRect(x: 0, y: 0, width: selectview.frame.width, height: selectview.frame.height)
        imageview.image = UIImage(named: imageName)
        imageview.contentMode = .scaleToFill
        selectview.addSubview(imageview)
    }
    
    @IBAction func touchUpInsideVerifyButton(){
        if preventButtonTouch {
            return
        }
        var result = false
        switch(stageLevel){
        case 1:
            result = (selectView2.selectState && selectView4.selectState && selectView6.selectState && selectView9.selectState && !(selectView1.selectState || selectView3.selectState || selectView5.selectState || selectView7.selectState || selectView8.selectState))
            break
        case 2:
            result = (selectView3.selectState && selectView8.selectState && selectView9.selectState && !(selectView1.selectState || selectView2.selectState || selectView4.selectState || selectView5.selectState || selectView6.selectState || selectView7.selectState))
            break
        default: break
        }
    
        if result{
            preventButtonTouch = true
            stageClear()
        }else{
            failAnimation()
        }
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
    
    func failAnimation(){
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-10.0, 10.0, -10.0, 10.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        self.layer.add(animation, forKey: "shake")
    }

}

class SelectView : UIView{
    var selectState = false
    override func draw(_ rect: CGRect) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectThisView(sender:)))
        self.addGestureRecognizer(tapGesture)
    }
    @objc func selectThisView(sender: UITapGestureRecognizer) {
        if selectState == false{
            UIView.animate(withDuration: 0.3, animations: {
                self.layer.borderColor = UIColor.systemBlue.cgColor
            })
            selectState = !selectState
        }else{
            UIView.animate(withDuration: 0.3, animations: {
                self.layer.borderColor = CGColor(red: 195/255, green: 195/255, blue: 195/255, alpha: 1)
            })
            selectState = !selectState
        }
        
    }
}
