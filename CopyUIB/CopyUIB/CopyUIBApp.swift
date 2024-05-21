//
//  CopyUIBApp.swift
//  CopyUIB
//
//  Created by 60192229 on 5/16/24.
//

import SwiftUI

@main
struct CopyUIBApp: App {
    
    private var appContainer: AppContainer?

    init() {
        let appEnvironment = AppEnvironmentSingleton.shared.appEnvironment
        appContainer = appEnvironment?.container

    }
    
    var body: some Scene {
        WindowGroup {
            MainContainerScreen()
                .environment(\.appContainer, appContainer!)
        }
    }
}

