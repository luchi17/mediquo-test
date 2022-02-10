//
//  NativeObservable.swift
//  MediquoTest
//
//  Created by Mariluz Parejo on 25/1/22.
//

import Foundation

class ObservableObject<T> {
    
    private let queue: DispatchQueue
    var observe: ((T) -> ())?
    
    var value: T? {
        didSet {
            if let property = self.value {
                queue.async {
                    self.observe?(property)
                }
            }
        }
    }
    
    init(_ value: T? = nil, queue: DispatchQueue = DispatchQueue.main) {
        self.queue = queue
        self.value = value
    }
}
