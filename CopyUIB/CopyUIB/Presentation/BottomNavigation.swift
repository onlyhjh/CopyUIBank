//
//  BottomNavigation.swift
//  gma_presentation
//
//  Created by 60156664 on 21/06/2022.
//

import SwiftUI
import Foundation

public class GMALocalBundleClass {
    
    public class func bundle()->Bundle {
#if SWIFT_PACKAGE
        return Bundle.module
#else
        return Bundle(for:GMALocalBundleClass.self)
#endif
    }
    
}

public extension Image {
    // Loading image in framework
    init(name: String) {
        self.init(name, bundle: GMALocalBundleClass.bundle())
    }
}
extension Image {
    init(data: Data) {
        #if canImport(UIKit)
            let songArtwork: UIImage = UIImage(data: data) ?? UIImage()
            self.init(uiImage: songArtwork)
        #elseif canImport(AppKit)
            let songArtwork: NSImage = NSImage(data: value) ?? NSImage()
            self.init(nsImage: songArtwork)
        #else
            self.init(systemImage: "some_default")
        #endif
    }

}

extension Image {
    func centerCropped() -> some View {
        Color.clear
        .overlay(
            self
            .resizable()
            .scaledToFill()
        )
        .clipped()
    }
}


public struct BottomNavigationItem {
    var normalIcon: Image
    var selectedIcon: Image
    var text: String?
    
    public init(normalIcon: Image,
                selectedIcon: Image,
                text: String? = nil) {
        self.normalIcon = normalIcon
        self.selectedIcon = selectedIcon
        self.text = text
    }
    
    func getCurrentIcon(isSelected: Bool) -> Image {
        return isSelected ? selectedIcon : normalIcon
    }
    
    public static let templateItems = [BottomNavigationItem(normalIcon: Image( "icon_bottom_navi_home_gray"), selectedIcon: Image("icon_bottom_navi_home"), text: "ホーム"),
                                       BottomNavigationItem(normalIcon: Image( "icon_bottom_navi_tranfer_gray"), selectedIcon: Image("icon_bottom_navi_tranfer"), text: "商品一覧"),
                                       BottomNavigationItem(normalIcon: Image( "icon_bottom_navi_menu_gray"), selectedIcon: Image( "icon_bottom_navi_menu"), text: "コラム"),
                                       BottomNavigationItem(normalIcon: Image( "icon_bottom_navi_menu_gray"), selectedIcon: Image( "icon_bottom_navi_menu"), text: "メニュー")]
}

/**
Bottom Navigation in App.
 - Author: Shinhan Bank
*/
public struct BottomNavigation: View {
    @Binding var selectedIndex:Int
    var items: [BottomNavigationItem] = []
    
    var normalColor: Color = Color.gray
    var selectedColor: Color = Color.gray.opacity(0.7)
    var didSelected: (Int) -> Void
    var navigationHeight: CGFloat = 72.0

    /**
    Bottom Navigation in App.
     - Parameters:
       - Items: List of items that can be tapped on the left.
       - selectedIndex: Index of the list of currently selected items.
    */
    public init(selectedIndex:Binding<Int>,
                items: [BottomNavigationItem] = [],
                height: CGFloat = 72,
                didSelected: @escaping (Int) -> Void) {
        self.items = items
        self.didSelected = didSelected
        self.navigationHeight = height
        self._selectedIndex = selectedIndex
    }
    
    @State var isButtonDisabled: Bool = false

    public var body: some View {
        HStack(spacing: 0) {
            // Sub items
            LazyVGrid(columns: Array(repeating: GridItem(spacing: 8,
                                                         alignment: .center),
                                     count: items.count),
                      spacing: 0) {
                ForEach(0..<items.count, id: \.self) { index in
                    let item = items[index]
                    Button(action: {
                        didSelected(index)
                        // Delay 0.3 seconds to disable multi tap
                        isButtonDisabled = true
                        // Reset the flag after a short delay to re-enable the button
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            isButtonDisabled = false
                        }

                    }, label: {
                        BottomNavigationItemView(item: item, isSelected: index == self.selectedIndex, normalColor: self.normalColor, selectedColor: self.selectedColor)
                    })
                    .buttonStyle(BottomNavigationButtonStyle())
                    .disabled(isButtonDisabled)
                }
            }
        }
        .padding(.horizontal, 12)
        .frame(height: navigationHeight)
        .fixedSize(horizontal: false, vertical: true)
        .ignoresSafeArea(.keyboard)
        .background(Color.white.ignoresSafeArea())
        .shadow(color: Color.gray.opacity(0.16), radius: 16, x: 0, y: 0)
    }
    
    struct BottomNavigationItemView: View {
        var item: BottomNavigationItem
        var isSelected: Bool = false
        var normalColor: Color = Color.gray
        var selectedColor: Color = Color.gray.opacity(0.7)

        var body: some View {
            VStack(spacing: 4) {
                item.getCurrentIcon(isSelected: isSelected)
                    .frame(width: 32, height: 32, alignment: .center)
                    .foregroundColor(isSelected ? selectedColor : normalColor)
                if let text = item.text {
                    Text(text)
                }
            }
        }
    }
}

struct BottomNavigationButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
    }
}


struct BottomNavigation_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BottomNavigation(selectedIndex: .constant(1), items: BottomNavigationItem.templateItems, didSelected: { index in
                // When tap to sub button items
            })
        }
    }
}
