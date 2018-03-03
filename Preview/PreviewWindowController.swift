//
//  PreviewWindowController.swift
//  Preview
//
//  Created by Pete Hawkins on 02/03/2018.
//  Copyright © 2018 Alternate Labs. All rights reserved.
//

import AppKit

class PreviewWindowController: NSWindowController {
    
    // MARK: - Properties
    
    let screenSaver = AltLabsView()
    
    
    // MARK: - NSWindowController
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        window?.contentView = screenSaver
        
        Timer.scheduledTimer(timeInterval: screenSaver.animationTimeInterval, target: screenSaver, selector: #selector(screenSaver.animateOneFrame), userInfo: nil, repeats: true)
    }
}

