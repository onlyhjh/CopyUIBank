//
//  BottomSheet.swift
//  CopyUIBank
//
//  Created by 60192229 on 5/7/24.
//

import SwiftUI

class AlertViewModel: ObservableObject {
    @Published var isShow = false
    //@Published var index = 0
}

extension View {
    func customAlert(alertVM: AlertViewModel) -> some View {
        modifier(AlertModifier(alertVM: alertVM))
    }
}

struct AlertModifier: ViewModifier {
    @ObservedObject var alertVM: AlertViewModel
    
    func body(content: Content) -> some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                content
//                if alertVM.isShow {
//                    Color.black.opacity(0.4)
//                        .ignoresSafeArea()
//                        .onTapGesture {
//                            alertVM.isShow.toggle()
//                        }
//                }
            }
            
            VStack {
                Spacer()
                
                if alertVM.isShow {
                    Color.red.frame(height: 300)
                }
                
            }
        }
    }
}
