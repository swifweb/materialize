//
//  Materialize.swift
//  
//
//  Created by Mihael Isaev on 01.03.2023.
//

import Web
import JavaScriptKit

private var materialize: Materialize!

public class Materialize {
    private static var shared: Materialize {
        guard materialize == nil else {
            return materialize
        }
        materialize = Materialize()
        return materialize
    }
    
    public static func configure(avoidStyles: Bool? = nil) {
        if avoidStyles != true {
            let style = Link().rel(.stylesheet).href("/css/materialize.min.css")
            WebApp.shared.document.head.appendChild(style)
        }
        let font = Link().rel(.preLoad).href("https://fonts.googleapis.com/icon?family=Material+Icons").attribute("as", "style").attribute("onload", "this.rel = 'stylesheet'")
        WebApp.shared.document.head.appendChild(font)
        #if DEBUG
        WebApp.shared.addScript("/js/materialize.js")
        #else
        WebApp.shared.addScript("/js/materialize.min.js")
        #endif
        WebApp.shared.addStylesheet {
            CSSRule(Class.materialIcons.pointer)
                .maxWidth(22.px)
                .overflow(.hidden)
        }
        func initializeJSInstance(_ attempt: Int = 0) {
            Dispatch.asyncAfter(0.1) {
                Self.shared.jsValue = JSObject.global["M"]
                if let instance = Self.shared.jsValue, !instance.isNull, !instance.isUndefined {
                    for callback in Self.shared.jsValueSubscribers {
                        callback(instance)
                    }
                    Self.shared.jsValueSubscribers = []
                } else {
                    if attempt < 30 {
                        initializeJSInstance(attempt + 1)
                    }
                }
            }
        }
        initializeJSInstance()
    }
    
    private var jsValue: JSValue?
    private var jsValueSubscribers: [(JSValue) -> Void] = []
    
    static func getInstance(_ callback: @escaping (JSValue) -> Void) {
        if let instance = Self.shared.jsValue, !instance.isNull, !instance.isUndefined {
            callback(instance)
        } else {
            Self.shared.jsValueSubscribers.append(callback)
        }
    }
    
    static func setupWaves() {
        getInstance { _ in
            JSObject.global["Waves"].displayEffect.function?.callAsFunction(arguments: [])
        }
    }
}

extension Class {
    // MARK: Colors
    
    public static var red: Class { "red" }
    public static var pink: Class { "pink" }
    public static var purple: Class { "purple" }
    public static var deepPurple: Class { "deep-purple" }
    public static var indigo: Class { "indigo" }
    public static var blue: Class { "blue" }
    public static var lightBlue: Class { "light-blue" }
    public static var cyan: Class { "cyan" }
    public static var teal: Class { "teal" }
    public static var green: Class { "green" }
    public static var lightGreen: Class { "light-green" }
    public static var lime: Class { "lime" }
    public static var yellow: Class { "yellow" }
    public static var amber: Class { "amber" }
    public static var orange: Class { "orange" }
    public static var deepOrange: Class { "deep-orange" }
    public static var brown: Class { "brown" }
    public static var grey: Class { "grey" }
    public static var blueGrey: Class { "blue-grey" }
    
    public static var black: Class { "black" }
    public static var white: Class { "white" }
    public static var transparent: Class { "transparent" }
    
    // MARK: Grid
    
    public static var container: Class { "container" }
    public static var row: Class { "row" }
    public static var col: Class { "col" }
    
    public enum ColumnSize: String {
        case one = "1"
        case two = "2"
        case three = "3"
        case four = "4"
        case five = "5"
        case six = "6"
        case seven = "7"
        case eight = "8"
        case nine = "9"
        case ten = "10"
        case eleven = "11"
        case twelve = "12"
    }
    
    public enum ScreenSize: String {
        case small = "s"
        case medium = "m"
        case large = "l"
        case extraLarge = "xl"
    }
    
    ///
    public static func column(_ screenSize: ScreenSize, _ size: ColumnSize) -> Class {
        .init(stringLiteral: "\(screenSize.rawValue)\(size.rawValue)")
    }
    
    /// The number of columns you want to offset by
    public static func columnOffset(_ screenSize: ScreenSize, _ size: ColumnSize) -> Class {
        .init(stringLiteral: "offset-\(screenSize.rawValue)\(size.rawValue)")
    }
    
    /// Changes the order of your columns.
    public static func columnPush(_ screenSize: ScreenSize, _ size: ColumnSize) -> Class {
        .init(stringLiteral: "push-\(screenSize.rawValue)\(size.rawValue)")
    }
    
    /// Changes the order of your columns.
    public static func columnPull(_ screenSize: ScreenSize, _ size: ColumnSize) -> Class {
        .init(stringLiteral: "pull-\(screenSize.rawValue)\(size.rawValue)")
    }
    
    /// The section class is used for simple top and bottom padding.
    /// Just add the section class to your div's containing large blocks of content.
    public static var section: Class { "section" }
    
    /// Dividers are 1 pixel lines that help break up your content.
    /// Just add the divider to a div in between your content.
    public static var divider: Class { "divider" }
    
    // MARK: Content align
    
    /// You can easily vertically center things by adding the class valign-wrapper
    /// to the container holding the items you want to vertically align.
    public static var valignWrapper: Class { "valign-wrapper" }
    
    // MARK: Text align
    
    public static var leftAlign: Class { "left-align" }
    public static var rightAlign: Class { "right-align" }
    public static var centerAlign: Class { "center-align" }
    
    // MARK: Floats
    
    public static var left: Class { "left" }
    public static var right: Class { "right" }
    public static var center: Class { "center" }
    
    // MARK: Hiding/Showing Content
    
    /// Hidden for all Devices
    public static var hide: Class { "hide" }
    
    /// Hidden for Mobile Only
    public static var hideOnSmallOnly: Class { "hide-on-small-only" }
    
    /// Hidden for Tablet Only
    public static var hideOnMedOnly: Class { "hide-on-med-only" }
    
    /// Hidden for Tablet and Below
    public static var hideOnMedAndDown: Class { "hide-on-med-and-down" }
    
    /// Hidden for Tablet and Above
    public static var hideOnMedAndUp: Class { "hide-on-med-and-up" }
    
    /// Hidden for Desktop Only
    public static var hideOnLargeOnly: Class { "hide-on-large-only" }
    
    /// Show for Mobile Only
    public static var showOnSmall: Class { "show-on-small" }
    
    /// Show for Tablet Only
    public static var showOnMedium: Class { "show-on-medium" }
    
    /// Show for Desktop Only
    public static var showOnLarge: Class { "show-on-large" }
    
    /// Show for Tablet and Above
    public static var showOnMediumAndUp: Class { "show-on-medium-and-up" }
    
    /// Show for Tablet and Below
    public static var showOnMediumAndDown: Class { "show-on-medium-and-down" }
    
    // MARK: - Formatting
    
    // MARK: Truncation
    
    /// Truncates long lines of text in an ellipsis.
    public static var truncate: Class { "truncate" }
    
    // MARK: Hover
    
    /// Adds an animation for box shadow.
    /// It can be used on most elements, but meant for use on cards.
    public static var hoverable: Class { "hoverable" }
    
    // MARK: Browser Defaults
    
    /// Reverts ul, select, input elements to their original state.
    public static var browserDefault: Class { "browser-default" }
    
    // MARK: - Images
    
    // MARK: Responsive Images
    
    /// Make images resize responsively to page width.
    /// It will now have a max-width: 100% and height:auto.
    public static var responsiveImg: Class { "responsive-img" }
    
    // MARK: Circular images
    
    /// Make images appear circular.
    public static var circle: Class { "circle" }
    
    // MARK: - Videos
    
    // MARK: Responsive Embeds
    
    /// Makes your embeds responsive.
    public static var videoContainer: Class { "video-container" }
    
    // MARK: Responsive Videos
    
    /// Make your HTML5 Videos responsive.
    public static var responsiveVideo: Class { "responsive-video" }
    
    // MARK: - Pulse
    
    /// Draws attention to your buttons with this subtle but captivating effect.
    ///
    /// Just add the class pulse to your button.
    ///
    /// Note: This is meant for floating buttons, so it may not work perfectly with every component.
    ///
    /// [Learn more](https://materializecss.com/pulse.html)
    public static var pulse: Class { "pulse" }
    
    // MARK: - Shadow
    
    public enum ZDepth: String {
        case one
        case two
        case three
        case four
        case five
    }
    
    /// Applies depth-shadow effect.
    ///
    /// [Learn more](https://materializecss.com/shadow.html)
    public static func zDepth(_ value: ZDepth) -> Class { .init(stringLiteral: "z-depth-\(value.rawValue)") }
    
    // MARK: - Table
    
    // MARK: Striped Table
    
    /// Striped table.
    public static var striped: Class { "striped" }
    
    // MARK: Highlight Table
    
    /// Highlight table.
    public static var highlight: Class { "highlight" }
    
    // MARK: Centered Table
    
    /// Centered table.
    public static var centered: Class { "centered" }
    
    // MARK: Responsive Table
    
    /// Makes the table horizontally scrollable on smaller screen widths.
    public static var responsiveTable: Class { "responsive-table" }
    
    // MARK: - CSS Transitions
    
    // MARK: Scale
    
    /// Base transition class.
    public static var scaleTransition: Class { "scale-transition" }
    
    /// Scales the element up until it is shown.
    public static var scaleIn: Class { "scale-in" }
    
    /// To start something as hidden. Scales the element down until it is hidden.
    public static var scaleOut: Class { "scale-out" }
    
    // MARK: - Typography
    
    // MARK: Flow Text
    
    /// Flows the text.
    public static var flowText: Class { "flow-text" }
    
    // MARK: - Badges
    
    public static var badge: Class { "badge" }
    public static var new: Class { "new" }
    
    // MARK: - Buttons
    
    public static var btn: Class { "btn" }
    public static var btnSmall: Class { "btn-small" }
    public static var btnLarge: Class { "btn-large" }
    public static var btnFlat: Class { "btn-flat" }
    public static var btnFloating: Class { "btn-floating" }
    public static var wavesEffect: Class { "waves-effect" }
    public static var wavesRipple: Class { "waves-ripple" }
    public static var wavesCircle: Class { "waves-circle" }
    public static var materialIcons: Class { "material-icons" }
    public static var disabled: Class { "disabled" }
    
    public static var fixedActionBtn: Class { "fixed-action-btn" }
    
    public static var tiny: Class { "tiny" }
    public static var small: Class { "small" }
    public static var medium: Class { "medium" }
    public static var large: Class { "large" }
    
    // MARK: - Footer
    
    public static var pageFooter: Class { "page-footer" }
}

extension BaseElement {
    /// Hidden for Mobile Only
    public func hideOnSmallOnly() -> Self {
        self.class(.hideOnSmallOnly)
    }
    
    /// Hidden for Tablet Only
    public func hideOnMedOnly() -> Self {
        self.class(.hideOnMedOnly)
    }
    
    /// Hidden for Tablet and Below
    public func hideOnMedAndDown() -> Self {
        self.class(.hideOnMedAndDown)
    }
    
    /// Hidden for Tablet and Above
    public func hideOnMedAndUp() -> Self {
        self.class(.hideOnMedAndUp)
    }
    
    /// Hidden for Desktop Only
    public func hideOnLargeOnly() -> Self {
        self.class(.hideOnLargeOnly)
    }
    
    /// Show for Mobile Only
    public func showOnSmall() -> Self {
        self.class(.showOnSmall)
    }
    
    /// Show for Tablet Only
    public func showOnMedium() -> Self {
        self.class(.showOnMedium)
    }
    
    /// Show for Desktop Only
    public func showOnLarge() -> Self {
        self.class(.showOnLarge)
    }
    
    /// Show for Tablet and Above
    public func showOnMediumAndUp() -> Self {
        self.class(.showOnMediumAndUp)
    }
    
    /// Show for Tablet and Below
    public func showOnMediumAndDown() -> Self {
        self.class(.showOnMediumAndDown)
    }
    
    /// Pins element
    public func pinned() -> Self {
        self.class("pinned")
    }
}
