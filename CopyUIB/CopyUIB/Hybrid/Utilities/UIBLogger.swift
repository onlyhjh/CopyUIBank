//
//  UIBLogger.swift
//  UIBank
//
//  Created by 60156664 on 13/01/2023.
//

class UIBLog {
    public
    enum  enumLogEventType: String{
        case Error  = "‼️ " // 오류발생시 출력
        case Info   = "ℹ️ " // 정보형 출력
        case Trace  = "💬 " // 일반 trace 로그
        case Hot    = "🔥 " // 중요한 로그를 확인할때 이용
    }
    
    public
    class func log(_ message: String, logType: enumLogEventType = .Trace,
                   fileName: String = #file,
                   line: Int = #line,
                   funcName: String = #function) {
        
#if DEBUG
        print("\(logType.rawValue)[\(sourceFileName(filePath: fileName))]:\(line) \(funcName) -> \(message)")
#endif
    }
    
    private
    class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
}
