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

public class MaterialColorWithModifier: MaterialColor {
    fileprivate init (_ classes: [Class], _ modifier: ColorModifier) {
        super.init(classes + [.init(stringLiteral: modifier.rawValue)])
    }
}

public class MaterialColor {
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
    
    fileprivate init (_ classes: [Class]) {
        self.classes = classes
    }
    
    private init (_ class: Class) {
        self.classes = [`class`]
    }
    
    public var lighten1: MaterialColorWithModifier { .init(classes, .lighten1) }
    public var lighten2: MaterialColorWithModifier { .init(classes, .lighten2) }
    public var lighten3: MaterialColorWithModifier { .init(classes, .lighten3) }
    public var lighten4: MaterialColorWithModifier { .init(classes, .lighten4) }
    public var lighten5: MaterialColorWithModifier { .init(classes, .lighten5) }
    public var darken1: MaterialColorWithModifier { .init(classes, .darken1) }
    public var darken2: MaterialColorWithModifier { .init(classes, .darken2) }
    public var darken3: MaterialColorWithModifier { .init(classes, .darken3) }
    public var darken4: MaterialColorWithModifier { .init(classes, .darken4) }
    public var darken5: MaterialColorWithModifier { .init(classes, .darken5) }
    
    /// Materialize Red color
    public static var red: MaterialColor { .init(.red) }
    
    /// Materialize Pink color
    public static var pink: MaterialColor { .init(.pink) }
    
    /// Materialize Purple color
    public static var purple: MaterialColor { .init(.purple) }
    
    /// Materialize Deep-Purple color
    public static var deepPurple: MaterialColor { .init(.deepPurple) }
    
    /// Materialize Indigo color
    public static var indigo: MaterialColor { .init(.indigo) }
    
    /// Materialize Blue color
    public static var blue: MaterialColor { .init(.blue) }
    
    /// Materialize Light-Blue color
    public static var lightBlue: MaterialColor { .init(.lightBlue) }
    
    /// Materialize Cyan color
    public static var cyan: MaterialColor { .init(.cyan) }
    
    /// /// Materialize Teal color
    public static var teal: MaterialColor { .init(.teal) }
    
    /// Materialize Green color
    public static var green: MaterialColor { .init(.green) }
    
    /// Materialize Light-Green color
    public static var lightGreen: MaterialColor { .init(.lightGreen) }
    
    /// Materialize Lime color
    public static var lime: MaterialColor { .init(.lime) }
    
    /// Materialize Yellow color
    public static var yellow: MaterialColor { .init(.yellow) }
    
    /// Materialize Amber color
    public static var amber: MaterialColor { .init(.amber) }
    
    /// Materialize Orange color
    public static var orange: MaterialColor { .init(.orange) }
    
    /// Materialize Deep-Orange color
    public static var deepOrange: MaterialColor { .init(.deepOrange) }
    
    /// Materialize Brown color
    public static var brown: MaterialColor { .init(.brown) }
    
    /// Materialize Grey color
    public static var grey: MaterialColor { .init(.grey) }
    
    /// Materialize Blue-Grey color
    public static var blueGrey: MaterialColor { .init(.blueGrey) }
    
    /// Materialize Black color
    public static var black: MaterialColor { .init(.black) }
    
    /// Materialize White color
    public static var white: MaterialColor { .init(.white) }
    
    /// Materialize Transparent color
    public static var transparent: MaterialColor { .init(.transparent) }
}
