//
//  Typography.swift
//  
//
//  Created by Mihael Isaev on 05.03.2023.
//

import Web

extension BaseContentElement {
    /// Flows the text
    @discardableResult
    public func flowText() -> Self {
        self.class(.flowText)
    }
}
