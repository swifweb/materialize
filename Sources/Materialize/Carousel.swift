//
//  Carousel.swift
//  
//
//  Created by Mihael Isaev on 06.03.2023.
//

import Web

public class Carousel: Div {
    open class override var name: String { "\(Div.self)".lowercased() }
    
    public struct Item {
        let element: A
        
        public static func item<S: URLConformable, H: URLConformable>(src: S, href: H) -> Self {
            .init(element: A { Img().src(src) }.class("carousel-item").href(href))
        }
        
        public static func item<S: URLConformable>(src: S, _ clickHandler: @escaping () -> Void) -> Self {
            .init(element: A { Img().src(src) }.class("carousel-item").href("#!").onClick(clickHandler))
        }
    }
    
    /// Transition duration in milliseconds.
    private var _duration: UInt?
    
    /// Perspective zoom. If 0, all items are the same size.
    private var _dist: Int?
    
    /// Set the spacing of the center item.
    private var _shift: Int?
    
    /// Set the padding between non center items.
    private var _padding: Int?
    
    /// Set the number of visible items.
    private var _numVisible: Int?
    
    /// Make the carousel a full width slider like the second example.
    private var _fullWidth: Bool?
    
    /// Set to true to show indicators.
    private var _indicators: Bool?
    
    /// Don't wrap around and cycle through items.
    private var _noWrap: Bool?
    
    /// Callback for when a new slide is cycled to.
    private var _onCycleTo: (() -> Void)?
    
    public init (
        _ items: Item...,
        duration: UInt? = nil,
        dist: Int? = nil,
        shift: Int? = nil,
        padding: Int? = nil,
        numVisible: Int? = nil,
        fullWidth: Bool? = nil,
        indicators: Bool? = nil,
        noWrap: Bool? = nil,
        onCycleTo: (() -> Void)? = nil
    ) {
        _duration = duration
        _dist = dist
        _shift = shift
        _padding = padding
        _numVisible = numVisible
        _fullWidth = fullWidth
        _indicators = indicators
        _noWrap = noWrap
        _onCycleTo = onCycleTo
        super.init()
        for item in items {
            self.appendChild(item.element)
        }
    }
    
    required public init() {
        super.init()
    }
    
    var instance: JSValue?
    
    public override func postInit() {
        super.postInit()
        self.class("carousel")
        var options: [String: ConvertibleToJSValue] = [:]
        if let value = _duration {
            options["duration"] = value.jsValue
        }
        if let value = _dist {
            options["dist"] = value.jsValue
        }
        if let value = _shift {
            options["shift"] = value.jsValue
        }
        if let value = _padding {
            options["padding"] = value.jsValue
        }
        if let value = _numVisible {
            options["numVisible"] = value.jsValue
        }
        if let value = _fullWidth {
            options["fullWidth"] = value.jsValue
        }
        if let value = _indicators {
            options["indicators"] = value.jsValue
        }
        if let value = _noWrap {
            options["noWrap"] = value.jsValue
        }
        self.instance = JSObject
            .global[dynamicMember: "M"]
            .jsValue.object?[dynamicMember: "Carousel"]
            .function?
            .new([self.jsValue].jsValue, options.jsValue)
            .jsValue
    }
    
    /// Move carousel to next slide.
    public func next() {
        self.instance?.next.function?.callAsFunction(optionalThis: self.instance?.object, arguments: [])
    }
    
    /// Move carousel forward a given amount of slides.
    public func next(_ amount: UInt) {
        self.instance?.next.function?.callAsFunction(optionalThis: self.instance?.object, arguments: [amount.jsValue])
    }
    
    /// Move carousel to back slide.
    public func prev() {
        self.instance?.next.function?.callAsFunction(optionalThis: self.instance?.object, arguments: [])
    }
    
    /// Move carousel backward a given amount of slides.
    public func prev(_ amount: UInt) {
        self.instance?.next.function?.callAsFunction(optionalThis: self.instance?.object, arguments: [amount.jsValue])
    }
    
    /// Move carousel to nth slide.
    public func set() {
        self.instance?.next.function?.callAsFunction(optionalThis: self.instance?.object, arguments: [])
    }
    
    /// Move carousel to nth slide.
    public func set(_ nth: UInt) {
        self.instance?.next.function?.callAsFunction(optionalThis: self.instance?.object, arguments: [nth.jsValue])
    }
    
    public enum Side: String {
        case left, center, right
    }
    
    @discardableResult
    public func fixedItem(_ side: Side, @DOM content: @escaping DOM.Block) -> Self {
        body {
            Div(content: content)
                .class("carousel-fixed-item")
                .class(.init(stringLiteral: "\(side.rawValue)"))
        }
        return self
    }
}
