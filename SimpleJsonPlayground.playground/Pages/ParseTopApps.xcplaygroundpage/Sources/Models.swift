import Foundation

public struct Response: JSONConvertable {
    public var feed: Feed?
    
    public init?(JSON: JSONType?) {
        guard let Json = JSON else { return nil }
//        guard case .dictionary(let dictionary) = Json else { return nil }
        
        feed = Feed(JSON: Json.jsonValue("feed"))
        
    }
}

public struct Feed: JSONConvertable {
    public var author: Author?
    public var entry: [MKEntry]?
    public var updated: Label?
    public var rights: Label?
    public var title: Label?
    public var icon: Label?
    public var link: [MKLink]?
    public var id: Label?
    
    public init?(JSON: JSONType?) {
        guard let Json = JSON else { return nil }
        guard case .dictionary(let dictionary) = Json else { return nil }
        
        author = Author(JSON: Json.jsonValue("author"))
        updated = Label(JSON: Json.jsonValue("updated"))
        rights = Label(JSON: Json.jsonValue("rights"))
        title = Label(JSON: Json.jsonValue("title"))
        icon = Label(JSON: Json.jsonValue("icon"))
        id = Label(JSON: Json.jsonValue("id"))
    
        
        let jsonArray = JSONType(dictionary.values("link"))
        link = jsonArray.values()

        let jsonArrayEntry = JSONType(dictionary["entry"])
        entry = jsonArrayEntry.values()

    }
}

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

public struct MKLink: JSONConvertable {
    public var attributes: Attribute?
    
    public init?(JSON: JSONType?) {
        guard let Json = JSON else { return nil }
//        guard case .dictionary(let dictionary) = Json else { return nil }
        
        attributes = Attribute(JSON: Json.jsonValue("attributes"))
    }
}

public struct Attribute: JSONConvertable {
    public var rel: String?
    public var type: String?
    public var href: String?
    
    public init?(JSON: JSONType?) {
        guard let Json = JSON else { return nil }
        guard case .dictionary(let dictionary) = Json else { return nil }
        
        rel = dictionary.values("rel")
        type = dictionary.values("type")
        href = dictionary.values("href")
    }
}

public struct MKEntry: JSONConvertable {
    public var name: Label?
    public var summary: Label?
    public var image: [MKImage]?
    
    public init?(JSON: JSONType?) {
        guard let Json = JSON else { return nil }
        guard case .dictionary(let dictionary) = Json else { return nil }
        
        name = Label(JSON: Json.jsonValue("im:name"))
        summary = Label(JSON: Json.jsonValue("summary"))
        
        let jsonArrayEntry = JSONType(dictionary.values("im:image"))
        image = jsonArrayEntry.values()
        
    }
}

public struct MKImage: JSONConvertable {
    public var label: String?
    public var attributes: ImageAttripute?
    
    public init?(JSON: JSONType?) {
        guard let Json = JSON else { return nil }
        guard case .dictionary(let dictionary) = Json else { return nil }
    
        label = dictionary.values("label")
        
        let jsonType = JSONType(dictionary.values("attributes"))
        attributes = ImageAttripute(JSON: jsonType)
    }
}

public struct ImageAttripute: JSONConvertable {
    public var height: String?
    public var width: String?
    
    public init?(JSON: JSONType?) {
        guard let Json = JSON else { return nil }
        guard case .dictionary(let dictionary) = Json else { return nil }
        
        height = dictionary.values("height")
        width = dictionary.values("width")
    }
}
