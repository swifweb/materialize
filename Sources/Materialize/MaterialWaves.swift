//
//  MaterialWaves.swift
//  
//
//  Created by Mihael Isaev on 15.03.2023.
//

import Web

extension BaseContentElement {
    public struct MaterialWaves {
        var classes: [Class]
    
        init(regular: String) {
            self.classes = [.wavesEffect, Class(regular)]
        }
        
        init (custom: String) {
            self.classes = [.wavesEffect, Class(custom), .wavesRipple]
        }
        
        public static var light: Self { .init(regular: "waves-light") }
        public static var red: Self { .init(regular: "waves-red") }
        public static var yellow: Self { .init(regular: "waves-yellow") }
        public static var orange: Self { .init(regular: "waves-orange") }
        public static var purple: Self { .init(regular: "waves-purple") }
        public static var green: Self { .init(regular: "waves-green") }
        public static var teal: Self { .init(regular: "waves-teal") }
        
        public static func custom(_ name: String) -> Self { .init(custom: name) }
        
        public mutating func circle() -> Self {
            self.classes.append(.wavesCircle)
            return self
        }
    }
    
    func waves(_ waves: MaterialWaves? = nil) {
        if let waves = waves {
            self.class(waves.classes)
        } else {
            self.class(.wavesEffect)
        }
    }
}
