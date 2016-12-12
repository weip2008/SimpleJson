//: [Previous](@previous)

import Foundation

let data = DataManager.getData(byName: "topapps")
let jsonWithObjectRoot = try? JSONSerialization.jsonObject(with: data, options: [])

//print (jsonWithObjectRoot ?? "null")

let json = JSONType(jsonWithObjectRoot)

let rs = Response(JSON: json)

//print(rs ?? "Reseponse is null")
//print(rs?.feed ?? "feed is null")
//print(rs?.feed?.author ?? "author is null")
//print(rs?.feed?.link ?? "link is null")

print(rs?.feed?.entry?[0].name ?? "name is null")
print(rs?.feed?.entry?[0].image ?? "image is null")

//: [Next](@next)
