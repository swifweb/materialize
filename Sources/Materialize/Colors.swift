//
//  Colors.swift
//  
//
//  Created by Mihael Isaev on 05.03.2023.
//

import Web

extension BaseElement {
    private func _color(_ colorClass: Class, _ modifier: MaterialColor.ColorModifier? = nil) -> Self {
        self.class(colorClass)
        if let modifier = modifier {
            self.class(.init(stringLiteral: modifier.rawValue))
        }
        return self
    }
    
    /// Adds materialize text color class
    @discardableResult
    public func textColor(_ color: MaterialColor) -> Self {
        let names: [String] = color.classes.map { $0.names }.flatMap { $0 }
        for name in names {
            if name.contains("darken") || name.contains("lighten") {
                self.class(.init(stringLiteral: "text-\(name)"))
            } else {
                self.class(.init(stringLiteral: "\(name)-text"))
            }
        }
        return self
    }
    
    /// Adds materialize background color class
    @discardableResult
    public func materialBackground(_ color: MaterialColor) -> Self {
        self.class(color.classes)
    }
    
    /// Materialize Red color
    @discardableResult
    public func red(_ modifier: MaterialColor.ColorModifier? = nil) -> Self {
        _color(.red, modifier)
    }
    
    /// Materialize Pink color
    public func pink(_ modifier: MaterialColor.ColorModifier? = nil) -> Self {
        _color(.pink, modifier)
    }
    
    /// Materialize Purple color
    public func purple(_ modifier: MaterialColor.ColorModifier? = nil) -> Self {
        _color(.purple, modifier)
    }
    
    /// Materialize Deep-Purple color
    public func deepPurple(_ modifier: MaterialColor.ColorModifier? = nil) -> Self {
        _color(.deepPurple, modifier)
    }
    
    /// Materialize Indigo color
    public func indigo(_ modifier: MaterialColor.ColorModifier? = nil) -> Self {
        _color(.indigo, modifier)
    }
    
    /// Materialize Blue color
    public func blue(_ modifier: MaterialColor.ColorModifier? = nil) -> Self {
        _color(.blue, modifier)
    }
    
    /// Materialize Light-Blue color
    public func lightBlue(_ modifier: MaterialColor.ColorModifier? = nil) -> Self {
        _color(.lightBlue, modifier)
    }
    
    /// Materialize Cyan color
    public func cyan(_ modifier: MaterialColor.ColorModifier? = nil) -> Self {
        _color(.cyan, modifier)
    }
    
    /// Materialize Teal color
    public func teal(_ modifier: MaterialColor.ColorModifier? = nil) -> Self {
        _color(.teal, modifier)
    }
    
    /// Materialize Green color
    public func green(_ modifier: MaterialColor.ColorModifier? = nil) -> Self {
        _color(.green, modifier)
    }
    
    /// Materialize Light-Green color
    public func lightGreen(_ modifier: MaterialColor.ColorModifier? = nil) -> Self {
        _color(.lightGreen, modifier)
    }
    
    /// Materialize Lime color
    public func lime(_ modifier: MaterialColor.ColorModifier? = nil) -> Self {
        _color(.lime, modifier)
    }
    
    /// Materialize Yellow color
    public func yellow(_ modifier: MaterialColor.ColorModifier? = nil) -> Self {
        _color(.yellow, modifier)
    }
    
    /// Materialize Amber color
    public func amber(_ modifier: MaterialColor.ColorModifier? = nil) -> Self {
        _color(.amber, modifier)
    }
    
    /// Materialize Orange color
    public func orange(_ modifier: MaterialColor.ColorModifier? = nil) -> Self {
        _color(.orange, modifier)
    }
    
    /// Materialize Deep-Orange color
    public func deepOrange(_ modifier: MaterialColor.ColorModifier? = nil) -> Self {
        _color(.deepOrange, modifier)
    }
    
    /// Materialize Brown color
    public func brown(_ modifier: MaterialColor.ColorModifier? = nil) -> Self {
        _color(.brown, modifier)
    }
    
    /// Materialize Grey color
    public func grey(_ modifier: MaterialColor.ColorModifier? = nil) -> Self {
        _color(.grey, modifier)
    }
    
    /// Materialize Blue-Grey color
    public func blueGrey(_ modifier: MaterialColor.ColorModifier? = nil) -> Self {
        _color(.blueGrey, modifier)
    }
    
    /// Materialize Black color
    public func black() -> Self {
        _color(.black, nil)
    }
    
    /// Materialize White color
    public func white() -> Self {
        _color(.white, nil)
    }
    
    /// Materialize Transparent color
    public func transparent() -> Self {
        _color(.transparent, nil)
    }
}

public struct MaterialColor {
    let classes: [Class]
    
    public enum ColorModifier: String {
        case lighten1 = "lighten-1"
        case lighten2 = "lighten-2"
        case lighten3 = "lighten-3"
        case lighten4 = "lighten-4"
        case lighten5 = "lighten-5"
        case darken1 = "darken-1"
        case darken2 = "darken-2"
        case darken3 = "darken-3"
        case darken4 = "darken-4"
        case darken5 = "darken-5"
    }
    
    private init (_ class: Class, _ modifier: ColorModifier?) {
        var classes: [Class] = [`class`]
        if let modifier = modifier {
            classes.append(.init(stringLiteral: modifier.rawValue))
        }
        self.classes = classes
    }
    
    /// Materialize Red color
    public static var red: Self {
        .init(.red, nil)
    }
    
    /// Materialize Red color
    @discardableResult
    public static func red(_ modifier: ColorModifier) -> Self {
        .init(.red, modifier)
    }
    
    /// Materialize Pink color
    public static var pink: Self {
        .init(.pink, nil)
    }
    
    /// Materialize Pink color
    public static func pink(_ modifier: ColorModifier) -> Self {
        .init(.pink, modifier)
    }
    
    /// Materialize Purple color
    public static var purple: Self {
        .init(.purple, nil)
    }
    
    /// Materialize Purple color
    public static func purple(_ modifier: ColorModifier) -> Self {
        .init(.purple, modifier)
    }
    
    /// Materialize Deep-Purple color
    public static var deepPurple: Self {
        .init(.deepPurple, nil)
    }
    
    /// Materialize Deep-Purple color
    public static func deepPurple(_ modifier: ColorModifier) -> Self {
        .init(.deepPurple, modifier)
    }
    
    /// Materialize Indigo color
    public static var indigo: Self {
        .init(.indigo, nil)
    }
    
    /// Materialize Indigo color
    public static func indigo(_ modifier: ColorModifier) -> Self {
        .init(.indigo, modifier)
    }
    
    /// Materialize Blue color
    public static var blue: Self {
        .init(.blue, nil)
    }
    
    /// Materialize Blue color
    public static func blue(_ modifier: ColorModifier) -> Self {
        .init(.blue, modifier)
    }
    
    /// Materialize Light-Blue color
    public static var lightBlue: Self {
        .init(.lightBlue, nil)
    }
    
    /// Materialize Light-Blue color
    public static func lightBlue(_ modifier: ColorModifier) -> Self {
        .init(.lightBlue, modifier)
    }
    
    /// Materialize Cyan color
    public static var cyan: Self {
        .init(.cyan, nil)
    }
    
    /// Materialize Cyan color
    public static func cyan(_ modifier: ColorModifier) -> Self {
        .init(.cyan, modifier)
    }
    
    /// /// Materialize Teal color
    public static var teal: Self {
        .init(.teal, nil)
    }
    
    /// Materialize Teal color
    public static func teal(_ modifier: ColorModifier) -> Self {
        .init(.teal, modifier)
    }
    
    /// Materialize Green color
    public static var green: Self {
        .init(.green, nil)
    }
    
    /// Materialize Green color
    public static func green(_ modifier: ColorModifier) -> Self {
        .init(.green, modifier)
    }
    
    /// Materialize Light-Green color
    public static var lightGreen: Self {
        .init(.lightGreen, nil)
    }
    
    /// Materialize Light-Green color
    public static func lightGreen(_ modifier: ColorModifier) -> Self {
        .init(.lightGreen, modifier)
    }
    
    /// Materialize Lime color
    public static var lime: Self {
        .init(.lime, nil)
    }
    /// Materialize Lime color
    public static func lime(_ modifier: ColorModifier) -> Self {
        .init(.lime, modifier)
    }
    
    /// Materialize Yellow color
    public static var yellow: Self {
        .init(.yellow, nil)
    }
    
    /// Materialize Yellow color
    public static func yellow(_ modifier: ColorModifier) -> Self {
        .init(.yellow, modifier)
    }
    
    /// Materialize Amber color
    public static var amber: Self {
        .init(.amber, nil)
    }
    
    /// Materialize Amber color
    public static func amber(_ modifier: ColorModifier) -> Self {
        .init(.amber, modifier)
    }
    
    /// Materialize Orange color
    public static var orange: Self {
        .init(.orange, nil)
    }
    
    /// Materialize Orange color
    public static func orange(_ modifier: ColorModifier) -> Self {
        .init(.orange, modifier)
    }
    
    /// Materialize Deep-Orange color
    public static var deepOrange: Self {
        .init(.deepOrange, nil)
    }
    
    /// Materialize Deep-Orange color
    public static func deepOrange(_ modifier: ColorModifier) -> Self {
        .init(.deepOrange, modifier)
    }
    
    /// Materialize Brown color
    public static var brown: Self {
        .init(.brown, nil)
    }
    
    /// Materialize Brown color
    public static func brown(_ modifier: ColorModifier) -> Self {
        .init(.brown, modifier)
    }
    
    /// Materialize Grey color
    public static var grey: Self {
        .init(.grey, nil)
    }
    
    /// Materialize Grey color
    public static func grey(_ modifier: ColorModifier) -> Self {
        .init(.grey, modifier)
    }
    
    /// Materialize Blue-Grey color
    public static var blueGrey: Self {
        .init(.blueGrey, nil)
    }
    
    /// Materialize Blue-Grey color
    public static func blueGrey(_ modifier: ColorModifier) -> Self {
        .init(.blueGrey, modifier)
    }
    
    /// Materialize Black color
    public static var black: Self {
        .init(.black, nil)
    }
    
    /// Materialize White color
    public static var white: Self {
        .init(.white, nil)
    }
    
    /// Materialize Transparent color
    public static var transparent: Self {
        .init(.transparent, nil)
    }
}
