//
//  EIHeader.swift
//  UIBank
//
//  Created by 60156664 on 09/01/2023.
//

import Foundation

struct ElHeader: Codable {
    var svcTimeOut: Int?
    var fieldApplyAttr: Bool?
    var serviceKey: String?
    var traceId: String?
    var dbDataEnc: Bool?
    var gTraceId: String?
    var reqUrl: String?
    var clientIp: String?
    var serverId: String?
    var locale: String?
    var resSuc: Bool?
    var saveTokenKey: Bool?
    var inOutDataEnc: Bool?
    var startTime: Int?
    var restoreServiceKey: String?
    var removeTokenKey: Bool?
    var bArgResolveParsing: Bool?
    var validateSuc: Bool?
    var simurate: Bool?
    var scrnId: String?
    var language: String?
    var resMsgVo: ResMsgVo?
    var resCode: String?

    enum CodingKeys: String, CodingKey {
        case svcTimeOut = "svcTimeOut"
        case fieldApplyAttr = "fieldApplyAttr"
        case serviceKey = "serviceKey"
        case traceId = "traceId"
        case dbDataEnc = "dbDataEnc"
        case gTraceId = "gTraceId"
        case reqUrl = "reqUrl"
        case clientIp = "clientIp"
        case serverId = "serverId"
        case locale = "locale"
        case resSuc = "resSuc"
        case saveTokenKey = "saveTokenKey"
        case inOutDataEnc = "inOutDataEnc"
        case startTime = "startTime"
        case restoreServiceKey = "restoreServiceKey"
        case removeTokenKey = "removeTokenKey"
        case bArgResolveParsing = "bArgResolveParsing"
        case validateSuc = "validateSuc"
        case simurate = "simurate"
        case scrnId = "scrnId"
        case language = "language"
        case resMsgVo = "resMsgVo"
        case resCode = "resCode"
    }
}

class ResMsgVo: Codable {
    var addMsg: String?
    var fixedLengthVo: Bool?
    var msgId: String?
    var msgText: String?
    var msgType: String?
    var userMsg: String?
    enum CodingKeys: String, CodingKey {
        case addMsg = "addMsg"
        case fixedLengthVo = "fixedLengthVo"
        case msgId = "msgId"
        case msgText = "msgText"
        case msgType = "msgType"
        case userMsg = "userMsg"
    }
}
