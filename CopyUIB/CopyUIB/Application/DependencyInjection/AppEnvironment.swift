//
//  AppEnvironment.swift
//  CopyUIB
//
//  Created by 60192229 on 5/20/24.
//

import SwiftUI
import Combine

// AppEnvironmentSingleton.shard > appEnvironment > appState >
class AppEnvironmentSingleton {
    static let shared = AppEnvironmentSingleton()
    var appEnvironment: AppEnvironment?
    
    init() {
        self.appEnvironment = self.initializeit()
    }
    
    private func initializeit()-> AppEnvironment {
        let appState = Store<AppState>(AppState())
        let navigationStack = NavigationStackCompat()

        let appContainer = AppContainer(appState: appState, navigationStack: navigationStack)

        return AppEnvironment(container: appContainer)
    }
}

class AppEnvironment {
    var container: AppContainer
    
    init(container: AppContainer) {
        self.container = container
    }
}


struct AppState {
    struct LaunchData: Equatable {
        var myMenuListTemp: [UIBMenuInfo]?
        //var productList: UIBGetProductResponseData?
        var lastNoticeDate: String?
        var fraudAlertSessionId: String?
        var homeBannerList: [UIBHomeBannerInfo]?
        var promotionList: [UIBHomeBannerInfo]?
    }
    
    struct UserData : Equatable {
        var isLoggedin: Bool = false
//        var loginInfo: UIBLoginInfo?
//        var customAccList: [UIBCusAcnoInfo]?
//        var quickTransferList: [UIBQuickTransferInfo]?
//        var typeAccountInfo: UIBTypeAccountInfo?
        var tranferFeeFreeCount: Int?
        var atmFeeFreeCount: Int?
        var uiPlusGrade: Int?

        public var userId: String?
        public var sessionId: String?
        public var loginType: LoginType =  .idPassword
    }
}

struct AppContainerKey: EnvironmentKey {
    static var defaultValue: AppContainer = AppContainer(appState: CurrentValueSubject<AppState, Never>(AppState()) , navigationStack: NavigationStackCompat())
    let alertVM = AlertViewModel()
}

