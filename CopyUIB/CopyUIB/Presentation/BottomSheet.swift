//
//  BottomSheet.swift
//  CopyUIBank
//
//  Created by 60192229 on 5/7/24.
//

import SwiftUI

class AlertSheetViewModel: ObservableObject {
    @Published var isShow = false
    @Published var index = 0
}

extension View {
    func alertSheet(vm: AlertSheetViewModel) -> some View {
        self.modifier(AlertSheet(vm: vm))
    }
    
    func bottomSheet<PopupContentView: View>(@ViewBuilder view: @escaping () -> PopupContentView) -> some View {
        self.modifier(BottomSheet(view: view))
    }
}

struct AlertSheet: ViewModifier {
    @ObservedObject var vm: AlertSheetViewModel
    
    func body(content: Content) -> some View {
        VStack {
            Text("made by AlertSheet")
            content // MainContainerScreen에서 만들어진 화면을 넣어준다.
        }
        .bottomSheet(view: {
            VStack {
                Text("made by viewbuilder view")
            }
         })
    }
}


struct BottomSheet<PopupContentView: View>: ViewModifier {
    var view: () -> PopupContentView
    
    func body(content: Content) -> some View {
        GeometryReader { geo in
            VStack {
                content // alertSheet에서 만들어진 화면을 넣어준다
                Text("made by BottomSheet view")
                view()
            }
        }
    }
}
