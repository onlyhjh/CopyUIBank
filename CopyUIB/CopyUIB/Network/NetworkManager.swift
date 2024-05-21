//
//  NetworkManager.swift
//  CopyUIB
//
//  Created by 60192229 on 5/17/24.
//

import Foundation

class NetworkManager: NSObject {
    
    public
    static let shared = NetworkManager()
    public
    var session: URLSession?
    let operationQueue = OperationQueue()    // network전용 operation Queue 생성
    
    // MARK: - Session ID
    public
    var sessionId: String? {
        return getSessionId()
    }
    
    public
    override init(){
        super.init()
        /// 설정 수행
        let configuration = URLSessionConfiguration.default
        // Constants 에 정의 된 설정
        configuration.httpMaximumConnectionsPerHost = 4
        configuration.timeoutIntervalForRequest = 60
        // 객체 생성
        session = URLSession(configuration: configuration, delegate: self, delegateQueue: self.operationQueue)
    }


    // MARK: Logout 등을 수행할때 로컬 쿠키 지울때 이용
    public
    func clearCookieNetworkManager(completionHandler: (() -> Void)?) {
        DispatchQueue.main.async {
            if let cookies = HTTPCookieStorage.shared.cookies {
                // webview cookie 삭제
                for cookie in cookies {
                    HTTPCookieStorage.shared.deleteCookie(cookie)
                }
            }
            if let completionHandler = completionHandler {
                completionHandler()
            }
        }
    }
    
    // MARK: get session from cookie storage
    // TODO: - 세션값 추출
    public
    func getSessionId()->String? {
        var cookieValue: String?
        if let cookies = HTTPCookieStorage.shared.cookies {
            cookies.forEach { cookie in
                if cookie.name == "JSESSIONID" && cookie.domain == URL(string: "https://gcodev.shinhanglobal.com")?.host {
                    cookieValue = cookie.value
                }
            }
        }
        
        return cookieValue
    }
}

// MARK: session Delegate
extension NetworkManager: URLSessionDelegate {
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard let serverTrust = challenge.protectionSpace.serverTrust else {
            return completionHandler(URLSession.AuthChallengeDisposition.useCredential, nil)
        }
        return completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: serverTrust))
    }
}
