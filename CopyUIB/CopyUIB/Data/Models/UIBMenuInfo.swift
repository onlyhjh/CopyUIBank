//
//  KHMenuItem.swift
//  UIBank
//
//  Created by 60156664 on 10/01/2023.
//

import Foundation


struct UIBMenuInfo: Codable {
    var shLclCorpC: String?
    var mn1StpSern: Int?
    var mn2StpSern: Int?
    var mn3StpSern: Int?
    var mn4StpSern: Int?
    var mnDesc: String?
    var inetBnkgMnC: String?
    var inetBnkgMnD: String?
    var mnSrnPath: String?
    var chGbn5: String?
    var mnMainD: String?
    var etcInf1: String?
    var etcInf2: String?
    var etcInf3: String?
    var menuInfoList: [UIBMenuInfo]?

    enum CodingKeys: String, CodingKey {
        case shLclCorpC = "sh_lcl_corp_c"
        case mn1StpSern = "mn_1_stp_sern"
        case mn2StpSern = "mn_2_stp_sern"
        case mn3StpSern = "mn_3_stp_sern"
        case mn4StpSern = "mn_4_stp_sern"
        case mnDesc = "mn_desc"
        case inetBnkgMnC = "inet_bnkg_mn_c"
        case inetBnkgMnD = "inet_bnkg_mn_d"
        case mnSrnPath = "mn_scrn_path"
        case chGbn5 = "ch_gbn_5"
        case mnMainD = "mn_main_d"
        case etcInf1 = "etc_inf_1"
        case etcInf2 = "etc_inf_2"
        case etcInf3 = "etc_inf_3"
        case menuInfoList = "menuInfoList"
    }
}


extension UIBMenuInfo {
    func etcInfoAvaiable() -> Bool {
//        let allMenuList = UserDefaults.standard.menuList
//        guard let menu = allMenuList?.filter({$0.inetBnkgMnC == self.inetBnkgMnC}).first else {
//            UIBLog.log("menu not found in menu list all")
//            return false
//        }
//        
//        guard let etc = menu.etcInf1 else {
//            return false
//        }
        
        return true
    }
}

extension UIBMenuInfo: Equatable {
    public static func == (lhs: UIBMenuInfo, rhs: UIBMenuInfo) -> Bool {
        return EqualityChecker.isEqual(lhs: lhs, rhs: rhs)
    }
}
