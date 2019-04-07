import Foundation

class СarDirectory {
    private let carStorage: CarStorage
    private let userConnection = UserConnection()
    
    init(carStorage: CarStorage) {
        self.carStorage = carStorage
    }
    
    internal func run() {
        userConnection.showHelp()
        while (true) {
            switch userConnection.getUserComand() {
            case Commands.close:
                exit(0)
            case Commands.addCar:
                if carStorage.append(car: userConnection.getNewCar()) {
                    userConnection.printSuccessMsg()
                } else { userConnection.printWrongMsg() }
            case Commands.removeCar:
                let currentCar = userConnection.getCurrentCar(from: carStorage.cars)
                if let currentCar = currentCar {
                    if carStorage.remove(car: currentCar) {
                        userConnection.printSuccessMsg()
                    } else { userConnection.printWrongMsg() }
                }
            case Commands.updateCar:
                let currentCar = userConnection.getCurrentCar(from: carStorage.cars)
                if let currentCar = currentCar {
                    let newCar = userConnection.getNewCar()
                    if carStorage.modify(from: currentCar, to: newCar) {
                        userConnection.printSuccessMsg()
                    } else { userConnection.printWrongMsg() }
                }
            case Commands.showAllCars:
                userConnection.showAllCars(from: carStorage.cars)
            }
        }
    }
}
