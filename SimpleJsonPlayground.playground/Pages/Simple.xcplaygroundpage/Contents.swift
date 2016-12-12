//: Playground - noun: a place where people can play

import UIKit

public struct Sample: JSONConvertable {
    public var id: String?
    public var name: String?
    
    public init?(JSON: JSONType?) {
        guard let Json = JSON else { return nil }
        guard case .dictionary(let dictionary) = Json else { return nil }
        
        id = dictionary.values("id")
        name = dictionary.values("name")
    }
}

let sampleString = "{\"id\": \"ABCDEFG\", \"name\": \"Sam Houston\"}"
let data = sampleString.data(using: .utf8)!

let jsonWithObjectRoot = try? JSONSerialization.jsonObject(with: data, options: [])
let json = JSONType(jsonWithObjectRoot)

let sample = Sample(JSON: json)

print(sample?.id ?? "id is null")
print(sample?.name ?? "name is null")
