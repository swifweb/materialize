//
//  Container.swift
//  
//
//  Created by Mihael Isaev on 05.03.2023.
//

import Web

public class Container: Div {
    open class override var name: String { "\(Div.self)".lowercased() }
    
    required public init() {
        super.init()
    }
    
    public override func postInit() {
        super.postInit()
        self.class(.container)
    }
}
