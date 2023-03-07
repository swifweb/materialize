//
//  Table.swift
//  
//
//  Created by Mihael Isaev on 05.03.2023.
//

import Web

extension Table {
    /// Striped table.
    @discardableResult
    public func striped() -> Self {
        self.class(.striped)
    }
    
    /// Highlight table.
    @discardableResult
    public func highlight() -> Self {
        self.class(.highlight)
    }
    
    /// Centered table.
    @discardableResult
    public func centered() -> Self {
        self.class(.centered)
    }
    
    /// Makes the table horizontally scrollable on smaller screen widths.
    @discardableResult
    public func responsive() -> Self {
        self.class(.responsiveTable)
    }
}
