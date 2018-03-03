//
//  AltLabsView.swift
//  AltLabsScreenSaver
//
//  Created by Pete Hawkins on 02/03/2018.
//  Copyright © 2018 Alternate Labs. All rights reserved.
//

import Foundation
import ScreenSaver

class AltLabsView: ScreenSaverView {
    
    var colors: [NSColor] = [
        .black,
        .red,
        .systemPink,
        .systemPurple,
        .systemBlue,
        .cyan,
        .systemGreen,
        .systemYellow,
        .systemOrange,
        .systemBrown,
        .clear,
        .black,
        .black,
        .black,
        .black,
        .black,
    ]
    
    lazy var logoImage: NSImage! = {
        return NSImage(pathAwareName: "logo1000.png")
    }()
    
    var rotatingImage: RotatingImage!
    
    private let imageRatio: CGFloat = 1.083604777
    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    
    override var hasConfigureSheet: Bool {
        return false
    }
    
    // MARK: - Initializers
    convenience init() {
        self.init(frame: NSRect.zero, isPreview: false)
    }
    
    override init!(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    // MARK: - NSView
    override func draw(_ rect: NSRect) {
        let backgroundColor: NSColor = .black
        
        backgroundColor.setFill()
        NSBezierPath.fill(bounds)
    }
    
    
    // MARK: - ScreenSaverView
    override func animateOneFrame() {
        updateRotatingImageSize(for: self.frame)
    }
    
    // MARK: - Private
    private func initialize() {
        animationTimeInterval = 1 / 10
        
        let imageSeq: [NSImage] = colors.map { (color) -> NSImage in
            return logoImage.tintedWith(color: color)
        }
        
        rotatingImage = RotatingImage(frame: self.bounds, imageSequance: imageSeq)
        rotatingImage.translatesAutoresizingMaskIntoConstraints = false

        addSubview(rotatingImage)
        
        widthConstraint = NSLayoutConstraint(item: rotatingImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 500)
        
        heightConstraint = NSLayoutConstraint(item: rotatingImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 500 / imageRatio)
        
        rotatingImage.addConstraints([widthConstraint!, heightConstraint!])
        
        let centerX = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: rotatingImage, attribute: .centerX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: rotatingImage, attribute: .centerY, multiplier: 1, constant: 0)
        
        self.addConstraints([centerX, centerY])
    }
    
    private func updateRotatingImageSize(for frame: NSRect) {
        let maxWidth = frame.size.width / 5.0
        let width: CGFloat = min(500, maxWidth)
        let height: CGFloat = width / imageRatio

        widthConstraint?.constant = width
        heightConstraint?.constant = height
        self.needsLayout = true
    }
}
