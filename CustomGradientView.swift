//
//  CustomGradientView.swift
//  BottomDrawer
//
//  Created by Abhay Shankar on 02/11/18.
//  Copyright © 2018 Self. All rights reserved.
//

import UIKit


@IBDesignable class CustomGradientView: UIView {

    // MARK: - Private Variables
    
    private var gradient : CAGradientLayer?
    
    // MARK: - Inspectable Variables
    
    @IBInspectable var startColor : UIColor?
    @IBInspectable var endColor : UIColor?
    
    /// the gradient angle, in degrees anticlock wise from 0 (east/right)
    @IBInspectable var angle: CGFloat = 270
    
    //MARK: - Overrides
    
    override var frame: CGRect{
        didSet{
            updateGradeint()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateGradeint()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        installGradient()
        updateGradeint()
    }
    
      // MARK: - Initialisers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        installGradient()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        installGradient()
//        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods
    
    private func updateGradeint(){
        if let gradient = self.gradient{
            let startColor = self.startColor ?? UIColor.clear
            let endColor = self.endColor ?? UIColor.clear
            
            gradient.colors = [startColor.cgColor, endColor.cgColor]
            let (start, end) = gradientPointsForAngle(self.angle)
            gradient.startPoint = start
            gradient.endPoint = end
            gradient.frame = self.bounds
        }
    }
    private func createGradientLayer()-> CAGradientLayer{
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        return gradientLayer
    }
    
    private func installGradient(){
        if let gradient = self.gradient{
            gradient.removeFromSuperlayer()
        }
        let gradient = createGradientLayer()
        self.layer.addSublayer(gradient)
        self.gradient = gradient
    }

    private func pointForAngle(_ angle: CGFloat) -> CGPoint{
        let radians = angle * .pi / 180.0
        var x = cos(radians)
        var y = sin(radians)
        
        if abs(x) > abs(y){
            x = x > 0 ? 1 : -1
            y = x * tan(radians)
        }else{
            y = y > 0 ? 1 : -1
            x = y / tan(radians)
        }
        return CGPoint.init(x: x, y: y)
    }
    
    private func gradientPointsForAngle(_ angle :CGFloat) -> (CGPoint, CGPoint){
        let end = pointForAngle(angle)
        let start = oppositePoint(end)
        
        let p0 = transformToGradientSpace(start)
        let p1 = transformToGradientSpace(end)
        return (p0,p1)
    }
    
    private func oppositePoint(_ point: CGPoint) -> CGPoint{
        return CGPoint.init(x: -point.x, y: -point.y)
    }
    
    private func transformToGradientSpace(_ point : CGPoint) -> CGPoint{
        return CGPoint.init(x: (point.x + 1) * 0.5, y: 1.0 - (point.y + 1) * 0.5)
    }
}
