//
//  UIBNoticeInfo.swift
//  UIBank
//
//  Created by 60156664 on 06/02/2024.
//

import Foundation

struct UIBNoticeInfo: Codable {
    var bannerPerFrom: String?
    var displayPos: String?
    var bannerDisplayType: String?
    var bannerSeq: String?
    var bannerPerTo: String?
    var bannerSubContentAc: String?
    var bannerMainContentAc: String?
    var bannerPerFromTime: String?
    var bannerPerToTime: String?

    enum CodingKeys: String, CodingKey {
        case bannerPerFrom = "banner_per_from"
        case displayPos = "display_pos"
        case bannerDisplayType = "banner_display_type"
        case bannerSeq = "banner_seq"
        case bannerPerTo = "banner_per_to"
        case bannerSubContentAc = "banner_sub_content_ac"
        case bannerMainContentAc = "banner_main_content_ac"
        case bannerPerFromTime = "banner_per_from_time"
        case bannerPerToTime = "banner_per_to_time"
    }
}
