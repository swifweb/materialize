//
//  Collapsible.swift
//  
//
//  Created by Mihael Isaev on 06.03.2023.
//

import Web

public class Collapsible: Ul {
    open class override var name: String { "\(Ul.self)".lowercased() }
    
    required public init() {
        super.init()
    }
    
    public override func postInit() {
        super.postInit()
        self.class(.divider)
    }
}
