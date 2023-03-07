//
//  Media.swift
//  
//
//  Created by Mihael Isaev on 05.03.2023.
//

import Web

// MARK: - Images

// MARK: Responsive Images

extension Img {
    /// Makes image resize responsively to page width.
    /// It will now have a max-width: 100% and height:auto.
    @discardableResult
    public func responsive() -> Self {
        self.class(.responsiveImg)
    }
}

// MARK: Circular images

extension Img {
    /// Makes image appear circular.
    @discardableResult
    public func circle() -> Self {
        self.class(.circle)
    }
}

// MARK: - Videos

// MARK: Responsive Embeds

extension BaseContentElement {
    /// Makes your embeds responsive.
    @discardableResult
    public func videoContainer() -> Self {
        self.class(.videoContainer)
    }
}

// MARK: Responsive Videos

extension Video {
    /// Makes your HTML5 Video responsive.
    @discardableResult
    public func responsive() -> Self {
        self.class(.responsiveVideo)
    }
}
