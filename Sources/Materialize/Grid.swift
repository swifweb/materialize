//
//  Grid.swift
//  
//
//  Created by Mihael Isaev on 05.03.2023.
//

import Web

/// [[▶︎▶︎▶︎LEARN MORE IN THE DOCS ◀︎◀︎◀︎]](https://materializecss.com/grid.html)
public class Row: BaseContentElement {
    open class override var name: String { "\(Div.self)".lowercased() }
    
    public override func postInit() {
        super.postInit()
        self.class(.row)
    }
}

/// [[▶︎▶︎▶︎LEARN MORE IN THE DOCS ◀︎◀︎◀︎]](https://materializecss.com/grid.html)
public class Column: BaseContentElement {
    open class override var name: String { "\(Div.self)".lowercased() }
    
    public struct Size {
        let size: String
        let width, offset, pull, push: Width?
        
        init (size: String, width: Width? = nil, offset: Width? = nil, pull: Width? = nil, push: Width? = nil) {
            self.size = size
            self.width = width
            self.offset = offset
            self.pull = pull
            self.push = push
        }
        
        public static func small(_ width: Width, offset: Width? = nil, pull: Width? = nil, push: Width? = nil) -> Self {
            .init(size: "s", width: width, offset: offset, pull: pull, push: push)
        }
        
        public static func small(offset: Width? = nil, pull: Width? = nil, push: Width? = nil) -> Self {
            .init(size: "s", width: nil, offset: offset, pull: pull, push: push)
        }
        
        public static func medium(_ width: Width, offset: Width? = nil, pull: Width? = nil, push: Width? = nil) -> Self {
            .init(size: "m", width: width, offset: offset, pull: pull, push: push)
        }
        
        public static func medium(offset: Width? = nil, pull: Width? = nil, push: Width? = nil) -> Self {
            .init(size: "m", width: nil, offset: offset, pull: pull, push: push)
        }
        
        public static func large(_ width: Width, offset: Width? = nil, pull: Width? = nil, push: Width? = nil) -> Self {
            .init(size: "l", width: width, offset: offset, pull: pull, push: push)
        }
        
        public static func large(offset: Width? = nil, pull: Width? = nil, push: Width? = nil) -> Self {
            .init(size: "l", width: nil, offset: offset, pull: pull, push: push)
        }
        
        public static func extraLarge(_ width: Width, offset: Width? = nil, pull: Width? = nil, push: Width? = nil) -> Self {
            .init(size: "xl", width: width, offset: offset, pull: pull, push: push)
        }
        
        public static func extraLarge(offset: Width? = nil, pull: Width? = nil, push: Width? = nil) -> Self {
            .init(size: "xl", width: nil, offset: offset, pull: pull, push: push)
        }
        
        public enum Width: String {
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
        
        var classes: [Class] {
            var array: [Class] = []
            if let width = width {
                array.append(.init(stringLiteral: "\(size)\(width.rawValue)"))
            }
            if let offset = offset {
                array.append(.init(stringLiteral: "offset-\(size)\(offset.rawValue)"))
            }
            if let pull = pull {
                array.append(.init(stringLiteral: "pull-\(size)\(pull.rawValue)"))
            }
            if let push = push {
                array.append(.init(stringLiteral: "push-\(size)\(push.rawValue)"))
            }
            return array
        }
    }
    
    let sizes: [Size]
    
    public init(_ sizes: Size...) {
        self.sizes = sizes
        super.init()
    }
    
    public init(_ sizes: Size..., @DOM content: @escaping DOM.Block) {
        self.sizes = sizes
        super.init()
        self.body(content: content)
    }
    
    required init() {
        self.sizes = []
        super.init()
    }
    
    public override func postInit() {
        super.postInit()
        self.class(.col)
        for size in sizes {
            self.class(size.classes)
        }
    }
    
    @discardableResult
    public func sizes(_ sizes: Size...) -> Self {
        for size in sizes {
            self.class(size.classes)
        }
        return self
    }
}
