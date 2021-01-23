//
//  NeumorphicView.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 23/01/2021.
//

import UIKit

protocol NeumorphicDesignable: class {
    var layer: CALayer { get }
    var clipsToBounds: Bool { get set }
    var frame: CGRect { get set }
    var bounds: CGRect { get set }
    var backgroundColor: UIColor? { get set }
    
    var pressed: Bool { get set }
    var darkShadow: CALayer { get }
    var lightShadow: CALayer { get }
    
    func setupContentView()
    func updateLayers(pressed: Bool)
}

extension NeumorphicDesignable {
    func setupContentView() {
        self.backgroundColor = .appBackground
        self.clipsToBounds = false
        self.layer.cornerRadius = 15
        self.layer.cornerRadius = 15
    }
    
    func updateLayers(pressed: Bool = false) {
        if pressed {
            layer.borderWidth = 2
            layer.borderColor = UIColor.neumorphicPrimaryShadow.cgColor
        } else {
            layer.borderWidth = 0
            layer.borderColor = UIColor.clear.cgColor
        }
        
        self.pressed = pressed
        
        if darkShadow.superlayer != nil {
            darkShadow.removeFromSuperlayer()
        }
        if lightShadow.superlayer != nil {
            lightShadow.removeFromSuperlayer()
        }
        
        darkShadow.frame = self.bounds
        darkShadow.cornerRadius = 15
        darkShadow.backgroundColor = UIColor.appBackground.cgColor
        darkShadow.shadowColor = UIColor.neumorphicPrimaryShadow.cgColor
        darkShadow.shadowOffset = CGSize(width: 18, height: 18)
        darkShadow.shadowOpacity = 1
        darkShadow.shadowRadius = 15
        darkShadow.masksToBounds = false
        
        if pressed {
            let path = UIBezierPath(rect: darkShadow.bounds.insetBy(dx: -10, dy: -10))
            let cutout = UIBezierPath(roundedRect: darkShadow.bounds, cornerRadius: 15).reversing()
            path.append(cutout)
            darkShadow.shadowPath = path.cgPath
        } else {
            darkShadow.shadowPath = nil
        }
        
        self.layer.insertSublayer(darkShadow, at: 0)
        
        lightShadow.frame = self.bounds
        lightShadow.cornerRadius = 15
        lightShadow.backgroundColor = UIColor.appBackground.cgColor
        lightShadow.shadowColor = UIColor.neumorphicSecondaryShadow.cgColor
        lightShadow.shadowOffset = CGSize(width: -18, height: -18)
        lightShadow.shadowOpacity = 1
        lightShadow.shadowRadius = 15
        lightShadow.masksToBounds = false
        
        if pressed {
            let path = UIBezierPath(rect: lightShadow.bounds.insetBy(dx: -10, dy: -10))
            let cutout = UIBezierPath(roundedRect: lightShadow.bounds, cornerRadius: 15).reversing()
            path.append(cutout)
            lightShadow.shadowPath = path.cgPath
        } else {
            lightShadow.shadowPath = nil
        }
        
        self.layer.insertSublayer(lightShadow, at: 0)
    }
}

public final class NeumorphicView: UIView, NeumorphicDesignable {
    var pressed: Bool = false
    let darkShadow = CALayer()
    let lightShadow = CALayer()
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        updateLayers(pressed: pressed)
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if (traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)) {
            setupContentView()
            updateLayers(pressed: pressed)
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        setupContentView()
    }
}
