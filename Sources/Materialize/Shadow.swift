//
//  Shadow.swift
//  
//
//  Created by Mihael Isaev on 05.03.2023.
//

import Web

extension BaseContentElement {
    /// Applies depth-shadow effect.
    ///
    /// [Learn more](https://materializecss.com/shadow.html)
    @discardableResult
    public func zDepth(_ value: Class.ZDepth) -> Self {
        self.class(.zDepth(value))
    }
}
