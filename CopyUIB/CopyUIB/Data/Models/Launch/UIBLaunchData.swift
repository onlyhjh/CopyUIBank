//
//  GetLaunchInfoResponse.swift
//  IOS_CleanArchitecture_Sample
//
//  Created by 60067670 on 2022/03/31.
//

import Foundation

struct UIBLaunchData: Codable {
    var isActivated: Int?
    var menuList: [UIBMenuListInfo]?
    var appLatestVer: String?
    var appReleaseDate: String?
    var languageList: [UIBLanguageInfo]?
    var serverMnVersion: Int?
    var serverLanguageVersion: Int?
    var globalMenuList: [UIBMenuInfo]?
    var homeBannerList: [UIBHomeBannerInfo]?
    var promotionBannerList: [UIBHomeBannerInfo]?
    var myMenuDefaultList: [UIBMenuInfo]?
    var myMenuList: [UIBMenuInfo]?
    var searchMenuList: [UIBMenuInfo]?
    var lastNoticeDt: String?
    var forceUpdateContent: String?
    var optionUpdateContent: String?
    var emergencyNotice: UIBNoticeInfo?
    var maintenanceNotice: UIBNoticeInfo?

    enum CodingKeys: String, CodingKey {
        case isActivated = "isActivated"
        case menuList = "menuList"
        case appLatestVer = "appLatestVer"
        case appReleaseDate = "appReleaseDate"
        case languageList = "languageList"
        case serverMnVersion = "serverMnVersion"
        case globalMenuList = "globalMenuList"
        case homeBannerList = "homeBannerList"
        case serverLanguageVersion = "serverLanguageVersion"
        case myMenuDefaultList = "myMenuDefaultList"
        case myMenuList = "myMenuList"
        case searchMenuList = "searchMenuList"
        case lastNoticeDt = "lastNoticeDt"
        case forceUpdateContent = "forceUpdateContent"
        case optionUpdateContent = "optionUpdateContent"
        case promotionBannerList = "promotionBannerList"
        case emergencyNotice = "emergencyNotice"
        case maintenanceNotice = "maintenance"
    }
}

struct UIBMenuListInfo: Codable {
    var inetBnkgMnC: String?
    var mn1StpSern: Int?
    var subMenuList: [UIBMenuInfo]?

    enum CodingKeys: String, CodingKey {
        case inetBnkgMnC = "inet_bnkg_mn_c"
        case mn1StpSern = "mn_1_stp_sern"
        case subMenuList = "subMenuList"
    }
}
