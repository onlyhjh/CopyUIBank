//
//  MainContainerViewModel.swift
//  CopyUIBank
//
//  Created by 60192229 on 5/3/24.
//

import Foundation

enum HomeTabIndex: Int {
    case home = 0
    case product
    case column
    case menu
}

class MainContainerViewModel: ObservableObject {
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
}
