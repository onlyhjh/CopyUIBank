//
//  URLRequestExtension.swift
//  CopyUIB
//
//  Created by 60192229 on 5/16/24.
//

import Foundation

public
extension URLRequest {
    /**
        API 함수에서 아래와 같이 gmaDefault 함수에 파라미터로 screenId를 전달하면 g-trace-id 값에 programId 11자리로 차지하게 된다.
     ```
     var request = URLRequest(url: url)
     // POST, json, 기본 heder 설정
     request.gmaDefault(screenId: screenId)

     ```
     - Remark:
        nil 로 전달될때는 000_000_000 값으로 채우고 있다.
     */
    // TODO: - nil 로 전달 받을때 처리 안드로이드와 비교 필요
    
    mutating func uiDefaultHeader(screenId: String? = nil) {
        self.httpMethod = "POST"
        self.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // ProWorks Lang
        self.uiProworks(lang: UserDefaults.standard.selectedLanguage)
        // default scree
        self.uiTraceId(screenId: screenId)
        // Echo Mode
        self.uiEchoMode(bUse: false)
    }
    
    // MARK: - g trace id
    /**
     규격
     년월일(8)+그룹코드(3)+화면번호(11)+시분초밀리(9)
     ```
     g-trace-id: 2022032416
     ```
     */
    mutating func uiTraceId(screenId: String?, date: Date? = Date()) {
        let groupCode = "100"//UIBConstants.I18N.nationCode // 3자리, 프로그램 시작할때 지정됨
        let yymmdd = "000000" //date?.gtraceId_yymmdd() ?? "000000"
        let mmhhsssss = "000000"//date?.gtraceId_HHmmssSSS() ?? "000000"
        let gTraceId = yymmdd + mmhhsssss + groupCode + "I" + String(Int.random(in: 1000000000..<10000000000))

        self.setValue(gTraceId, forHTTPHeaderField: "g-trace-id")
    }
    
    // MARK: - EchoMode
    mutating func uiEchoMode(bUse: Bool){
        let echoModeValue = bUse ? "Y" : "N"
        self.setValue(echoModeValue, forHTTPHeaderField: "echoMode")
    }
    
    // MARK: - Proworks key value
    mutating func uiProworks(lang: String){
        self.setValue(lang, forHTTPHeaderField: "Proworks-lang")
    }
}
