//
//  Buttons.swift
//  
//
//  Created by Mihael Isaev on 05.03.2023.
//

import Web
import JavaScriptKit

public class FloatingActionButton: Div {
    open class override var name: String { "\(Div.self)".lowercased() }
    
    public enum Direction: String {
        case top, right, bottom, left
    }
    
    var direction: Direction = .top
    var hoverEnabled: Bool = true
    var toolbarEnabled: Bool = false
    var halfway = false
    
    public enum Mode {
        case hover, click, toolbar
    }
    
    var mode: Mode = .click
    
    public init (
        icon: MaterialIcon,
        color: MaterialColor,
        size: ButtonSize = .large,
        waves: MaterialWaves = .light,
        direction: Direction = .top,
        mode: Mode = .hover
    ) {
        self.direction = direction
        self.mode = mode
        switch mode {
        case .click:
            self.hoverEnabled = false
            self.toolbarEnabled = false
        case .hover:
            self.hoverEnabled = true
            self.toolbarEnabled = false
        case .toolbar:
            self.hoverEnabled = false
            self.toolbarEnabled = true
        }
        super.init()
        if mode == .toolbar {
            self.class("toolbar")
        }
        self.body {
            A()
                .materialButton(type: .floating, size: size, waves: waves)
                .class(color.classes)
                .body { icon }
            self.ul
        }
    }
    
    lazy var ul = Ul()
    
    required public init() {
        super.init()
    }
    
    var materializedInstance: JSValue?
    
    public override func postInit() {
        super.postInit()
        self.class(.fixedActionBtn)
        let options: [String: ConvertibleToJSValue] = [
            "direction": self.direction.rawValue,
            "hoverEnabled": self.hoverEnabled,
            "toolbarEnabled": self.toolbarEnabled
        ]
        Materialize.getInstance { instance in
            self.materializedInstance = instance.FloatingActionButton.function?
                .new(arguments: [self.jsValue, options.jsValue])
                .jsValue
        }
    }
    
    @discardableResult
    public func item<H: URLConformable>(icon: MaterialIcon, color: MaterialColor, href: H = "#!") -> Self {
        if mode == .toolbar {
            self.ul.appendChild(
                Li {
                    A {
                        icon
                    }
                    .href(href)
                }
            )
        } else {
            self.ul.appendChild(
                Li {
                    A {
                        icon
                    }
                    .href(href)
                    .class(.btnFloating)
                    .class(color.classes)
                }
            )
        }
        return self
    }
    
    @discardableResult
    public func item(icon: MaterialIcon, color: MaterialColor, handler: @escaping () -> Void) -> Self {
        if mode == .toolbar {
            self.ul.appendChild(
                Li {
                    A {
                        icon
                    }
                    .href("")
                    .onClick { a, event in
                        event.preventDefault()
                        handler()
                    }
                }
            )
        } else {
            self.ul.appendChild(
                Li {
                    A {
                        icon
                    }
                    .href("")
                    .onClick { a, event in
                        event.preventDefault()
                        handler()
                    }
                    .class(.btnFloating)
                    .class(color.classes)
                }
            )
        }
        return self
    }
    
    /// Opens FAB.
    public func open() {
        self.materializedInstance?[dynamicMember: "open"]
            .function?
            .callAsFunction(
                optionalThis: self.materializedInstance?.object,
                arguments: []
            )
    }
    
    /// Closes FAB.
    public func close() {
        self.materializedInstance?[dynamicMember: "close"]
            .function?
            .callAsFunction(
                optionalThis: self.materializedInstance?.object,
                arguments: []
            )
    }
    
    public var isOpen: Bool {
        self.materializedInstance?[dynamicMember: "isOpen"].boolean ?? false
    }
}
