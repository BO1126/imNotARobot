//
//  ViewController.swift
//  imNotARobot
//
//  Created by 이정우 on 2023/03/16.
//

import UIKit
import Lottie

class ViewController: UIViewController, ReusableViewDelegate, Stage1ViewDelegate, LetterMatchStageViewDelegate {
    
    var mainAuthView = MainAuthView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addMainAuthView()
    }
    
    func addMainAuthView(){
        mainAuthView = MainAuthView()
        self.view.addSubview(mainAuthView)
        mainAuthView.translatesAutoresizingMaskIntoConstraints = false
        mainAuthView.widthAnchor.constraint(equalToConstant: 320).isActive = true
        mainAuthView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        mainAuthView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 317).isActive = true
        mainAuthView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        mainAuthView.delegate = self
        
    }
    
    
    
    func touchUpInsideCheckbox() {
        let stageLevel = UserDefaults.standard.integer(forKey: "stageLevel")
        print(stageLevel)
        switch(stageLevel){
        case 0:
            setTutorial()
            break
        case 1:
            setStage1()
            break
        case 2:
            setStage2()
            break
        case 3:
            setStage3()
            break
        case 4:
            setStage4()
            break
        default:
            setTutorial()
            break
        }
    }
    
    func stageClear() {
        self.mainAuthView.stageClear()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4) {
            self.addMainAuthView()
        }
    }
    
    func setTutorial(){
        self.mainAuthView.stageClear()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4) {
            self.addMainAuthView()
        }
    }
    
    func setStage1(){
        let stageView = Stage1View()
        stageView.delegate = self
        self.view.addSubview(stageView)
        stageView.translatesAutoresizingMaskIntoConstraints = false
        
        stageView.widthAnchor.constraint(equalToConstant: 320).isActive = true
        stageView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        stageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 220).isActive = true
        stageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        
        UIView.animate(withDuration: 0.7, animations: {
            self.mainAuthView.transform = CGAffineTransform(translationX: 0, y: -280)
        })
        stageView.alpha = 0
        UIView.animate(withDuration: 2, animations: {
            stageView.alpha = 1
        })
    }
    
    func setStage2(){
        let stageView = Stage1View()
        stageView.delegate = self
        self.view.addSubview(stageView)
        stageView.translatesAutoresizingMaskIntoConstraints = false
        
        stageView.widthAnchor.constraint(equalToConstant: 320).isActive = true
        stageView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        stageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 220).isActive = true
        stageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        
        UIView.animate(withDuration: 0.7, animations: {
            self.mainAuthView.transform = CGAffineTransform(translationX: 0, y: -280)
        })
        stageView.alpha = 0
        UIView.animate(withDuration: 2, animations: {
            stageView.alpha = 1
        })
    }
    
    func setStage3(){
        let stageView = LetterMatchStageView()
        stageView.delegate = self
        self.view.addSubview(stageView)
        stageView.translatesAutoresizingMaskIntoConstraints = false
        
        stageView.widthAnchor.constraint(equalToConstant: 320).isActive = true
        stageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        stageView.topAnchor.constraint(equalTo: mainAuthView.bottomAnchor, constant: -130).isActive = true
        stageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        
        UIView.animate(withDuration: 0.7, animations: {
            self.mainAuthView.transform = CGAffineTransform(translationX: 0, y: -180)
        })
        stageView.alpha = 0
        UIView.animate(withDuration: 2, animations: {
            stageView.alpha = 1
        })
        
    }
    
    func setStage4(){
        let stageView = Stage4View()
        self.view.addSubview(stageView)
        stageView.translatesAutoresizingMaskIntoConstraints = false
        
        stageView.widthAnchor.constraint(equalToConstant: 320).isActive = true
        stageView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        stageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 220).isActive = true
        stageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        
        UIView.animate(withDuration: 0.7, animations: {
            self.mainAuthView.transform = CGAffineTransform(translationX: 0, y: -280)
        })
        stageView.alpha = 0
        UIView.animate(withDuration: 2, animations: {
            stageView.alpha = 1
        })
    }

}
