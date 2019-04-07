import Foundation

class Car: Codable {
    enum  Property: String {
        case year
        case model
        case manufactorer
        case `class`
        case bodyType
        
        static let allValues: [Property] = [.year, .model, .manufactorer, .class, .bodyType]
    }
    
    private var data: [String] = []
    
    
    subscript(property: Property) -> String {
        get {
            if let  index = Property.allValues.firstIndex(of: property), index < data.count {
                return data[index]
            }
            return ""
        }
        set {
            if let  index = Property.allValues.firstIndex(of: property)  {
                while data.count <= index {
                    data.append("")
                }
                data[index] = newValue
            }
        }
    }
    
    init() {
        data = [String](repeating: "", count: Property.allValues.count)
        
    }
    
    required init(from decoder: Decoder) throws {
        let container =  try decoder.singleValueContainer()
        data = try container.decode([String].self)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(data)
    }
}

