//
//  Tooltip.swift
//  
//
//  Created by Mihael Isaev on 07.03.2023.
//

import Web

public enum TooltipPosition: String {
    case bottom, top, left, right
}

extension BaseElement {
    @discardableResult
    public func tooltip(
        _ text: String,
        position: TooltipPosition,
        exitDelay: Double = 0,
        enterDelay: Double = 0.2,
        margin: Int = 5,
        inDuration: Double = 0.3,
        outDuration: Double = 0.25,
        transitionMovement: Int = 10
    ) -> Self {
        self.class("tooltipped")
        self.attribute("data-position", position.rawValue)
        self.attribute("data-tooltip", text)
        Materialize.getInstance { instance in
            JSObject.global.eval.function?.callAsFunction(arguments: ["MTooltip = function(sel, op) { return M.Tooltip.init(document.querySelectorAll(sel), op); }"])
            _ = JSObject.global[dynamicMember: "MTooltip"].function?.callAsFunction(arguments: ["#\(self.properties._id)", [
                "exitDelay": (exitDelay * 1000).jsValue,
                "enterDelay": (enterDelay * 1000).jsValue,
                "margin": margin.jsValue,
                "inDuration": (inDuration * 1000).jsValue,
                "outDuration": (outDuration * 1000).jsValue,
                "transitionMovement": transitionMovement.jsValue
            ].jsValue])
        }
        return self
    }
    
    @discardableResult
    public func tooltip(
        html: String,
        position: TooltipPosition,
        exitDelay: Double = 0,
        enterDelay: Double = 0.2,
        margin: Int = 5,
        inDuration: Double = 0.3,
        outDuration: Double = 0.25,
        transitionMovement: Int = 10
    ) -> Self {
        self.class("tooltipped")
        self.attribute("data-position", position.rawValue)
        Materialize.getInstance { instance in
            JSObject.global.eval.function?.callAsFunction(arguments: ["MTooltip = function(sel, op) { return M.Tooltip.init(document.querySelectorAll(sel), op); }"])
            _ = JSObject.global[dynamicMember: "MTooltip"].function?.callAsFunction(arguments: ["#\(self.properties._id)", [
                "exitDelay": (exitDelay * 1000).jsValue,
                "enterDelay": (enterDelay * 1000).jsValue,
                "margin": margin.jsValue,
                "inDuration": (inDuration * 1000).jsValue,
                "outDuration": (outDuration * 1000).jsValue,
                "transitionMovement": transitionMovement.jsValue,
                "html": html.jsValue
            ].jsValue])
        }
        return self
    }
    
    @discardableResult
    public func tooltip(
        position: TooltipPosition,
        exitDelay: Double = 0,
        enterDelay: Double = 0.2,
        margin: Int = 5,
        inDuration: Double = 0.3,
        outDuration: Double = 0.25,
        transitionMovement: Int = 10,
        @DOM content: @escaping DOM.Block
    ) -> Self {
        self.class("tooltipped")
        self.attribute("data-position", position.rawValue)
        var elements: [DOMElement] = []
        func parseDOMItem(_ item: DOMItem) {
            switch item {
            case .elements(let els): elements.append(contentsOf: els)
            case .items(let items): items.forEach { parseDOMItem($0) }
            case .print(let print): Console.log(print.items)
            case .none: break
            }
        }
        parseDOMItem(content().domContentItem)
        let html = elements.map { ($0 as? WebPreviewRenderable)?.renderPreview() ?? "" }.joined()
        Materialize.getInstance { instance in
            JSObject.global.eval.function?.callAsFunction(arguments: ["MTooltip = function(sel, op) { return M.Tooltip.init(document.querySelectorAll(sel), op); }"])
            _ = JSObject.global[dynamicMember: "MTooltip"].function?.callAsFunction(arguments: ["#\(self.properties._id)", [
                "exitDelay": (exitDelay * 1000).jsValue,
                "enterDelay": (enterDelay * 1000).jsValue,
                "margin": margin.jsValue,
                "inDuration": (inDuration * 1000).jsValue,
                "outDuration": (outDuration * 1000).jsValue,
                "transitionMovement": transitionMovement.jsValue,
                "html": html.jsValue
            ].jsValue])
        }
        return self
    }
}
