//
//  Section.swift
//  
//
//  Created by Mihael Isaev on 05.03.2023.
//

import Web

/// The `Section` is used for simple top and bottom padding.
public class Section: Div {
    open class override var name: String { "\(Div.self)".lowercased() }
    
    required public init() {
        super.init()
    }
    
    public init (scrollspy: Bool) {
        super.init()
        if scrollspy {
            self.scrollspy()
        }
    }
    
    public init (scrollspy: Bool, @DOM content: @escaping DOM.Block) {
        super.init()
        if scrollspy {
            self.scrollspy()
        }
        self.body(content: content)
    }
    
    public override func postInit() {
        super.postInit()
        self.class(.section)
    }
}

extension BaseContentElement {
    /// Adds `section` class
    @discardableResult
    public func section() -> Self {
        self.class(.section)
    }
}
