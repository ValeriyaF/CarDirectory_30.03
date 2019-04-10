import Foundation

class СarDirectory {
    private let carStorage: CarStorage = CarStorage()
    private let userConnection = UserConnection()
    

    
    internal func run() {
        userConnection.printHelp()
        while (true) {
            switch userConnection.getUserCommand() {
            case Commands.close:
                exit(0)
            case .showHelp:
                userConnection.printHelp()
            case Commands.addCar:
                addCar()
            case Commands.removeCar:
                removeCar()
            case Commands.updateCar:
                updateCar()
            case Commands.showAllCars:
                userConnection.showAllCars(from: carStorage.cars)
            }
        }
    }
    
    private func addCar() {
        if carStorage.append(car: userConnection.getNewCar()) {
            userConnection.printSuccessMsg()
        } else { userConnection.printWrongMsg() }
    }
    
    private func removeCar() {
        let currentCar = userConnection.getCurrentCar(from: carStorage.cars)
        if let currentCar = currentCar {
            if carStorage.remove(car: currentCar) {
                userConnection.printSuccessMsg()
            } else { userConnection.printWrongMsg() }
        }
    }
    
    private func updateCar() {
        let currentCar = userConnection.getCurrentCar(from: carStorage.cars)
        if let currentCar = currentCar {
            let newCar = userConnection.getNewCar()
            if carStorage.modify(from: currentCar, to: newCar) {
                userConnection.printSuccessMsg()
            } else { userConnection.printWrongMsg() }
        }
    }
}
