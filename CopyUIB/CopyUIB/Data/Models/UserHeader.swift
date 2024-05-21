//
//  UserHeader.swift
//  UIBank
//
//  Created by 60156664 on 09/01/2023.
//

import Foundation

struct UserHeader: Codable {

    var adTrxCnt: Int?
    var autoTotCnt: Int?
    var menuGroupNo: Int?
    var userGroupNo: Int?
    var usermenuCount: Int?
    var authCnt: Int?
    var gwcSecChal: Int?
    var authNotYetCnt: Int?
    var mymenuCount: Int?
    var memoTotCnt: Int?
    var loginType: Int?
    var holdTotCnt: Int?
    var lonAcCount: Int?
    var pushMasS: Int?
    var pushTotCnt: Int?
    var baseLastLoginTerm: Int?
    var fixedLengthVo: Bool?
    var cusAcCount: Int?
    var accumMonthlyAmt: Bool?
    var noReadMemoCnt: Int?
    var noReadPushCnt: Int?

    enum CodingKeys: String, CodingKey {
        case adTrxCnt = "ad_trx_cnt"
        case autoTotCnt = "auto_tot_cnt"
        case menuGroupNo = "menuGroupNo"
        case userGroupNo = "userGroupNo"
        case usermenuCount = "usermenu_count"
        case authCnt = "auth_cnt"
        case gwcSecChal = "gwc_sec_chal"
        case authNotYetCnt = "auth_not_yet_cnt"
        case mymenuCount = "mymenu_count"
        case memoTotCnt = "memo_tot_cnt"
        case loginType = "login_type"
        case holdTotCnt = "hold_tot_cnt"
        case lonAcCount = "lon_ac_count"
        case pushMasS = "push_mas_s"
        case pushTotCnt = "push_tot_cnt"
        case baseLastLoginTerm = "base_last_login_term"
        case fixedLengthVo = "fixedLengthVo"
        case cusAcCount = "cus_ac_count"
        case accumMonthlyAmt = "accum_monthly_amt"
        case noReadMemoCnt = "no_read_memo_cnt"
        case noReadPushCnt = "no_read_push_cnt"
    }
}
