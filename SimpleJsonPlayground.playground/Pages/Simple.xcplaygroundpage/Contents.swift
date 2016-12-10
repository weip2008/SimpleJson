//: Playground - noun: a place where people can play

import UIKit

public struct Airline: JSONConvertable {
    public var code: String?
    public var name: String?
    public var flightNumber: String?
    
    public init?(JSON: JSONType?) {
        guard let Json = JSON else { return nil }
        guard case .dictionary(let dictionary) = Json else { return nil }
        
        code = dictionary.value("code")
        name = dictionary.value("name")
        flightNumber = dictionary.value("flightNumber")
    }
}

let airport = "{\"code\": \"YFF\", \"name\": \"Houston Airport\", \"flightNumber\": \"167\"}"

let data = airport.data(using: .utf8)!

let jsonWithObjectRoot = try? JSONSerialization.jsonObject(with: data, options: [])

let json = JSONType(jsonWithObjectRoot)


let rs = Airline(JSON: json)

print(rs?.name ?? "")


//=========================

let passenger = ["name": "weip"]
print("\(passenger["name"] ?? "") ")

//let x = passenger.value("name")

//print("\(data["name"])")

//let myV = airports.value(key: "YVR")
