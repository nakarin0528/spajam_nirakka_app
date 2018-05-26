import Foundation

// Developスキーム以外ではログを出力しない

public func print(debug: Any = "",
                  function: String = #function,
                  file: String = #file,
                  line: Int = #line) {
    var filename = file
    if let match = filename.range(of: "[^/]*$", options: .regularExpression) {
        filename = String(filename[match])
    }
    Swift.print("Log:\(filename):L\(line):\(function) \(debug)")
}

public func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    Swift.print(items, separator:separator, terminator: terminator)
}

public func print<Target>(_ items: Any..., separator: String = " ", terminator: String = "\n", to output: inout Target) where Target : TextOutputStream {
    Swift.print(items, separator: separator, terminator: terminator)
}

public func debugPrint(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    Swift.debugPrint(items, separator: separator, terminator: terminator)
}

public func debugPrint<Target>(_ items: Any..., separator: String = " ", terminator: String = "\n", to output: inout Target) where Target : TextOutputStream {
    Swift.debugPrint(items, separator: separator, terminator: terminator)
}

public func NSLog(message:String){
    Foundation.NSLog(message)
}
public func NSLog(format:String, _ args:CVarArg...){
    Foundation.NSLog(String(format: format, arguments: args))
}
