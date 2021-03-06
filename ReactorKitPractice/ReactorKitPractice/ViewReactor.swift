//
//  ViewReactor.swift
//  ReactorKitPractice
//
//  Created by 강병우 on 2020/07/06.
//  Copyright © 2020 강병우. All rights reserved.
//

import ReactorKit
import RxSwift

// ViewModel
class ViewReactor: Reactor {
    enum Action {
        case increase
        case decrease
        case showAlertAction
    }
    
    enum Mutation {
        case increaseValue
        case decreaseValue
        case setLoading(Bool)
        case alertButtonTapped(Void?)
    }
    
    struct State {
        var value: Int = 0
        var isLoading: Bool = false
        var isAlertShow: Void?
    }
    
    let initialState: State = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .decrease:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                Observable.just(Mutation.decreaseValue)
                    .delay(1, scheduler: MainScheduler.instance),
                Observable.just(Mutation.setLoading(false))
            ])
            
        case .increase:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                Observable.just(Mutation.increaseValue)
                    .delay(1, scheduler: MainScheduler.instance),
                Observable.just(Mutation.setLoading(false))
            ])
            
        case .showAlertAction:
            return Observable.concat([
                Observable.just(Mutation.alertButtonTapped(Void())),
                Observable.just(Mutation.alertButtonTapped(nil))
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .decreaseValue:
            newState.value -= 1
        case .increaseValue:
            newState.value += 1
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
        case .alertButtonTapped(let void):
            newState.isAlertShow = void
        }
        
        return newState
    }
}
