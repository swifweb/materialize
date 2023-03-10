//
//  Buttons.swift
//  
//
//  Created by Mihael Isaev on 05.03.2023.
//

import Web
import JavaScriptKit

extension BaseContentElement {
    public enum ButtonWaveType: String {
        case light = "waves-light"
        case red = "waves-red"
        case yellow = "waves-yellow"
        case orange = "waves-orange"
        case purple = "waves-purple"
        case green = "waves-green"
        case teal = "waves-teal"
    }
    
    public enum ButtonType {
        case raised, floating, floatingHalfWay, flat
    }
    
    public enum ButtonSize {
        case small, large
        
        func map<T>(_ handler: (Self) -> T) -> T {
            handler(self)
        }
    }
    
    @discardableResult
    public func materialButton(
        type: ButtonType = .raised,
        size: ButtonSize? = nil,
        waves: ButtonWaveType = .light,
        wavesRipple: Bool = false,
        disabled: Bool = false
    ) -> Self {
        materialButton(type: type, size: size, waves: waves, wavesRipple: wavesRipple, disabled: State(wrappedValue: disabled))
    }
    
    @discardableResult
    public func materialButton<D>(
        type: ButtonType = .raised,
        size: ButtonSize? = nil,
        waves: ButtonWaveType = .light,
        wavesRipple: Bool = false,
        disabled: D
    ) -> Self where D: StateConvertible, D.Value == Bool {
        var classes: [Class] = [.wavesEffect]
        classes.append(.init(stringLiteral: waves.rawValue))
        if wavesRipple {
            classes.append(.wavesRipple)
        }
        switch type {
        case .raised: break
        case .floating: classes.append(.btnFloating)
        case .floatingHalfWay: classes.append(contentsOf: [.btnFloating, .init(stringLiteral: "halfway-fab")])
        case .flat: classes.append(.btnFlat)
        }
        if let size = size {
            switch size {
            case .small: classes.append(.btnSmall)
            case .large: classes.append(.btnLarge)
            }
        } else {
            classes.append(.btn)
        }
        func applyDisabled(_ disabled: Bool) {
            if disabled {
                self.class(.disabled)
            } else {
                self.removeClass(.disabled)
            }
        }
        applyDisabled(disabled.stateValue.wrappedValue)
        disabled.stateValue.listen(applyDisabled)
        self.class(classes)
        Materialize.setupWaves()
        return self
    }
    
    @discardableResult
    public func addMaterialIcon(_ icon: MaterialIcon) -> Self {
        self.appendChild(icon)
        return self
    }
}

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
        case hover
        case click
        case toolbar
    }
    
    var mode: Mode = .click
    
    public init (
        icon: MaterialIcon,
        color: MaterialColor,
        size: ButtonSize = .large,
        waves: ButtonWaveType = .light,
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
                .materialButton(type: .floating, size: size)
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
