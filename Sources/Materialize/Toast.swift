//
//  Toast.swift
//  
//
//  Created by Mihael Isaev on 07.03.2023.
//

import Web

private var _toast: Toast!

public class Toast {
    private static var shared: Toast {
        guard _toast == nil else {
            return _toast
        }
        _toast = Toast()
        return _toast
    }
    
    var closures: [JSClosure] = []
    
    private init() {}
    
    public static func show(
        displayLength: Double = 4, // 4000ms
        inDuration: Double = 0.3, // 300ms
        outDuration: Double = 0.375, // 375ms
        activationPercent: Double = 0.8,
        rounded: Bool = false,
        classes: [Class] = [],
        completeCallback: (() -> Void)? = nil,
        @DOM content: @escaping DOM.Block
    ) {
        var elements: [DOMElement] = []
        func parseDOMItem(_ item: DOMItem) {
            switch item {
            case .elements(let els): elements.append(contentsOf: els)
            case .items(let items): items.forEach { parseDOMItem($0) }
            case .forEach(let fr): fr.allItems().forEach { parseDOMItem($0.domContentItem) }
            case .none: break
            }
        }
        parseDOMItem(content().domContentItem)
        let html = elements.map { ($0 as? WebPreviewRenderable)?.renderPreview() ?? "" }.joined()
        show(
            html,
            displayLength: displayLength,
            inDuration: inDuration,
            outDuration: outDuration,
            activationPercent: activationPercent,
            rounded: rounded,
            classes: classes,
            completeCallback: completeCallback
        )
    }
    
    public static func show(
        _ html: String,
        displayLength: Double = 4, // 4000ms
        inDuration: Double = 0.3, // 300ms
        outDuration: Double = 0.375, // 375ms
        activationPercent: Double = 0.8,
        rounded: Bool = false,
        classes: [Class] = [],
        completeCallback: (() -> Void)? = nil
    ) {
        var classes: [Class] = classes
        if rounded {
            classes.append("rounded")
        }
        Materialize.getInstance { instance in
            var completeCallbackClosure: JSClosure = JSClosure { _ -> JSValue in
                completeCallback?()
                return .undefined
            }
            Toast.shared.closures.append(completeCallbackClosure)
            instance[dynamicMember: "toast"].function?.callAsFunction(arguments: [[
                "html": html.jsValue,
                "classes": classes.map { $0.names }.flatMap { $0 }.joined(separator: " ").jsValue,
                "displayLength": (displayLength * 1000).jsValue,
                "inDuration": (inDuration * 1000).jsValue,
                "outDuration": (outDuration * 1000).jsValue,
                "activationPercent": activationPercent.jsValue,
                "completeCallback": completeCallbackClosure
            ].jsValue])
            Dispatch.asyncAfter(displayLength + 0.5) {
                #if JAVASCRIPTKIT_WITHOUT_WEAKREFS
                Toast.shared.closures.removeAll(where: { $0 == completeCallbackClosure })
                #endif
            }
        }
    }
    
    
    
    public static func dismissAll() {
        
    }
}
