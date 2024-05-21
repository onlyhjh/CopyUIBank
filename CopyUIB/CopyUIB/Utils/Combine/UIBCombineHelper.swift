//
//  Helper.swift
//  IOS_CleanArchitecture_Sample
//
//  Created by 60156664 on 15/02/2022.
//

import SwiftUI
import Combine
import Foundation

// MARK: - Combine Helpers

// Should have called it "CVS Store"
public typealias Store<State> = CurrentValueSubject<State, Never>

public
class CancelBag {
    var subscriptions = Set<AnyCancellable>()
    
    // 해제코드
    public func disposeAll(){
        subscriptions.forEach { cancel in
            cancel.cancel()
        }
    }
    
    public init() {}
}

public
extension AnyCancellable {
    static var cancelled: AnyCancellable {
        let cancellable = AnyCancellable({ })
        cancellable.cancel()
        return cancellable
    }
    
    func store(in cancelBag: CancelBag) {
        cancelBag.subscriptions.insert(self)
    }
}

public
extension Publisher {
    func sinkToResult(_ result: @escaping (Result<Output, Failure>) -> Void) -> AnyCancellable {
        return sink(receiveCompletion: { completion in
            switch completion {
            case let .failure(error):
                result(.failure(error))
            default: break
            }
        }, receiveValue: { value in
            result(.success(value))
        })
    }
    
    func sinkToLoadable(_ completion: @escaping (Loadable<Output>) -> Void) -> AnyCancellable {
        return sink(receiveCompletion: { subscriptionCompletion in
            if let error = subscriptionCompletion.error {
                completion(.failed(error))
            }
        }, receiveValue: { value in
            completion(.loaded(value))
        })
    }
    
    func extractUnderlyingError() -> Publishers.MapError<Self, Failure> {
        mapError {
            (($0 as NSError).userInfo[NSUnderlyingErrorKey] as? Failure) ?? $0
        }
    }
}

public
extension CurrentValueSubject {
    
    subscript<T>(keyPath: WritableKeyPath<Output, T>) -> T where T: Equatable {
        get { value[keyPath: keyPath] }
        set {
            var value = self.value
            if value[keyPath: keyPath] != newValue {
                value[keyPath: keyPath] = newValue
                self.value = value
            }
        }
    }
    
    func bulkUpdate(_ update: (inout Output) -> Void) {
        var value = self.value
        update(&value)
        self.value = value
    }
    
    func updates<Value>(for keyPath: KeyPath<Output, Value>) ->
        AnyPublisher<Value, Failure> where Value: Equatable {
        return map(keyPath).removeDuplicates().eraseToAnyPublisher()
    }
}

public
extension Subscribers.Completion {
    var error: Failure? {
        switch self {
        case let .failure(error): return error
        default: return nil
        }
    }
}

// MARK: - SwiftUI Helpers

public
extension Binding where Value: Equatable {
    func dispatched<State>(to state: Store<State>,
                           _ keyPath: WritableKeyPath<State, Value>) -> Self {
        return .init(get: { () -> Value in
            self.wrappedValue
        }, set: { value in
            self.wrappedValue = value
            state[keyPath] = value
        })
    }
}

// MARK: - General

public
extension ProcessInfo {
    var isRunningTests: Bool {
        environment["XCTestConfigurationFilePath"] != nil
    }
}
