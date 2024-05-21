//
//  KHLanguageItem.swift
//  UIBank
//
//  Created by 60156664 on 10/01/2023.
//

import Foundation

struct UIBLanguageInfo: Codable {
    var regTm: String?
    var ltChgDt: String?
    var regOperNo: String?
    var langCode: String?
    var type: String?
    var regDt: String?
    var transit: String?
    var value: String?
    var status: String?
    var ltChgOperNo: String?
    var key: String?
    var shCorpC: String?
    var ltChgTm: String?

    enum CodingKeys: String, CodingKey {
        case regTm = "regTm"
        case ltChgDt = "ltChgDt"
        case regOperNo = "regOperNo"
        case langCode = "langCode"
        case type = "type"
        case regDt = "regDt"
        case transit = "transit"
        case value = "value"
        case status = "status"
        case ltChgOperNo = "ltChgOperNo"
        case key = "key"
        case shCorpC = "shCorpC"
        case ltChgTm = "ltChgTm"
    }
}
