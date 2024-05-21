//
//  NetworkError.swift
//  UIBank
//
//  Created by 60156664 on 09/01/2023.
//

import Foundation

enum APIError: Error, Equatable {
    case badUrl
    case decodingError
    case noData
    case serverError
    case decodeError
    case badServerResponse
    case networkConnectionError
    case sessionError
    case headerMessage(_ msg: HeaderMessage, _ errorCode:String)
    case headerMessageEmpty
    case unknown
    
    public static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case let (.headerMessage(aMessage, aErrorCode), .headerMessage(bMessage, bErrorCode)):
            return aMessage == bMessage && aErrorCode == bErrorCode
        default:
            return false
        }
    }
}

public
struct HeaderMessage: Equatable {
    var addMsg: String?
    var fixedLengthVo: Bool?
    var msgId: String?
    var msgText: String?
    var msgType: String?
    var userMsg: String?
}

extension HeaderMessage: DTOConvertable {

    static func convert(from dto: ResMsgVo) -> HeaderMessage {
        return HeaderMessage(addMsg: dto.addMsg,
                             fixedLengthVo: dto.fixedLengthVo,
                             msgId: dto.msgId,
                             msgText: dto.msgText?.fixServerCRLF(),
                             msgType: dto.msgType,
                             userMsg: dto.userMsg)
    }

    typealias DataTransferObject = ResMsgVo

}

extension Error {
    func isNetworkConnectionError() -> Bool {
        let networkErrors = [NSURLErrorNetworkConnectionLost, NSURLErrorNotConnectedToInternet]

        let error = self as NSError
        
        return networkErrors.contains(error.code)
    }
}
