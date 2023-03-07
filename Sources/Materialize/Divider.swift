//
//  Divider.swift
//  
//
//  Created by Mihael Isaev on 05.03.2023.
//

import Web

/// Divider is 1 pixel line that help break up your content.
public class Divider: Div {
    open class override var name: String { "\(Div.self)".lowercased() }
    
    required public init() {
        super.init()
    }
    
    public override func postInit() {
        super.postInit()
        self.class(.divider)
    }
}
