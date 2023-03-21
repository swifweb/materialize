//
//  MaterialButton.swift
//  
//
//  Created by Mihael Isaev on 16.03.2023.
//

import Web

extension BaseContentElement {
    public enum ButtonType {
        case raised, floating, floatingHalfWay, flat
    }
    
    public enum ButtonSize {
        case small, large
        
        func map<T>(_ handler: (Self) -> T) -> T {
            handler(self)
        }
    }
    
    @discardableResult
    public func materialButton(
        type: ButtonType = .raised,
        size: ButtonSize? = nil,
        waves: MaterialWaves = .light,
        disabled: Bool = false
    ) -> Self {
        materialButton(type: type, size: size, waves: waves, disabled: State(wrappedValue: disabled))
    }
    
    @discardableResult
    public func materialButton<D>(
        type: ButtonType = .raised,
        size: ButtonSize? = nil,
        waves: MaterialWaves = .light,
        disabled: D
    ) -> Self where D: StateConvertible, D.Value == Bool {
        var classes: [Class] = waves.classes
        switch type {
        case .raised: break
        case .floating: classes.append(.btnFloating)
        case .floatingHalfWay: classes.append(contentsOf: [.btnFloating, .init(stringLiteral: "halfway-fab")])
        case .flat: classes.append(.btnFlat)
        }
        if let size = size {
            switch size {
            case .small: classes.append(.btnSmall)
            case .large: classes.append(.btnLarge)
            }
        } else {
            classes.append(.btn)
        }
        func applyDisabled(_ disabled: Bool) {
            if disabled {
                self.class(.disabled)
            } else {
                self.removeClass(.disabled)
            }
        }
        applyDisabled(disabled.stateValue.wrappedValue)
        disabled.stateValue.listen(applyDisabled)
        self.class(classes)
        Materialize.setupWaves()
        return self
    }
    
    @discardableResult
    public func addMaterialIcon(_ icon: MaterialIcon) -> Self {
        self.appendChild(icon)
        return self
    }
}
