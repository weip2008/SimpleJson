//: [Previous](@previous)

import Foundation

public struct Author: JSONConvertable {
    public var name: Label?
    public var uri: Label?
    
    public init?(JSON: JSONType?) {
        guard let Json = JSON else { return nil }
        //        guard case .dictionary(let dictionary) = Json else { return nil }
        
        name = Label(JSON: Json.jsonValue("name"))
        uri = Label(JSON: Json.jsonValue("uri"))
    }
}

public struct Label: JSONConvertable {
    public var label: String?
    
    public init?(JSON: JSONType?) {
        guard let Json = JSON else { return nil }
        guard case .dictionary(let dictionary) = Json else { return nil }
        
        label = dictionary.values("label")
        
    }
}

let jsonString = "{\"name\": {\"label\": \"iTunes Store\" }, \"uri\": {\"label\": \"http://www.apple.com/itunes/\" }}"

let data = jsonString.data(using: .utf8)!

let jsonWithObjectRoot = try? JSONSerialization.jsonObject(with: data, options: [])
let json = JSONType(jsonWithObjectRoot)

let author = Author(JSON: json)

print (author ?? "author is null")
print ("\n")
print(author?.name?.label ?? "label is null")

//: [Next](@next)
