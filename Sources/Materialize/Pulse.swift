//
//  Pulse.swift
//  
//
//  Created by Mihael Isaev on 05.03.2023.
//

import Web

extension BaseContentElement {
    /// Draws attention to your buttons with this subtle but captivating effect.
    ///
    /// Just add the class pulse to your button.
    ///
    /// Note: This is meant for floating buttons, so it may not work perfectly with every component.
    ///
    /// [Learn more](https://materializecss.com/pulse.html)
    @discardableResult
    public func pulse() -> Self {
        self.class(.pulse)
    }
}
