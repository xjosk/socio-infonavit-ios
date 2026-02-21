//
//  AsyncDataState.swift
//  socioinfonavit
//
//  Created by Andrei Carvajal on 19/02/26.
//


enum AsyncDataState<T: Hashable> : Hashable {
    case idle
    case loading
    case success(T)
    case failure(String)
    
    var value: T? {
        if case .success(let data) = self {
            return data
        }
        return nil
    }
    
    var failureMessage: String? {
        if case .failure(let string) = self {
            return string
        }
        
        return nil
    }
}
