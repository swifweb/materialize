//
//  Alignment.swift
//  
//
//  Created by Mihael Isaev on 05.03.2023.
//

import Web

// MARK: Vertical Align

/// Holding the items you want to vertically align.
public class VAlignWrapper: Div {
    open class override var name: String { "\(Div.self)".lowercased() }
    
    required public init() {
        super.init()
    }
    
    public override func postInit() {
        super.postInit()
        self.class(.valignWrapper)
    }
}

// MARK: Text Align

public protocol TextCenterable: ClassAttrable {
    @discardableResult
    func centerAlign() -> Self
    @discardableResult
    func leftAlign() -> Self
    @discardableResult
    func rightAlign() -> Self
}

extension TextCenterable {
    /// Horizontally aligning text to center
    @discardableResult
    public func centerAlign() -> Self {
        self.class(.centerAlign)
    }
    
    /// Horizontally aligning text to left
    @discardableResult
    public func leftAlign() -> Self {
        self.class(.leftAlign)
    }
    
    /// Horizontally aligning text to right
    @discardableResult
    public func rightAlign() -> Self {
        self.class(.rightAlign)
    }
}

extension BaseContentElement: TextCenterable {}

// MARK: Quick Floats

public protocol QuickFloatable: ClassAttrable {
    @discardableResult
    func left() -> Self
    @discardableResult
    func right() -> Self
}

extension QuickFloatable {
    /// Quickly float things to left
    @discardableResult
    public func left() -> Self {
        self.class(.left)
    }
    
    /// Quickly float things to right
    @discardableResult
    public func right() -> Self {
        self.class(.right)
    }
}

extension BaseContentElement: QuickFloatable {}
