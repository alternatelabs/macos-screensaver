//
//  NSImage.swift
//  AltLabsScreenSaver
//
//  Created by Pete Hawkins on 02/03/2018.
//  Copyright © 2018 Alternate Labs. All rights reserved.
//

import Cocoa

extension NSImage {
    public convenience init?(pathAwareName name:String ) {
        if let imageURL = Bundle(for: AltLabsView.self).url(forResource: name, withExtension: nil) {
            self.init(contentsOf: imageURL)!
        } else {
            self.init(named: NSImage.Name(name))
        }
    }
    
    func tintedWith(color tint: NSColor) -> NSImage {
        let image: NSImage = self.copy() as! NSImage
        image.lockFocus()
        tint.set()
        let imageRect = NSRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        imageRect.fill(using: .sourceAtop)
        image.unlockFocus()
        return image
    }
}
