//
//  Scrollspy.swift
//  
//
//  Created by Mihael Isaev on 06.03.2023.
//

import Web

extension BaseElement {
    /// Adds `scrollspy` class
    ///
    /// [Learn more](https://materializecss.com/scrollspy.html)
    @discardableResult
    public func scrollspy() -> Self {
        self.class("scrollspy")
    }
}
