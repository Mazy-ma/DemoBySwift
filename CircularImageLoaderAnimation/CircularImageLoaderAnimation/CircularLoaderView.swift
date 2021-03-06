//
//  CircularLoaderView.swift
//  CircularImageLoaderAnimation
//
//  Created by Mazy on 2017/6/28.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class CircularLoaderView: UIView {

    // 画圆环
    let circlePathLayer = CAShapeLayer()
    // 圆环半径
    let circleRadius: CGFloat = 20.0
    // 进度
    var progress: CGFloat {
        get {
            return circlePathLayer.strokeEnd
        }
        set {
            if (newValue > 1) {
                circlePathLayer.strokeEnd = 1
            } else if (newValue < 0) {
                circlePathLayer.strokeEnd = 0
            } else {
                circlePathLayer.strokeEnd = newValue
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circlePathLayer.frame = bounds
        circlePathLayer.path = circlePath().cgPath
    }
    
    
    func configure() {
        
        progress = 0
        
        circlePathLayer.frame = bounds
        circlePathLayer.lineWidth = 2.0
        circlePathLayer.fillColor = UIColor.clear.cgColor
        circlePathLayer.strokeColor = UIColor.red.cgColor
        layer.addSublayer(circlePathLayer)
        backgroundColor = UIColor.white
        
    }
    
    func circleFrame() -> CGRect {
        var circleFrame = CGRect(x: 0, y: 0, width: 2*circleRadius, height: 2*circleRadius)
        circleFrame.origin.x = circlePathLayer.bounds.midX - circleFrame.midX
        circleFrame.origin.y = circlePathLayer.bounds.midY - circleFrame.midY
        return circleFrame
    }
    
    func circlePath() -> UIBezierPath {
        return UIBezierPath(ovalIn: circleFrame())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reveal() {
        // 1
        backgroundColor = UIColor.clear
//        progress = 1
        // 2
//        circlePathLayer.removeAnimation(forKey: "strokeEnd")
        circlePathLayer.removeAllAnimations()
        // 3
        circlePathLayer.removeFromSuperlayer()
        
        superview?.layer.mask = circlePathLayer
        
        // 2-1
        let center = CGPoint(x: bounds.midX, y: bounds.minY)
        let finalRadius = sqrt(center.x * center.x + center.y * center.y)
        let radiusInset = finalRadius - circleRadius
        let outerRect = circleFrame().insetBy(dx: -radiusInset, dy: -radiusInset)
        let toPath = UIBezierPath(ovalIn: outerRect).cgPath
        
        // 2-2
        let fromPath = circlePathLayer.path
        let fromLineWidth = circlePathLayer.lineWidth
        
        // 2-3
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanFalse, forKey: kCATransactionDisableActions)
        circlePathLayer.lineWidth = 2*finalRadius
        circlePathLayer.path = toPath
        CATransaction.commit()
        
        // 2-4
        let lineWidthAnimation = CABasicAnimation(keyPath: "lineWidth")
        lineWidthAnimation.fromValue = fromLineWidth
        lineWidthAnimation.toValue = 2*finalRadius
        
        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.fromValue = fromPath
        pathAnimation.toValue = toPath
        
        // 2-5
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = 0.25
        groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        groupAnimation.animations = [pathAnimation, lineWidthAnimation]
        groupAnimation.delegate = self
        circlePathLayer.add(groupAnimation, forKey: "strokeWidth")
        
        
    }
    
}

extension CircularLoaderView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
      
        circlePathLayer.removeFromSuperlayer()
        
        superview?.layer.mask = nil
        
    }
}
