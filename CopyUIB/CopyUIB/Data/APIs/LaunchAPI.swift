//
//  LaunchAPI.swift
//  CopyUIB
//
//  Created by 60192229 on 5/16/24.
//

import Foundation
import Combine

fileprivate
struct BodyData: Encodable {
    var elData: LaunchRequest
}

class LaunchAPI {
    
    public class func getLaunchInfo(launchRequest: LaunchRequest, screenId:String?) -> AnyPublisher<Response<UIBLaunchData>?, APIError> {

        let urlPath = URL(string: "https://gmuidev.ui-bk.com/ui/al/UIAL001.pwkjson")
        
        guard let url = urlPath else {
            return Fail<Response?, APIError>(error: .badUrl).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.uiDefaultHeader(screenId: screenId)
        
        let bodyData = BodyData(elData: launchRequest)
        request.httpBody = bodyData.jsonData
        UIBLog.log("req: \(bodyData.json ?? "")")

        return NetworkRestAPI.post(request: request)
    }
}

