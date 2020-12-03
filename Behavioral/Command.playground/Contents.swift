/*
 The command pattern is used to express a request,
 including the call to be made and all of its required parameters, in a command object.
 The command may then be executed immediately or held for later use.
 */

protocol DoorCommand {
    func execute() -> String
}

final class OpenDoors: DoorCommand {
    let doors: String
    
    init(doors: String) {
        self.doors = doors
    }
    
    func execute() -> String {
        return "Open \(doors)"
    }
}

final class CloseDoors: DoorCommand {
    let doors: String
    
    init(doors: String) {
        self.doors = doors
    }
    
    func execute() -> String {
        return "Close \(doors)"
    }
}

final class HAL9000DoorsOperations {
    let openCommand: DoorCommand
    let closeCommand: DoorCommand
    
    init(doors: String) {
        self.openCommand = OpenDoors(doors: doors)
        self.closeCommand = CloseDoors(doors: doors)
    }
    
    func open() {
        openCommand.execute()
    }
    
    func close() {
        closeCommand.execute()
    }
}

/// Usage:

let podBayDoors = "Pod Bay Doors"
let doorModule = HAL9000DoorsOperations(doors: podBayDoors)

doorModule.open()
doorModule.close()
