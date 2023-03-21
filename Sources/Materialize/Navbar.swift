//
//  Navbar.swift
//  
//
//  Created by Mihael Isaev on 06.03.2023.
//

import Web

public class NavbarFixed: Div {
    open class override var name: String { "\(Div.self)".lowercased() }
    
    required public init() {
        super.init()
    }
    
    public override func postInit() {
        super.postInit()
        self.class("navbar-fixed")
    }
}

public class Navbar: Nav {
    open class override var name: String { "\(Nav.self)".lowercased() }
    
    lazy var navWrapper = Div().class("nav-wrapper")
    lazy var ul = Ul().id("nav-mobile").class(.right)
    lazy var navContent = Div { self.tabsUl }.class("nav-content")
    lazy var tabsUl = Ul().class("tabs").class("tabs-transparent")
    lazy var sidenavUl = Ul().id("mobile-demo").class("sidenav")
    lazy var searchBarForm = Form { self.seachDiv }
    lazy var seachDiv = Div {
        self.searchInput
        Label { self.searchIcon }.class("label-icon").attribute("for", "search")
        self.closeSearchIcon
    }
    .class("input-field")
    lazy var searchIcon = MaterialIcon("search")
    lazy var closeSearchIcon = MaterialIcon("close")
    
    public private(set) lazy var searchInput = InputSearch()
    
    var _navContentAdded = false
    
    func addNavContentIfNeeded() {
        guard !_navContentAdded else { return }
        _navContentAdded = true
        self.class("nav-extended")
        self.appendChild(navContent)
    }
    
    var _sidenavAdded = false
    
    func addSidenavIfNeeded() {
        guard !_sidenavAdded else { return }
        _sidenavAdded = true
        self.appendChild(sidenavUl)
        Materialize.getInstance { instance in
            _ = instance.Sidenav.function?
                .new(arguments: [self.sidenavUl.jsValue, [:].jsValue])
        }
    }
    
    required public init() {
        super.init()
    }
    
    public enum Mode {
        case menu
        case searchBar
    }
    
    var mode: Mode = .menu {
        didSet {
            didUpdateMode()
        }
    }
    
    public init(mode: Mode = .menu, @DOM content: @escaping DOM.Block) {
        self.mode = mode
        super.init()
        navWrapper.body(content: content)
    }
    
    public override func postInit() {
        super.postInit()
        self.appendChild(navWrapper)
        navWrapper.body {
            self.searchBarForm
            self.ul
        }
        didUpdateMode()
    }
    
    private func didUpdateMode() {
        switch mode {
        case .menu:
            self.searchBarForm.display(.none)
            self.ul.display(.block)
        case .searchBar:
            self.searchBarForm.display(.block)
            self.ul.display(.none)
        }
    }
    
    public override var body: DOM.Content { navWrapper.body }
    
    public func body(@DOM content: @escaping DOM.Block) -> Self {
        navWrapper.body(content: content)
        return self
    }
    
    @discardableResult
    public func right() -> Self {
        ul.removeClass(.left)
        ul.class(.right)
        return self
    }
    
    @discardableResult
    public func left() -> Self {
        ul.removeClass(.right)
        ul.class(.left)
        return self
    }
    
    // MARK: Items
    
    @discardableResult
    public func items(@DOM content: @escaping DOM.Block) -> Self {
        ul.body(content: content)
        return self
    }
    
    @discardableResult
    public func item<U: URLConformable>(
        _ title: String,
        icon: MaterialIcon? = nil,
        active: Bool = false,
        href: U
    ) -> Self {
        let a = A(title).href(href)
        if let icon = icon {
            a.appendChild(icon)
        }
        let li = Li { a }
        if active {
            li.class("active")
        }
        ul.appendChild(li)
        return self
    }
    
    @discardableResult
    public func item(
        _ title: String,
        icon: MaterialIcon? = nil,
        active: Bool = false,
        _ clickHandler: @escaping () -> Void
    ) -> Self {
        let a = A(title).onClick(clickHandler)
        if let icon = icon {
            a.appendChild(icon)
        }
        let li = Li { a }
        if active {
            li.class("active")
        }
        ul.appendChild(li)
        return self
    }
    
    @discardableResult
    public func dropdownItem(
        _ title: String,
        icon: MaterialIcon? = nil,
        background: MaterialColor? = nil,
        hover: Bool = true,
        @DOM content: @escaping DOM.Block
    ) -> Self {
        let dropdownUl = Ul(content: content).class("dropdown-content")
        if let color = background {
            dropdownUl.class(color.classes)
        }
        let a = A(title)
            .class("dropdown-trigger")
            .href("#!")
            .attribute("data-target", dropdownUl.properties._id)
        if let icon = icon {
            a.appendChild(icon.side(.right))
        } else {
            a.body {
                MaterialIcon("arrow_drop_down").side(.right)
            }
        }
        ul.appendChild(Li { a })
        WebApp.shared.document.body.appendChild(dropdownUl)
        Materialize.getInstance { instance in
            _ = instance.Dropdown.function?
                .new(arguments: [a.jsValue, ["hover": hover.jsValue].jsValue])
        }
        return self
    }
    
    // MARK: Tabs
    
    @discardableResult
    public func tabs(@DOM content: @escaping DOM.Block) -> Self {
        addNavContentIfNeeded()
        tabsUl.body(content: content)
        return self
    }
    
    @discardableResult
    public func tab(
        _ title: String,
        icon: MaterialIcon? = nil,
        disabled: Bool,
        id: String,
        @DOM content: @escaping DOM.Block
    ) -> Self {
        tab(title, icon: icon, disabled: State(wrappedValue: disabled), id: id, content: content)
    }
    
    @discardableResult
    public func tab<D>(
        _ title: String,
        icon: MaterialIcon? = nil,
        disabled: D,
        id: String,
        @DOM content: @escaping DOM.Block
    ) -> Self where D: StateConvertible, D.Value == Bool {
        addNavContentIfNeeded()
        let a = A(title).href("#\(id)")
        if let icon = icon {
            a.appendChild(icon)
        }
        tabsUl.appendChild(Li { a }.class("tab"))
        self.appendChild(Div(content: content).id(.init(stringLiteral: id)).class(.col).class("s12"))
        return self
    }
    
    @discardableResult
    public func tab<U: URLConformable>(
        _ title: String,
        icon: MaterialIcon? = nil,
        disabled: Bool,
        href: U
    ) -> Self {
        tab(title, icon: icon, disabled: State(wrappedValue: disabled), href: href)
    }
    
    @discardableResult
    public func tab<U: URLConformable, D>(
        _ title: String,
        icon: MaterialIcon? = nil,
        disabled: D,
        href: U
    ) -> Self where D: StateConvertible, D.Value == Bool {
        addNavContentIfNeeded()
        let a = A(title).href(href)
        if let icon = icon {
            a.appendChild(icon)
        }
        tabsUl.appendChild(Li { a }.class("tab"))
        return self
    }
    
    @discardableResult
    public func tab(
        _ title: String,
        icon: MaterialIcon? = nil,
        disabled: Bool,
        _ clickHandler: @escaping () -> Void
    ) -> Self {
        tab(title, icon: icon, disabled: State(wrappedValue: disabled), clickHandler)
    }
    
    @discardableResult
    public func tab<D>(
        _ title: String,
        icon: MaterialIcon? = nil,
        disabled: D,
        _ clickHandler: @escaping () -> Void
    ) -> Self where D: StateConvertible, D.Value == Bool {
        addNavContentIfNeeded()
        let a = A(title).onClick(clickHandler)
        if let icon = icon {
            a.appendChild(icon)
        }
        tabsUl.appendChild(Li { a }.class("tab"))
        return self
    }
    
    // MARK: Side Navigation
    
    @discardableResult
    public func sideItems(@DOM content: @escaping DOM.Block) -> Self {
        sidenavUl.body(content: content)
        return self
    }
    
    @discardableResult
    public func sideItem<U: URLConformable>(
        _ title: String,
        icon: MaterialIcon? = nil,
        active: Bool = false,
        href: U
    ) -> Self {
        let a = A(title).href(href)
        if let icon = icon {
            a.appendChild(icon)
        }
        let li = Li { a }
        if active {
            li.class("active")
        }
        sidenavUl.appendChild(li)
        return self
    }
    
    @discardableResult
    public func sideItem(
        _ title: String,
        icon: MaterialIcon? = nil,
        active: Bool = false,
        _ clickHandler: @escaping () -> Void
    ) -> Self {
        let a = A(title).onClick(clickHandler)
        if let icon = icon {
            a.appendChild(icon)
        }
        let li = Li { a }
        if active {
            li.class("active")
        }
        sidenavUl.appendChild(li)
        return self
    }
    
    public class DropdownDivider: Li {
        open class override var name: String { "\(Li.self)".lowercased() }
        
        required public init() {
            super.init()
        }
        
        public override func postInit() {
            super.postInit()
            self.class(.divider)
        }
    }
    
    // MARK: Search Bar
    
    public func showSearch() {
        self.mode = .searchBar
    }
    
    public func hideSearch() {
        self.mode = .menu
    }
    
    @discardableResult
    public func searchIcon(_ type: String) -> Self {
        searchIcon.type(type)
        return self
    }
    
    @discardableResult
    public func closeSearchIcon(_ type: String) -> Self {
        closeSearchIcon.type(type)
        return self
    }
}

public class DropdownItem: Li {
    open class override var name: String { "\(Li.self)".lowercased() }
    
    required public init() {
        super.init()
    }
    
    public override func postInit() {
        super.postInit()
    }
    
    /// String initializer
    /// - Parameter title: Pass `String` or `State<String>`
    required public convenience init <U>(_ title: U) where U: UniValue, U.UniValue == String {
        self.init()
        self.appendChild(A(title).href("#!"))
    }
    
    public init <U: URLConformable>(
        _ title: String,
        color: MaterialColor,
        icon: MaterialIcon? = nil,
        active: Bool = false,
        href: U = "#!"
    ) {
        super.init()
        let a = A(title).href(href).textColor(color)
        if let icon = icon {
            a.appendChild(icon)
        }
        if active {
            self.class("active")
        }
        self.appendChild(a)
    }
    
    public init (
        _ title: String,
        color: MaterialColor,
        icon: MaterialIcon? = nil,
        active: Bool = false,
        _ clickHandler: @escaping () -> Void
    ) {
        super.init()
        let a = A(title).href("#!").onClick(clickHandler).textColor(color)
        if let icon = icon {
            a.appendChild(icon)
        }
        if active {
            self.class("active")
        }
        self.appendChild(a)
    }
}
