//
//  Transitions.swift
//  
//
//  Created by Mihael Isaev on 05.03.2023.
//

import Web

extension BaseContentElement {
    /// Prepare element to be scaled-in
    @discardableResult
    public func scaledOut() -> Self {
        self.removeClass(.scaleIn)
        return self.class([.scaleTransition, .scaleOut])
    }
    
    /// Prepare element to be scaled-out
    @discardableResult
    public func scaledIn() -> Self {
        self.removeClass(.scaleOut)
        return self.class([.scaleTransition, .scaleIn])
    }
    
    /// Scale-out element
    @discardableResult
    public func scaleOut() -> Self {
        self.removeClass(.scaleIn)
        return self.class(.scaleOut)
    }
    
    /// Scale-in element
    @discardableResult
    public func scaleIn() -> Self {
        self.removeClass(.scaleOut)
        return self.class(.scaleIn)
    }
}
