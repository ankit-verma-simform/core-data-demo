//
//  Dynamic.swift
//  CoreDataDemo
//
//  Created by Ankit Verma on 27/07/23.
//

class Dynamic<T> {

    // MARK: - Typealias

    typealias Listener = (T) -> Void

    // MARK: - Variable

    var listener: Listener?
    var value: T {
        didSet {
            fire()
        }
    }

    // MARK: - Initializer

    init(_ value: T) {
        self.value = value
    }

    // MARK: - Functions

    func bind(_ listener: Listener?) {
        self.listener = listener
    }

    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }

    func fire() {
        listener?(value)
    }
}
