//
//  Preloader.swift
//  
//
//  Created by Mihael Isaev on 06.03.2023.
//

import Web

public class PreloaderLinearDeterminate: Div {
    open class override var name: String { "\(Div.self)".lowercased() }
    
    lazy var determinate = Div().class("determinate").width(0, .percent)
    
    @State public var value: Double = 0
    
    public init <V>(_ value: V) where V: UniValue, V.UniValue == Double {
        super.init()
        self.value = value.uniValue
        self.determinate.width(value.uniValue.doubleValue, .percent)
        if let state = value.uniStateValue {
            _value.merge(with: state, leftChanged: { [weak self] in
                self?.determinate.width($0, .percent)
            }, rightChanged: { [weak self] in
                self?.determinate.width($0, .percent)
            })
        } else {
            _value.listen { [weak self] in
                self?.determinate.width($0, .percent)
            }
        }
    }
    
    required public init() {
        super.init()
    }
    
    public override func postInit() {
        super.postInit()
        self.class("progress")
        self.appendChild(determinate)
    }
    
    @discardableResult
    public func progress<V>(_ value: V) -> Self where V: UniValue, V.UniValue == Double {
        self.value = value.uniValue
        self.determinate.width(value.uniValue.doubleValue, .percent)
        if let state = value.uniStateValue {
            _value.merge(with: state, leftChanged: { [weak self] in
                self?.determinate.width($0, .percent)
            }, rightChanged: { [weak self] in
                self?.determinate.width($0, .percent)
            })
        } else {
            _value.listen { [weak self] in
                self?.determinate.width($0, .percent)
            }
        }
        return self
    }
}

public class PreloaderLinearIndeterminate: Div {
    open class override var name: String { "\(Div.self)".lowercased() }
    
    lazy var indeterminate = Div().class("indeterminate")
    
    required public init() {
        super.init()
    }
    
    public override func postInit() {
        super.postInit()
        self.class("progress")
        self.appendChild(indeterminate)
    }
}

public class PreloaderCircular: Div {
    open class override var name: String { "\(Div.self)".lowercased() }
    
    public enum Size {
        case small, medium, big
    }
    
    public enum Color: String {
        case red = "spinner-red"
        case blue = "spinner-blue"
        case yellow = "spinner-yellow"
        case green = "spinner-green"
    }
    
    public init (size: Size = .medium, colors: Color...) {
        super.init()
        switch size {
        case .small: self.class("small")
        case .medium: break
        case .big: self.class("big")
        }
        for color in colors {
            _addSpinnerLayer(color, only: colors.count == 1)
        }
    }
    
    private func _addSpinnerLayer(_ color: Color, only: Bool) {
        body {
            Div {
                Div { Div().class("circle") }.class("circle-clipper").class("left")
                Div { Div().class("circle") }.class("gap-patch")
                Div { Div().class("circle") }.class("circle-clipper").class("right")
            }
            .class("spinner-layer")
            .class(.init(stringLiteral: "\(color.rawValue)\(only ? "-only" : "")"))
        }
    }
    
    required public init() {
        super.init()
    }
    
    public override func postInit() {
        super.postInit()
        self.class("preloader-wrapper")
    }
    
    private func _applyActive(_ value: Bool) {
        if value {
            self.class("active")
        } else {
            self.removeClass("active")
        }
    }
    
    @discardableResult
    public func active(_ value: Bool = true) -> Self {
        _applyActive(value)
        return self
    }
    
    @discardableResult
    public func active<A>(_ value: A) -> Self where A: StateConvertible, A.Value == Bool {
        _applyActive(value.stateValue.wrappedValue)
        value.stateValue.listen(_applyActive)
        return self
    }
}
