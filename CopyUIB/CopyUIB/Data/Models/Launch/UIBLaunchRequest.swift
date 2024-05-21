//
//  LaunchRequest.swift
//  CopyUIB
//
//  Created by 60192229 on 5/16/24.
//

import Foundation
import UIKit
import CommonCrypto

/**
 Launch Request Data,
 */
public
struct LaunchRequest: Encodable, Equatable {
    
    enum CodingKeys: String, CodingKey {
        case uuid = "uuid"
        case deviceModel = "deviceModel"
        case deviceOS = "deviceOS"
        case deviceOSVersion = "deviceOSVersion"
        case appVersion = "appVersion"
        case appLanguage = "appLanguage"
        case appLanguageVersion = "appLanguageVersion"
        case appMenuVersion = "appMenuVersion"
        case tokenId = "token_id"
    }
    
    let uuid: String = "cb628a8502bf875694895c35aca206b8f4d64be7562dfa78b773aace9df6c3b9"
    let deviceModel = "iPhone13,1"
    let deviceOS = "I"
    let deviceOSVersion = "17.4.1"
    let appVersion = "2.0.2"
    var appLanguage = "ko"
    var appLanguageVersion = 213
    var appMenuVersion = 124
    var tokenId = ""
}


// MARK: - JSON Samples
/**
 Body Request Sample
 ```
 {
    "uuid": "8bab5a6ae6ac06f6c19f249ec67709298eb80af5396c72d5fa5f99ecd54cf887",
     "deviceModel": "Vivo_V2050",
     "deviceOS": "A",
     "deviceOSVersion": "11",
     "appVersion": "0.0.1",
     "appLanguage": "ko",
     "appLanguageVersion": 446,
     "appMenuVersion": 60
 }
 ```
 */
