//
//  MainContinerUseCaseProtocol.swift
//  IOS_CleanArchitecture_Sample
//
//  Created by 60067670 on 2022/03/31.
//

import Combine
import Foundation

protocol MainContinerUseCaseProtocol {
    
    func getLaunchInfo() -> AnyPublisher<UIBLaunchData?, APIError>
    
}
