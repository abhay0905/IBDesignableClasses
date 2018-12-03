//
//  DesignableUIImageView.swift
//  BottomDrawer
//
//  Created by Abhay Shankar on 03/12/18.
//  Copyright © 2018 Self. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class DesignableImageView:  UIImageView {
    override func prepareForInterfaceBuilder() {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = cornerRadius > 0
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor?.cgColor
    }
    
    override func awakeFromNib() {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = cornerRadius > 0
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor?.cgColor
    }
    @IBInspectable
    public var cornerRadius: CGFloat
    {
        set (radius) {
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = radius > 0
        }
        
        get {
            return self.layer.cornerRadius
        }
    }
    
    @IBInspectable
    public var borderWidth: CGFloat
    {
        set (borderWidth) {
            self.layer.borderWidth = borderWidth
        }
        
        get {
            return self.layer.borderWidth
        }
    }
    
    @IBInspectable
    public var borderColor:UIColor?
    {
        set (color) {
            self.layer.borderColor = color?.cgColor
        }
        
        get {
            if let color = self.layer.borderColor
            {
                return UIColor(cgColor: color)
            } else {
                return nil
            }
        }
    }
}

