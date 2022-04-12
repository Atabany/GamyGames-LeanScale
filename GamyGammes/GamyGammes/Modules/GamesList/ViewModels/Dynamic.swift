//
//  Dynamic.swift
//  GamyGammes
//
//  Created by Mohamed Elatabany on 12/04/2022.
//

import Foundation
class Dynamic<T> {
    
    typealias Listener = (T) -> Void
    
    private var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    
    func bind(_ callBack: @escaping Listener) {
        self.listener = callBack
    }
    
}

