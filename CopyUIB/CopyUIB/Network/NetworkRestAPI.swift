//
//  NetworkRestAPI.swift
//  UIBank
//
//  Created by 60156664 on 25/03/2023.
//

import Combine
import Foundation

class NetworkRestAPI {
    class func post<T>(request: URLRequest) -> AnyPublisher <Response<T>?, APIError> where T: Decodable {
        guard let session = NetworkManager.shared.session else {
            return Fail<Response<T>?, APIError>(error: .sessionError).eraseToAnyPublisher()
        }

        return session.dataTaskPublisher(for: request)
            .tryMap{ element -> Response? in
                guard let httpResponse = element.response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                
                guard httpResponse.statusCode == 200 else {
                    throw APIError.serverError
                }

                if let _ = httpResponse.allHeaderFields["Set-Cookie"] {
//                    SessionManager.shared.syncCookie {
//                        Logger.log("set-cookie sync")
//                    }
                }
                
                do {
                    let decodedResponse = try JSONDecoder().decode(Response<T>.self, from: element.data)
//                    SessionManager.shared.resetTimer()
                    return decodedResponse
                } catch let jsonError as NSError {
                    throw APIError.decodingError
                }
            }
            .mapError{
                err in
                if let err = err as? APIError {
                    return err
                }
                if err is URLError {
                    if err.isNetworkConnectionError() {
                        return  APIError.networkConnectionError
                    }
                    return APIError.unknown
                }
                if err is Swift.DecodingError {
                    return APIError.decodingError
                }
                return APIError.unknown
            }
            .eraseToAnyPublisher()
    }
}
