//
//  ViewController.swift
//  LoopProgressDemo
//
//  Created by Mazy on 2017/5/22.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var loopView: LoopView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置环形视图并添加到主视图
        let loopView = LoopView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        loopView.center = view.center
        loopView.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        view.addSubview(loopView)
        self.loopView = loopView
        
        // 设置滑块
        let slider = UISlider(frame: CGRect(x: 20, y: loopView.frame.origin.y + 300 + 50, width: view.bounds.width-40, height: 30))
        slider.addTarget(self, action: #selector(changeMaskValue), for: .valueChanged)
        slider.value = 0.5
        view.addSubview(slider)
    }

    
    /// 通过滑块控制环形视图的角度
    func changeMaskValue(slider: UISlider) {
        
        self.loopView?.animationWithStrokeEnd(strokeEnd: CGFloat(slider.value))
    }
   
}

