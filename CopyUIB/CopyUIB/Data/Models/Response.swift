//
//  Response.swift
//  UIBank
//
//  Created by 60156664 on 10/01/2023.
//

import Foundation

struct Response<T : Codable> : Codable {
    var userHeader: UserHeader?
    var elHeader: ElHeader?
    var elData: T?

    enum CodingKeys: String, CodingKey {
        case userHeader = "userHeader"
        case elHeader = "elHeader"
        case elData = "elData"
    }
}
