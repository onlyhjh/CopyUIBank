//
//  MainContainerScreen.swift
//  CopyUIBank
//
//  Created by 60192229 on 5/3/24.
//

import SwiftUI


struct AppContainer: EnvironmentKey {
    static var defaultValue: Self { Self() }
    
    let alertSheetVM = AlertSheetViewModel()
}

extension EnvironmentValues {
    var injected: AppContainer {
        get { self[AppContainer.self] }
        set { self[AppContainer.self] = newValue }
    }
}


// @Environment 1 환경 변수의 값 설정 (must)
struct CountKey: EnvironmentKey {
    static var defaultValue: Int = 200
}
// @Environment 2 환경변수 추가
extension EnvironmentValues {
    var customerCount: Int {
        get { self [CountKey.self] }
        set {
            self [CountKey.self] = newValue
        }
    }
}

enum HybridOffset {
    case right
    case left
    case center
    
    var offset: CGFloat {
        switch self {
        case .right:
            return UIScreen.main.bounds.width
        case .left:
            return -UIScreen.main.bounds.width
        case .center:
            return 0
        }
    }
}

enum Menu: String {
    case home = "home"
    case naver = "naver"
    case daum = "daum"
    case other = "other"
}

struct MainContainerScreen: View {
    
    @State var tabIndex: Int = 0
    @State var isShowAlert = true
    @State var websquareOffset: HybridOffset = .left
    @Environment(\.injected.alertSheetVM) var alertSheetVM: AlertSheetViewModel
    @State private var count = 0
    @State var naviPath: [Menu] = []
    @State var urlStr = ""
    
    let bottomNaviList = [BottomNavigationItem(normalIcon: Image("Icon_filled_32_home_off"), selectedIcon: Image("Icon_filled_32_home_on"), text: "home"),
                          BottomNavigationItem(normalIcon: Image("Icon_filled_32_product_off"), selectedIcon: Image("Icon_filled_32_product_on"), text: "product"),
                          BottomNavigationItem(normalIcon: Image("Icon_filled_32_column_off"), selectedIcon: Image("Icon_filled_32_column_on"), text: "column"),
                          BottomNavigationItem(normalIcon: Image("Icon_filled_32_menu_off"), selectedIcon: Image("Icon_filled_32_menu_on"), text: "other")]
    
    var body: some View {
        NavigationStack(path: $naviPath) {
            ZStack {
                Color.clear.opacity(0.2).ignoresSafeArea()
                
                // MARK: Main area
                Group {
                    WKWebViewPractice(urlStr: urlStr)
                        .ignoresSafeArea()
                        .zIndex(100)
                        .offset(x: websquareOffset.offset)
                    
                    VStack {
                        Text("home")
                        CustomEnvironmentChildView()
                        CustomEnvironmentChildView()
                            .environment(\.customerCount, count)
                    }
                    
                    .zIndex(200)
                    .navigationDestination(for: Menu.self, destination: { menu in
                        Text("\(menu.rawValue) menu")
                    })
                    
                    
                }
                
                // MARK: Bottom navigation area
                if true {
                    
                    VStack {
                        Spacer()
                        
                        BottomNavigation(selectedIndex: $tabIndex, items: bottomNaviList, height: 50) { selectedIndex in
                            switch selectedIndex {
                            case 0:
                                websquareOffset = .left
                            case 1:
                                websquareOffset = .center
                                urlStr = "https://naver.com"
                                print("urlStr:\(urlStr)")
                            case 2:
                                websquareOffset = .center
                                urlStr = "https://daum.net"
                                print("urlStr:\(urlStr)")
                            default:
                                websquareOffset = .right
                                naviPath.append(.other)
                            }
                            
                            
                        }
                    }
                    .zIndex(300)
                    .ignoresSafeArea(.keyboard)
                    
                }
            }
        }
//        .alert(isPresented: $isShowAlert, content: {
//            Alert(title: Text("alert title"), message: Text("alert message"), primaryButton: .default(Text("가나다"), action: {}), secondaryButton: .cancel(Text("강낭당"), action: {}))
//        })
        // modifier를 통해 content를 가져가서 포함시킨 뷰를 그린다.
        //.alertSheet(vm: alertSheetVM)
        
    }
}

struct CustomEnvironmentChildView: View {
    @Environment (\.customerCount) var counter
    var body: some View {
        Text("\(counter)")
    }
}

// MARK: - Preview
struct MainContainerScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainContainerScreen()
    }
}
