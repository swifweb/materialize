//
//  TableOfContents.swift
//  
//
//  Created by Mihael Isaev on 06.03.2023.
//

import Web

public class TableOfContents: Ul {
    open class override var name: String { "\(Ul.self)".lowercased() }
    
    required public init() {
        super.init()
    }
    
    public override func postInit() {
        super.postInit()
        self.class("table-of-contents")
        Materialize.getInstance { instance in
            JSObject.global.eval.function?.callAsFunction(arguments: ["MScrollSpy = function(sel, op) { return M.ScrollSpy.init(document.querySelectorAll(sel), op); }"])
            _ = JSObject.global[dynamicMember: "MScrollSpy"].function?.callAsFunction(arguments: [".scrollspy", [:].jsValue])
        }
    }
    
    @discardableResult
    public func item(id: String, title: String, active: Bool = false) -> Self {
        self.appendChild(
            Li {
                A(title).href("#\(id)").class(active ? "active" : "")
            }
        )
        return self
    }
}
