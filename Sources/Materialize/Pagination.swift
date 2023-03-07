//
//  Pagination.swift
//  
//
//  Created by Mihael Isaev on 06.03.2023.
//

import Web

///
/// ```
/// Pagination()
///     .back(disabled: true)
///     .item(1) // active
///     .item(2, href: "#results-2")
///     .item(3, href: "#results-3")
///     .item(4, href: "#results-4")
///     .item(5, href: "#results-5")
///     .forward(href: "#next")
/// ```
///
public class Pagination: Ul {
    open class override var name: String { "\(Ul.self)".lowercased() }
    
    required public init() {
        super.init()
    }
    
    public override func postInit() {
        super.postInit()
        self.class("pagination")
    }
    
    // MARK: Back
    
    @discardableResult
    public func back<U: URLConformable>(
        disabled: Bool = true,
        icon: MaterialIcon = .chevron_left,
        href: U = "#!"
    ) -> Self {
        self.appendChild(Li{
            A {
                I(icon.rawValue).class(.materialIcons)
            }
            .href(href)
        }
        .class(disabled ? "disabled" : ""))
        return self
    }
    
    @discardableResult
    public func back(
        disabled: Bool = true,
        icon: MaterialIcon = .chevron_left,
        _ clickHandler: @escaping () -> Void
    ) -> Self {
        self.appendChild(Li{
            A {
                I(icon.rawValue).class(.materialIcons)
            }
            .href("#!")
            .onClick(clickHandler)
        }
        .class(disabled ? "disabled" : ""))
        return self
    }
    
    // MARK: Item
    
    @discardableResult
    public func item<U: URLConformable>(
        _ number: Int,
        href: U
    ) -> Self {
        self.appendChild(
            Li{
                A("\(number)").href(href)
            }
            .class(.wavesEffect)
        )
        return self
    }
    
    @discardableResult
    public func item(
        _ number: Int,
        _ clickHandler: @escaping () -> Void
    ) -> Self {
        self.appendChild(
            Li{
                A("\(number)")
                    .href("#!")
                    .onClick(clickHandler)
            }
            .class(.wavesEffect)
        )
        return self
    }
    
    @discardableResult
    public func item(
        _ number: Int
    ) -> Self {
        self.appendChild(
            Li{
                A("\(number)").href("#!")
            }
            .class("active")
        )
        return self
    }
    
    // MARK: Forward
    
    @discardableResult
    public func forward<U: URLConformable>(
        disabled: Bool = true,
        icon: MaterialIcon = .chevron_right,
        href: U
    ) -> Self {
        self.appendChild(Li{
            A {
                I(icon.rawValue).class(.materialIcons)
            }
            .href(href)
        }
        .class(disabled ? "disabled" : ""))
        return self
    }
    
    @discardableResult
    public func forward(
        disabled: Bool = true,
        icon: MaterialIcon = .chevron_right,
        _ clickHandler: @escaping () -> Void
    ) -> Self {
        self.appendChild(Li{
            A {
                I(icon.rawValue).class(.materialIcons)
            }
            .href("#!")
            .onClick(clickHandler)
        }
        .class(disabled ? "disabled" : ""))
        return self
    }
}
