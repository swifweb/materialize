//
//  Footer.swift
//  
//
//  Created by Mihael Isaev on 06.03.2023.
//

import Web

public class PageFooter: Footer {
    open class override var name: String { "\(Footer.self)".lowercased() }
    
    required public init() {
        super.init()
    }
    
    public override func postInit() {
        super.postInit()
        self.class(.pageFooter)
    }
}
