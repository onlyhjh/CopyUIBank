//
//  Encodable.swift
//  CopyUIB
//
//  Created by 60192229 on 5/16/24.
//

import Foundation

public
extension Encodable {
    
    var jsonData: Data {
        return try! JSONEncoder().encode(self)
    }

    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: jsonData)) as? [String: Any] ?? [:]
    }
    
    var array:[Any] {
        return (try? JSONSerialization.jsonObject(with: jsonData)) as? [Any] ?? []
    }
    
    func encode() throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return try encoder.encode(self)
    }

    var json: String? {
        do {
            let data = try encode()
            return String(data: data, encoding: .utf8)
        } catch {
            return nil
        }
    }
    
    // MARK: - 로그 출력을 위한 함수, 백슬래시, escaped 문자 제거
    var jsonLog: String? {
        var jsonString = self.json
        jsonString = jsonString?.decodeUrl()
        jsonString = jsonString?.replacingOccurrences(of: "\\/", with: "/")
        return jsonString
    }
    
    /// 읽기 힘든 네트워크 버전용
    var jsonNetwork: String {
        let invalidJson = "invalid JSON"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [])
            return String(data: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
}
