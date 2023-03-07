//
//  Badge.swift
//  
//
//  Created by Mihael Isaev on 05.03.2023.
//

import Web

public class Badge: Div {
    open class override var name: String { "\(Span.self)".lowercased() }

    private let new: Bool
    private let caption: String?

    public init <U>(_ title: U, new: Bool = false, caption: String? = nil) where U: UniValue, U.UniValue == String {
        self.new = new
        self.caption = caption
        super.init()
        _ = self.innerText(title)
    }

    required init() {
        self.new = false
        self.caption = nil
        super.init()
    }

    public override func postInit() {
        super.postInit()
        self.class(.badge)
        if new {
            self.class(.new)
        }
        if let caption = caption {
            self.attribute("data-badge-caption", caption)
        }
    }
}
