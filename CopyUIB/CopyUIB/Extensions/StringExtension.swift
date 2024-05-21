//
//  StringExtension.swift
//  CopyUIB
//
//  Created by 60192229 on 5/16/24.
//

import Foundation

extension String {
    func encodeUrl() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    
    func decodeUrl() -> String {
        return self.removingPercentEncoding!
    }
    
    func fixServerCRLF()->String{
        return self
            .replacingOccurrences(of: "\\n", with:"\n")
            .replacingOccurrences(of: "\\r", with:"\n")
            .replacingOccurrences(of: "<br/>", with: "\n")
            .replacingOccurrences(of: "</br>", with: "\n")
            .replacingOccurrences(of: "<br>", with: "\n")
    }
}
