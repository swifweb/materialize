//
//  Card.swift
//  
//
//  Created by Mihael Isaev on 06.03.2023.
//

import Web

public class Card: Div {
    open class override var name: String { "\(Div.self)".lowercased() }
    
    lazy var cardStacked = Div().class("card-stacked")
    
    var _cardStackedAdded = false
    
    func addCardStackedIfNeeded() {
        guard horizontal else { return }
        guard !_cardStackedAdded else { return }
        _cardStackedAdded = true
        self.appendChild(cardStacked)
    }
    
    lazy var cardContent = Div().class("card-content")
    
    var _cardContentAdded = false
    
    func addCardContentIfNeeded() {
        guard !_cardContentAdded else { return }
        addCardStackedIfNeeded()
        _cardContentAdded = true
        if horizontal {
            self.cardStacked.appendChild(cardContent)
        } else {
            self.appendChild(cardContent)
        }
    }
    
    lazy var cardAction = Div().class("card-action")
    
    var _cardActionAdded = false
    
    func addCardActionIfNeeded() {
        guard !_cardActionAdded else { return }
        addCardStackedIfNeeded()
        _cardActionAdded = true
        if horizontal {
            self.cardStacked.appendChild(cardAction)
        } else {
            self.appendChild(cardAction)
        }
    }
    
    let horizontal: Bool
    
    required public init() {
        self.horizontal = false
        super.init()
    }
    
    public init(horizontal: Bool) {
        self.horizontal = horizontal
        super.init()
    }
    
    /// String initializer
    /// - Parameter title: Pass `String` or `State<String>`
    required public convenience init <U>(_ title: U) where U: UniValue, U.UniValue == String {
        self.init()
        self.cardContent.appendChild(CardTitle(title))
    }
    
    /// String initializer
    /// - Parameter title: Pass `String` or `State<String>`
    public init <U>(_ title: U, horizontal: Bool) where U: UniValue, U.UniValue == String {
        self.horizontal = horizontal
        super.init()
        self.cardContent.appendChild(CardTitle(title))
    }
    
    public convenience init (image: CardImage) {
        self.init()
        self.appendChild(image)
    }
    
    public init (image: CardImage, horizontal: Bool) {
        self.horizontal = horizontal
        super.init()
        self.appendChild(image)
    }
    
    public init <U>(image: CardImage, title: U) where U: UniValue, U.UniValue == String {
        self.horizontal = false
        super.init()
        self.image(image)
        self.title(title)
    }
    
    public init <U>(image: CardImage, title: U, horizontal: Bool) where U: UniValue, U.UniValue == String {
        self.horizontal = horizontal
        super.init()
        self.image(image)
        self.title(title)
    }
    
    public init <U>(image: CardImage, title: U, message: U) where U: UniValue, U.UniValue == String {
        self.horizontal = false
        super.init()
        self.image(image)
        self.title(title)
        self.message(message)
    }
    
    public init <U>(image: CardImage, title: U, message: U, horizontal: Bool) where U: UniValue, U.UniValue == String {
        self.horizontal = horizontal
        super.init()
        self.image(image)
        self.title(title)
        self.message(message)
    }
    
    public init <U>(title: U, message: U) where U: UniValue, U.UniValue == String {
        self.horizontal = false
        super.init()
        self.title(title)
        self.message(message)
    }
    
    public init <U>(title: U, message: U, horizontal: Bool) where U: UniValue, U.UniValue == String {
        self.horizontal = horizontal
        super.init()
        self.title(title)
        self.message(message)
    }
    
    public init(horizontal: Bool, @DOM content: @escaping DOM.Block) {
        self.horizontal = horizontal
        super.init()
        cardContent.body(content: content)
    }
    
    public init(@DOM content: @escaping DOM.Block) {
        self.horizontal = false
        super.init()
        cardContent.body(content: content)
    }
    
    public override func postInit() {
        super.postInit()
        self.class("card")
        if horizontal {
            self.class("horizontal")
        }
    }
    
    @discardableResult
    public func image(_ image: CardImage) -> Self {
        self.appendChild(image)
        return self
    }
    
    @discardableResult
    public func title<U>(_ value: U) -> Self where U: UniValue, U.UniValue == String {
        addCardContentIfNeeded()
        self.cardContent.appendChild(CardTitle(value))
        return self
    }
    
    @discardableResult
    public func message<U>(_ value: U) -> Self where U: UniValue, U.UniValue == String {
        addCardContentIfNeeded()
        self.cardContent.appendChild(P(value))
        return self
    }
    
    @discardableResult
    public func actions(@DOM content: @escaping DOM.Block) -> Self {
        addCardActionIfNeeded()
        cardAction.body(content: content)
        return self
    }
    
    @discardableResult
    public func actionsBackground(_ color: MaterialColor) -> Self {
        cardAction.materialBackground(color)
        return self
    }
    
    @discardableResult
    public func action<U, H: URLConformable>(
        _ title: U,
        color: MaterialColor? = nil,
        href: H = "#!"
    ) -> Self where U: UniValue, U.UniValue == String {
        addCardActionIfNeeded()
        let a = A(title).href(href)
        if let color = color {
            a.textColor(color)
        }
        cardAction.appendChild(a)
        return self
    }
    
    @discardableResult
    public func action<U>(
        _ title: U,
        color: MaterialColor? = nil,
        _ clickHandler: @escaping () -> Void
    ) -> Self where U: UniValue, U.UniValue == String {
        addCardActionIfNeeded()
        let a = A(title).href("#!").onClick(clickHandler)
        if let color = color {
            a.textColor(color)
        }
        cardAction.appendChild(a)
        return self
    }
    
    public enum Size: String {
        case small, medium, large
    }
    
    /// If you want to have uniformly sized cards, you can use premade size classes.
    /// Just add the size class in addition to the card class.
    @discardableResult
    public func size(_ value: Size) -> Self {
        self.class(.init(stringLiteral: value.rawValue))
        return self
    }
}

public class CardTitle: Span {
    open class override var name: String { "\(Span.self)".lowercased() }
    
    required public init() {
        super.init()
    }
    
    public override func postInit() {
        super.postInit()
        self.class("card-title")
    }
}

public class CardImage: Div {
    open class override var name: String { "\(Div.self)".lowercased() }
    
    required public init() {
        super.init()
    }
    
    public init <U: URLConformable>(src: U) where U: UniValue, U.UniValue == String {
        super.init()
        self.appendChild(Img().src(src))
    }
    
    public init <U: URLConformable, T>(src: U, title: T) where U: UniValue, U.UniValue == String, T: UniValue, T.UniValue == String {
        super.init()
        self.appendChild(Img().src(src))
        self.appendChild(CardTitle(title))
    }
    
    public override func postInit() {
        super.postInit()
        self.class("card-image")
    }
    
    @discardableResult
    public func image<U: URLConformable>(src: U) -> Self where U: UniValue, U.UniValue == String {
        self.appendChild(Img().src(src))
        return self
    }
    
    @discardableResult
    public func title<U>(_ value: U) -> Self where U: UniValue, U.UniValue == String {
        self.appendChild(CardTitle(value))
        return self
    }
    
    @discardableResult
    public func actionButton(
        icon: MaterialIcon,
        size: ButtonSize = .large,
        background: MaterialColor = .red,
        color: MaterialColor = .white
    ) -> Self {
        self.appendChild(
            A()
                .materialButton(
                    type: .floatingHalfWay,
                    size: size
                )
                .body {
                    icon
                }
                .materialBackground(background)
                .textColor(color)
        )
        return self
    }
}

// TODO: Card Reveal
// TODO: Tabs in Cards
// TODO: Card Panel

