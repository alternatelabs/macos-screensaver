//
//  RotatingImage.swift
//  AltLabsScreenSaver
//
//  Created by Pete Hawkins on 03/03/2018.
//  Copyright © 2018 Alternate Labs. All rights reserved.
//

import AppKit

class RotatingImage: NSView {
    
    var imageSequance: [NSImage]
    var myLayer = CALayer()
    
    convenience init(imageSequance: [NSImage]) {
        self.init(frame: NSRect.zero, imageSequance: imageSequance)
    }
    
    required init?(coder decoder: NSCoder) {
        self.imageSequance = []
        super.init(coder: decoder)
        initialize()
    }
    
    init(frame frameRect: NSRect, imageSequance: [NSImage]) {
        self.imageSequance = imageSequance
        super.init(frame: frameRect)
        initialize()
    }
    
    override func layout() {
        super.layout()
        
        var layerFrame = CGRect(origin: CGPoint.zero, size: self.frame.size)
        self.myLayer.frame = layerFrame
        // self.myLayer.bounds = layerFrame
    }
    
    func initialize() {
        // This needs to happen around init.
        // NSView (and who inherit from it) does not come with a layer.
        // self.layer will be nil at init.
        self.layer = CALayer()
        self.wantsLayer = true
//        self.layer?.backgroundColor = NSColor.systemGreen.cgColor
        
        let keyPath = "contents" // (I did not find a constant for that key.)
        let frameAnimation = CAKeyframeAnimation(keyPath: keyPath)
        frameAnimation.calculationMode = kCAAnimationLinear
        
        // Duration
        // This is the duration of one cycle
        let durationOfAnimation: CFTimeInterval = 50
        frameAnimation.duration = durationOfAnimation
        frameAnimation.repeatCount = HUGE// can also use Float.infinity

        frameAnimation.values = imageSequance
        
        myLayer.add(frameAnimation, forKey: keyPath)
        
        self.layer?.addSublayer(myLayer)
        self.needsLayout = true
    }
}
