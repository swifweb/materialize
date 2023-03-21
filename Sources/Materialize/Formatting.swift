//
//  Formatting.swift
//  
//
//  Created by Mihael Isaev on 16.03.2023.
//

import Web

extension BaseContentElement {
    /// Truncates long lines of text in an ellipsis.
    @discardableResult
    public func truncate() -> Self {
        self.class(.truncate)
        return self
    }
    
    /// Truncates long lines of text in an ellipsis.
    @discardableResult
    public func truncate(_ state: State<Bool>) -> Self {
        if state.wrappedValue {
            self.class(.truncate)
        }
        state.listen {
            if $0 {
                self.class(.truncate)
            } else {
                self.removeClass(.truncate)
            }
        }
        return self
    }
}

extension BaseElement {
    /// Adds an animation for box shadow.
    /// It can be used on most elements, but meant for use on cards.
    @discardableResult
    public func hoverable() -> Self {
        self.class(.hoverable)
        return self
    }
    
    /// Adds an animation for box shadow.
    /// It can be used on most elements, but meant for use on cards.
    @discardableResult
    public func hoverable(_ state: State<Bool>) -> Self {
        if state.wrappedValue {
            self.class(.hoverable)
        }
        state.listen {
            if $0 {
                self.class(.hoverable)
            } else {
                self.removeClass(.hoverable)
            }
        }
        return self
    }
    
    // MARK: Browser Defaults
    
    /// Reverts ul, select, input elements to their original state.
    @discardableResult
    public func browserDefault() -> Self {
        self.class(.browserDefault)
    }
}
