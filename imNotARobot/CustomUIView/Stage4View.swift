//
//  Stage4View.swift
//  imNotARobot
//
//  Created by 이정우 on 2023/03/23.
//

import UIKit

class Stage4View: UIView {
    
    let nibName = "Stage4View"
    let playerView = PlayerView()
    var timerVal : Double = 20
    var timer = Timer()
    var timer2 = Timer()
    var bulletArr : [BulletView] = []
    let enemyView = UIView()
    var panGesture = UIPanGestureRecognizer()
    
    @IBOutlet weak var timerLabel : UILabel!

    override func draw(_ rect: CGRect) {
        self.frame = CGRect(x: 0, y: 0, width: 320, height: 500)
        self.layer.borderWidth = 2
        self.layer.borderColor = CGColor(red: 195/255, green: 195/255, blue: 195/255, alpha: 1)
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        
        self.addSubview(playerView)
        playerView.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        playerView.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY+200)
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.drag))
        self.addGestureRecognizer(panGesture)
        
        timerLabel.text = "\(timerVal)"
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(secTimer), userInfo: nil, repeats: true)
        timer2 = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(oneSecTimer), userInfo: nil, repeats: true)
        
        enemyView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        enemyView.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        enemyView.layer.backgroundColor = UIColor.systemRed.cgColor
        enemyView.clipsToBounds = true
        enemyView.layer.cornerRadius = 20
        self.addSubview(enemyView)
        
        
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
    
    @objc func drag(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)
        let currentX = playerView.center.x + translation.x
        let currentY = playerView.center.y + translation.y
        if( 0 < (currentX-7.5) && self.bounds.maxX > (currentX+7.5) && 0 < (currentY-7.5) && self.bounds.maxY > (currentY+7.5)){
            playerView.center = CGPoint(x: currentX, y: currentY)
        }
        sender.setTranslation(.zero, in: self)
    }
    
    @objc func secTimer(){
        if timerVal <= 0.01{
            timer.invalidate()
            timer2.invalidate()
            print("Clear!")
        }else{
            timerVal -= 0.01
        }
        timerLabel.text = String(format: "%.1f", timerVal)
        
        let val : CGFloat = 0.1
        
        for i in bulletArr{
            if enemyView.center.y <= i.locY && enemyView.center.x > i.locX{
                i.locY -= val
                i.locX -= val
            }else if enemyView.center.y > i.locY && enemyView.center.x >= i.locX{
                i.locY -= val
                i.locX += val
            }else if enemyView.center.y >= i.locY && enemyView.center.x < i.locX{
                i.locY += val
                i.locX += val
            }else if enemyView.center.y < i.locY && enemyView.center.x <= i.locX{
                i.locY += val
                i.locX -= val
            }
            
            let radian = atan2(i.locY - enemyView.center.y, i.locX - enemyView.center.x)
            
            let speed : CGFloat = 2
            let xVal = i.center.x + cos(radian) * speed
            let yVal = i.center.y + sin(radian) * speed
            
            i.center = CGPoint(x: xVal, y: yVal)
            // View 벗어나면 탄막이 사라지는 조건문
//            if( 0 > i.center.x || self.bounds.maxX < i.center.x || 0 > i.center.y || self.bounds.maxY < i.center.y){
//                i.removeFromSuperview()
//            }
            
            // playView가 탄막에 맞으면 실행되는 조건문
            let playerViewLeft = playerView.center.x - 7.5
            let iLeft = i.center.x - 5
            let playerViewTop = playerView.center.y - 7.5
            let iTop = i.center.y - 5
            
            if(playerViewLeft >= iLeft &&
               playerViewLeft <= (iLeft + playerView.frame.width)) && (iTop >= playerViewTop && playerViewTop <= (iTop + i.frame.height)){
                let test = [playerView.center, i.center]
                self.failedStage(testArray: test)
            }
        }
    }
    
    @objc func oneSecTimer(){
        if timerVal < 18{
            for i in 0...2{
                let bulletView = BulletView()
                self.addSubview(bulletView)
                bulletView.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
                bulletView.center = CGPoint(x: enemyView.center.x, y: enemyView.center.y)
                bulletView.locX = enemyView.center.x - (5 * CGFloat(i))
                bulletView.locY = (enemyView.center.y+10) - (5 * CGFloat(i))
                bulletArr.append(bulletView)
            }
            for i in 1...2{
                let bulletView = BulletView()
                self.addSubview(bulletView)
                bulletView.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
                bulletView.center = CGPoint(x: enemyView.center.x, y: enemyView.center.y)
                bulletView.locX = enemyView.center.x + (5 * CGFloat(i))
                bulletView.locY = (enemyView.center.y+10) - (5 * CGFloat(i))
                bulletArr.append(bulletView)
            }
            for i in 0...2{
                let bulletView = BulletView()
                self.addSubview(bulletView)
                bulletView.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
                bulletView.center = CGPoint(x: enemyView.center.x, y: enemyView.center.y)
                bulletView.locX = enemyView.center.x - (5 * CGFloat(i))
                bulletView.locY = (enemyView.center.y-10) + (5 * CGFloat(i))
                bulletArr.append(bulletView)
            }
            for i in 1...2{
                let bulletView = BulletView()
                self.addSubview(bulletView)
                bulletView.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
                bulletView.center = CGPoint(x: enemyView.center.x, y: enemyView.center.y)
                bulletView.locX = enemyView.center.x + (5 * CGFloat(i))
                bulletView.locY = (enemyView.center.y-10) + (5 * CGFloat(i))
                bulletArr.append(bulletView)
            }
        }
    }
    
    func failedStage(testArray : [CGPoint]){
//        self.removeGestureRecognizer(panGesture)
        print(testArray)
        
    }

}

class PlayerView : UIView{
    override func draw(_ rect: CGRect) {
        self.clipsToBounds = true
        self.layer.cornerRadius = 7.5
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.systemBlue.cgColor
        
    }
}

class BulletView : UIView{
    var locX : CGFloat = 0
    var locY : CGFloat = 0
    override func draw(_ rect: CGRect) {
        self.layer.backgroundColor = UIColor.systemYellow.cgColor
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
    }
}
