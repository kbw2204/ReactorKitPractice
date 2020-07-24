//
//  ViewReactor.swift
//  ReactorKitStartKit
//
//  Created by 강병우 on 2020/07/24.
//  Copyright © 2020 강병우. All rights reserved.
//

import ReactorKit
import RxSwift

// ViewModel
class ViewReactor: Reactor {
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        
    }
    
    let initialState: State = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        return newState
    }
}
