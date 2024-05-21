//
//  KHHomeBannerItem.swift
//  UIBank
//
//  Created by 60156664 on 10/01/2023.
//

import Foundation

struct UIBHomeBannerItem {
    var id: UUID = UUID()
    var url: String = ""
    var title: String = ""
    var subTitle: String = ""
    var info: UIBHomeBannerInfo? = nil
}

struct UIBHomeBannerInfo: Codable {
    var bannerMainContentAc: String?
    var bannerSeq: String?
    var bannerSubContentAc: String?
    var infomgtLink: String?
    var bannerBottomImageUrlAc: String?
    var displayPos: String?
    var linkUrl: String?
    var bannerDisplayType: String?

    
    enum CodingKeys: String, CodingKey {
        case bannerMainContentAc = "banner_main_content_ac"
        case bannerSeq = "banner_seq"
        case bannerSubContentAc = "banner_sub_content_ac"
        case infomgtLink = "infomgt_link"
        case bannerBottomImageUrlAc = "banner_bottom_image_url_ac"
        case displayPos = "display_pos"
        case linkUrl = "link_url"
        case bannerDisplayType = "banner_display_type"
    }
}

extension UIBHomeBannerItem: DTOConvertable {
    static func convert(from dto: UIBHomeBannerInfo) -> UIBHomeBannerItem {
        return UIBHomeBannerItem(url: dto.bannerBottomImageUrlAc ?? "", title: dto.bannerMainContentAc ?? "", subTitle: dto.bannerSubContentAc ?? "", info: dto)
    }
    typealias DataTransferObject = UIBHomeBannerInfo
}

extension UIBHomeBannerInfo: Equatable {
    public static func == (lhs: UIBHomeBannerInfo, rhs: UIBHomeBannerInfo) -> Bool {
        return EqualityChecker.isEqual(lhs: lhs, rhs: rhs)
    }
}
