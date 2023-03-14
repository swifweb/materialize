//
//  MaterialIcon.swift
//  
//
//  Created by Mihael Isaev on 14.03.2023.
//

import Web

public class MaterialIcon: BaseContentElement, ExpressibleByStringLiteral {
    open class override var name: String { "i" }
    
    required public init() {
        super.init()
    }
    
    required public init (_ type: String) {
        super.init()
        self.innerText = type
    }
    
    required public init (stringLiteral type: String) {
        super.init()
        self.innerText = type
    }
    
    public override func postInit() {
        super.postInit()
        self.class(.materialIcons)
    }
    
    @discardableResult
    public func type(_ type: String) -> Self {
        self.innerText = type
        return self
    }
    
    var previousSize: MaterialIconSize?
    
    @discardableResult
    public func size(_ size: MaterialIconSize? = nil) -> Self {
        guard let size = size else {
            if let size = previousSize {
                self.removeClass(size.class)
            }
            return self
        }
        guard previousSize != size else { return self }
        if let size = previousSize {
            self.removeClass(size.class)
        }
        self.class(size.class)
        previousSize = size
        return self
    }
    
    var previousSide: MaterialIconSide?
    
    @discardableResult
    public func side(_ side: MaterialIconSide?) -> Self {
        guard let side = side else {
            if let side = previousSide {
                self.removeClass(Class(side.rawValue))
            }
            return self
        }
        guard previousSide != side else { return self }
        if let side = previousSide {
            self.removeClass(Class(side.rawValue))
        }
        self.class(Class(side.rawValue))
        previousSide = side
        return self
    }
}

extension MaterialIcon {
    public enum MaterialIconSide: String {
        case left, right
    }
}

extension MaterialIcon {
    public enum MaterialIconSize: String {
        case tiny, small, medium, large
        
        func map<T>(_ handler: (Self) -> T) -> T {
            handler(self)
        }
        
        var `class`: Class {
            switch self {
            case .tiny: return .tiny
            case .small: return .small
            case .medium: return .medium
            case .large: return .large
            }
        }
    }
}
