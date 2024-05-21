//
//  MainContainerScreen.swift
//  CopyUIBank
//
//  Created by 60192229 on 5/3/24.
//

import SwiftUI
import Combine


public
enum LoginType: String {
    /// 아이디 비번
    case idPassword
    /// 간편인증
    case simpleAuth
    /// 패턴 로그인
    case pattern
    /// 지문 인식
    case fingerPrint
    /// FaceID
    case faceId
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

// @Environment 1 환경 변수의 전달값이 없을 경우 기본값 키 설정 (must)
struct CountKey: EnvironmentKey {
    static var defaultValue: Int = 200
}

// @Environment 2 환경변수 추가
extension EnvironmentValues {
    
    var count: Int {
        get { self [CountKey.self]}
        //set(newValue) { self [CountKey.self] = newValue}
        set { self [CountKey.self] = newValue }
    }
}


struct MainContainerScreen: View {
    
    @StateObject var vm: MainContainerViewModel
    @State var tabIndex: Int = 0
    @State var websquareOffset: HybridOffset = .left
    @State var isHiddenBottomNavigation: Bool = false
    
    // 부모로부터 받는 환경 변수
    @Environment(\.appContainer) var appContainer: AppContainer
    //@Environment(\.appContainer.alertVM) var alertVM: AlertViewModel
    @Environment(\.appContainer.navigationStack) private var navigationStack: NavigationStackCompat
    @Environment(\.appContainer.hybridStackManager) private var hybridStackManager: HybridStackManager
    
    @State var alertVM = AppEnvironmentSingleton.shared.appEnvironment?.container.alertVM ?? AlertViewModel()

    @State var naviPath: [Menu] = []
    @State var urlStr = ""
    
    let bottomNaviList = [BottomNavigationItem(normalIcon: Image("Icon_filled_32_home_off"), selectedIcon: Image("Icon_filled_32_home_on"), text: "home"),
                          BottomNavigationItem(normalIcon: Image("Icon_filled_32_product_off"), selectedIcon: Image("Icon_filled_32_product_on"), text: "product"),
                          BottomNavigationItem(normalIcon: Image("Icon_filled_32_column_off"), selectedIcon: Image("Icon_filled_32_column_on"), text: "column"),
                          BottomNavigationItem(normalIcon: Image("Icon_filled_32_menu_off"), selectedIcon: Image("Icon_filled_32_menu_on"), text: "other")]
    
    init() {
        _vm = StateObject(wrappedValue: MainContainerViewModel())
    }
    
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
                    
                    nativeView

                    
                    
                }

                if !isHiddenBottomNavigation {
                    VStack {
                        Spacer()
                        
                        BottomNavigation(selectedIndex: $tabIndex, items: bottomNaviList, height: 50) { selectedIndex in
                            switch selectedIndex {
                            case 0:
                                websquareOffset = .left
                                navigationStack.pop()
                                hybridStackManager.stack = [0]
                            case 1:
                                websquareOffset = .center
                                urlStr = "https://naver.com"
                                print("urlStr:\(urlStr)")
                                navigationStack.pop()
                                hybridStackManager.stack.append(1)
                            case 2:
                                websquareOffset = .center
                                urlStr = "https://daum.net"
                                print("urlStr:\(urlStr)")
                                navigationStack.pop()
                                hybridStackManager.stack.append(2)
                            default:
                                websquareOffset = .right
                                //naviPath.append(.other)
                                navigationStack.push(
                                    OtherMenu(), animation:  true
                                )
                                hybridStackManager.stack.append(3)
                            }
                            
                            
                        }
                    }
                    .zIndex(300)
                    .ignoresSafeArea(.keyboard)
                }
            }
            .customAlert(alertVM: alertVM)
            .onReceive(hybridStackManager.$stack, perform: { newStack in
                self.isHiddenBottomNavigation = newStack.last == 3
            })
        }
        
//        .alert(isPresented: $isShowAlert, content: {
//            Alert(title: Text("alert title"), message: Text("alert message"), primaryButton: .default(Text("가나다"), action: {}), secondaryButton: .cancel(Text("강낭당"), action: {}))
//        })
        // modifier를 통해 content를 가져가서 포함시킨 뷰를 그린다.
        //.alertSheet(vm: alertSheetVM)
        
    }
}

struct CustomEnvironmentChildView: View {
    @Environment (\.count) var count
    
    var body: some View {
        VStack{
            Text("\(count)")
            Button("childview에서 add count (안됨)") {
                 //count += 1
            }
        }
        
    }
}

extension MainContainerScreen {
    var nativeView: some View {
        @ViewBuilder var renderedView: some View {
            NavigationStackView(navigationStack: navigationStack) {
                switch vm.state {
                case .launching:
                    ZStack {
                        Color.blue
                        Text("launching")
                    }
                case .permisson:
                    ZStack {
                        Color.pink
                        Text("permission")
                    }
                case .term:
                    EmptyView()
                        .background(Color.white)
                case .home:
                    Home()
                }
            }
        }
        return renderedView
    }
}


struct Home: View {
    @State private var count = 30
    @State var alertVM = AppEnvironmentSingleton.shared.appEnvironment?.container.alertVM ?? AlertViewModel()
    
    var body: some View {
        ZStack{
            Color.pink
            
            VStack {
                Text("home")
                //CustomEnvironmentChildView() 기본값으로 설정됨
                CustomEnvironmentChildView()
                    .environment(\.count, count) // 자녀에게 값전달
                Button("add count") {
                    count += 1
                }
                Spacer()
                Button("show/hide Alert") {
                    alertVM.isShow.toggle()
                }
                Spacer()
            }
            .zIndex(200)
            .navigationDestination(for: Menu.self, destination: { menu in
                Text("\(menu.rawValue) menu")
            })
        }
    }
}

struct OtherMenu: View {
    @State private var count = 30
    @State var alertVM = AppEnvironmentSingleton.shared.appEnvironment?.container.alertVM ?? AlertViewModel()
    
    var body: some View {
        ZStack{
            Color.gray
            VStack {
                Button("< OtherMenu back") {
                    AppEnvironmentSingleton.shared.appEnvironment?.container.navigationStack.pop()
                    AppEnvironmentSingleton.shared.appEnvironment?.container.hybridStackManager.stack.removeLast()
                }
                Spacer()
            }
            Text("OtherMenu")
        }
    }
    
    
}
// MARK: - Preview
struct MainContainerScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainContainerScreen()
    }
}



