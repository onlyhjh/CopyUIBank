//
//  AppContainer.swift
//  CopyUIB
//
//  Created by 60192229 on 5/20/24.
//

import Combine
import SwiftUI


struct AppContainer {
    
    let appState: CurrentValueSubject<AppState, Never>
    let navigationStack: NavigationStackCompat
    let hybridStackManager: HybridStackManager = HybridStackManager()
    
    let alertVM = AlertViewModel()
}

// @Environment 2 환경변수 추가
extension EnvironmentValues {
    
    var appContainer: AppContainer {
        get { self[AppContainerKey.self] }
        set { self[AppContainerKey.self] = newValue }
    }
}


class HybridStackManager: ObservableObject {
    @Published var stack: [Int] = []
}
