import Foundation

public protocol JSONConvertable {
    init?(JSON: JSONType?)
}

public enum JSONType {
    case array([Any])
    case dictionary([String: Any])
    case invalid(Any?)
    
    public init(_ jsonObject: Any?) {
        switch jsonObject {
        case is [Any]:
            self = .array(jsonObject as! [Any])
        case is [String: Any]:
            self = .dictionary(jsonObject as! [String: Any])
        default:
            self = .invalid(jsonObject)
        }
    }
    
    public func values<T: JSONConvertable>() -> [T]? {
        switch self {
        case .array(let array):
            
            var parsedItems = [T]()
            for item in array {
                let item = JSONType(item)
                if let parsedItem = T(JSON: item) {
                    parsedItems.append(parsedItem)
                }
            }
            return parsedItems
            
        default:
            return nil
        }
    }
    
    public func jsonValue(_ key: String) -> JSONType? {
        guard case let .dictionary(_dictionary) = self  else { return nil }

        return JSONType(_dictionary.values(key))
    }
}

public extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any {
    
    public func values<Value>(_ key: String) -> Value? {
        return (self[key as! Key] as? Value)
    }
}

public extension Array where Element : Any {
    
    public func values<T: JSONConvertable>() -> [T] {
        var finalArray = [T]()
        for item in self {
            let jsonItem = JSONType(item)
            switch jsonItem {
            case .invalid(_):
                debugPrint("\(#file):\(#function):\(#line): [--WARNING--]: found item to be invalid as a JSON object")
                continue
            default:
                if let jsonData = T(JSON: jsonItem) {
                    finalArray.append(jsonData)
                } else {
                    debugPrint("\(#file):\(#function):\(#line): [--WARNING--]: failed to parse array item")
                }
            }
        }
        
        return finalArray
    }
    
}
