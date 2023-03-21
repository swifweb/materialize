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
    func floatLeft() -> Self
    @discardableResult
    func floatRight() -> Self
    @discardableResult
    func floatCenter() -> Self
}

extension QuickFloatable {
    /// Quickly float things to left
    @discardableResult
    public func floatLeft() -> Self {
        self.class(.left)
    }
    
    /// Quickly float things to right
    @discardableResult
    public func floatRight() -> Self {
        self.class(.right)
    }
    
    /// Quickly float things to center
    @discardableResult
    public func floatCenter() -> Self {
        self.class(.center)
    }
}

extension BaseContentElement: QuickFloatable {}
