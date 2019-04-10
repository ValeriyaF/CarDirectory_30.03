import Foundation

class UserConnection {
    
    private enum CommandsStr: String {
        case showHelp = "h"
        case showAllCars = "all"
        case addCar = "add"
        case updateCar = "upd"
        case removeCar = "rm"
        case close = "esc"
    }
    
    private enum StatusMessages: String {
        case successMsg = "Success"
        case wrongMsg = "Something went wrong"
        case invCmdMsg = "Invalid command"
        case invIndxMsg = "Invalid index"
        case noIndxMsg = "No such index"
        case emptyMsg = "Empty"
        case furtherInpMsg = "Print № of the car or esc to exit"
        case escapingMsg = "See you later"
    }
    
    internal func getUserCommand() -> Commands {
        while let input = readLine() {
            switch input {
            case CommandsStr.showHelp.rawValue:
                return Commands.showHelp
            case CommandsStr.showAllCars.rawValue:
                return Commands.showAllCars
            case CommandsStr.addCar.rawValue:
                return Commands.addCar
            case CommandsStr.removeCar.rawValue:
                return Commands.removeCar
            case CommandsStr.updateCar.rawValue:
                return Commands.updateCar
            case CommandsStr.close.rawValue:
                return Commands.close
            default:
                print(StatusMessages.invCmdMsg.rawValue)
            }
        }
        
        return Commands.close
    }
    
    internal func printHelp() {
        print("""
                ---------------------------------------
                Print '\(CommandsStr.showHelp.rawValue)' to show help
                Print '\(CommandsStr.showAllCars)' to show all your cars
                Print '\(CommandsStr.addCar.rawValue)' to add a new car
                Print '\(CommandsStr.updateCar.rawValue)' to update your car by №
                Print '\(CommandsStr.removeCar.rawValue)' to remove your car by №
                    Print '\(CommandsStr.close.rawValue)' to exit
                ---------------------------------------
                """)
    }
    
    internal func printSuccessMsg() {
        print(StatusMessages.successMsg.rawValue)
    }
    
    internal func printWrongMsg() {
        print(StatusMessages.wrongMsg.rawValue)
    }
    
    internal func showAllCars(from cars: [Car]) {
        if cars.count == 0 { print("Empty"); return }
        for car in cars {
            print("Car №\(String(describing: cars.firstIndex(where: { $0 === car })!))")
            for property in Car.Property.allValues {
                print("\(property): \(car[property])")
            }
            print("\n")
        }
    }
    
    internal func getNewCar() -> Car {
        let newCar: Car = Car()
        
        for property in Car.Property.allValues {
            print("Print \(property) or press enter:")
            newCar[property] = readLine() ?? ""
        }
        
        return newCar
    }
    
    internal func getCurrentCar(from cars: [Car]) -> Car? {
        print(StatusMessages.furtherInpMsg.rawValue)
        
        while let input = readLine() {
            
            if input == CommandsStr.close.rawValue {
                print(StatusMessages.escapingMsg.rawValue)
                return nil
            }
            
            guard let index = Int(input) else {
                print(StatusMessages.invIndxMsg.rawValue)
                continue
            }
            
            if cars.indices.contains(index) {
                return cars[index]
            } else { print(StatusMessages.noIndxMsg.rawValue); continue }
        }
        
        return nil
    }
    
}
