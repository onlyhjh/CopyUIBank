//
//  MainContainerViewModel.swift
//  CopyUIBank
//
//  Created by 60192229 on 5/3/24.
//

import Foundation
import SwiftUI

enum HomeTabIndex: Int {
    case home = 0
    case product = 1
    case column = 2
    case menu = 3
}

enum AppLaunchState {
    case launching // call lauching api
    case permisson // permisson access screen
    case term // term and condition screen
    case home // home without login
}

class MainContainerViewModel: ObservableObject {
    
    private var useCase: MainContinerUseCaseProtocol = MainContinerUseCase()
    private var count = 0
    
    private let cancelBag = CancelBag()
    
    @Published var state: AppLaunchState = .launching
    
    init() {
        self.doLaunchInfoAsync()
    }

    func incrementCounter() {
        count += 1
        objectWillChange.send()
    }
    
    func doLaunchInfoAsync() {
        useCase.getLaunchInfo()
            .sinkToResult { result in
                switch result {
                case .failure(let error):
                    print("error: \(error)")
                case .success(let res):
                    print("success response: \(res)")
                    self.state = .home
                   
//                    if let alertVM = AppEnvironmentSingleton.shared.appEnvironment?.container.alertVM {
//                        print("is Show 1: \(alertVM.isShow)")
//                        alertVM.isShow.toggle()
//                        print("is Show 2: \(alertVM.isShow)")
//                    }
//                    else {
//                        print("environment is not found")
//                    }
                }
                self.cancelBag.disposeAll()
            }
            .store(in: cancelBag)
    }
    
    func doLaunch() {
        Task {
            do {
                let response = try await doLaunchInfo()
                print("response: \(response)")
            }
            catch {
                errorHandle(error: error)
            }
        }
        
    }
    
    private func doLaunchInfo() async throws -> UIBLaunchData? {
        UIBLog.log("")
        do {
            return try await withCheckedThrowingContinuation { continuation in
                let tokenId = ""
                useCase.getLaunchInfo()
                    .sinkToResult { result in
                        switch result {
                        case .failure(let error):
                            continuation.resume(throwing: error)
                            // combine 메모리 해제, 동시에 여러군데서 멀티로 이용하면 아래 cancelBag 객체를 별도로 store해야 함
                            self.cancelBag.disposeAll()
                        case .success(let res):
                            self.cancelBag.disposeAll()
                            continuation.resume(returning: res)
                        }
                    }
                    .store(in: cancelBag)
            }
        } catch {
            UIBLog.log("error = \(error)", logType: .Error)
            self.cancelBag.disposeAll()
            throw error
        }
    }
    
    func didSelectedTab(index: HomeTabIndex, completion: ((Any?, Error?) -> Void)? = nil) {
//        switch index {
//        case .home:
//            // Show home
//            RouteUtility.moveToHome(animation: false)
//        case .product:
//            // Move product
//            RouteUtility.move(code: UIBConstants.MenuCode.homeProduct, clearHistory: true, animatedTransitions: false)
//        case .column:
//            // Move financial Info
//            RouteUtility.move(code: UIBConstants.MenuCode.homeColumn, clearHistory: true, animatedTransitions: false)
//        case .menu:
//            // Show menu
//            print("Menu screen ")
//            let menuItem = HybridStackItem(code: UIBConstants.MenuCode.otherMenu, type: .native, src:  OtherMenuScreen.id, animatedTransitions: false)
//            RouteUtility.move(item: menuItem, clearHistory: true, animatedTransitions: false)
//        }
    }
    
    func errorHandle(error: Error) {
        if let error = error as? APIError {
            switch error {
            case .headerMessage( let errorModel, let errorCode):
                print("error with headerMessage errorModel: \(errorModel), errorCode: \(errorCode)")
            case .networkConnectionError:
                print("networkConnectionError error: \(error.localizedDescription)")
            default:
                print("unkown api error: \(error.localizedDescription)")
            }
        }
        else {
            print("unkown error")
        }
    }
    
    
}
