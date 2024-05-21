//
//  MainContinerUseCase.swift
//  CopyUIB
//
//  Created by 60192229 on 5/16/24.
//

import Foundation
import Combine



struct MainContinerUseCase : MainContinerUseCaseProtocol {
    
    func getLaunchInfo() -> AnyPublisher<UIBLaunchData?, APIError> {
        let launchInfoRequest = LaunchRequest()
        
        return LaunchAPI.getLaunchInfo(launchRequest: launchInfoRequest, screenId: "PRO_APP_089")
            .tryMap { res -> UIBLaunchData? in
                if let res = res {
                    if res.elHeader?.resSuc == true {
                        return res.elData
                    } else {
                        if let resMsgVo = res.elHeader?.resMsgVo {
                            let headerMessage = HeaderMessage.convert(from: resMsgVo)
                            let errorCode = res.elHeader?.resCode ?? ""
                            throw APIError.headerMessage(headerMessage, errorCode)
                        }
                        else {
                            throw APIError.headerMessageEmpty
                        }
                    }
                }
                else {
                    throw APIError.noData
                }
            }
            .mapError({ err -> APIError in
                if let err = err as? APIError {
                    return err
                }
                return APIError.unknown
            })
            .eraseToAnyPublisher()
    }
}
