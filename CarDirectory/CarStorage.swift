import Foundation

class CarStorage {
    
    private var fileURL: URL
    public private(set) var cars: [Car] = []
    init() {
        let directiryURL = FileManager.default.homeDirectoryForCurrentUser
        fileURL = directiryURL.appendingPathComponent("cars.txt")
        cars = load()
    }
    
    
    func append(car: Car) -> Bool {
        assert(!cars.contains(where: { car === $0 }))
        cars.append(car)
        return save()
    }
    
    func remove(car: Car) -> Bool {
        assert(cars.contains(where: { car === $0 }))
        cars.removeAll { $0 === car }
        return save()
    }
    
    func modify(from oldCar: Car, to newCar: Car) -> Bool {
        assert(cars.contains(where: { oldCar === $0 }))
        if let index = cars.firstIndex(where: { oldCar === $0 }) {
            cars[index] = newCar
            return save()
        }
        return false
    }
    
    private func save() -> Bool {
        
        if let data: Data = try? JSONEncoder().encode(cars) {
            return nil != ( try? data.write(to: fileURL))
        }
        
        return false
    }
    
    internal func load() -> [Car] {
        do {
            let data = try Data(contentsOf: fileURL)
            return try JSONDecoder().decode([Car].self, from: data)
        } catch {
            print("Load error \(error.localizedDescription)")
            return []
        }
    }
}

