/*
 The observer pattern is used to allow an object publish changes to its state.
 Other objects subscribe to be immediately notified of any changes.
 */

protocol PropertyObserver: class {
    func willChange(propertyName: String, newPropertyValue: Any?)
    func didChange(propertyName: String, oldPropertyValue: Any?)
}

final class TestChambers {
    weak var observer: PropertyObserver?
    
    private let testChamberNumberName = "testChamberNumber"
    
    var testChamberNumber: Int = 0 {
        willSet {
            observer?.willChange(propertyName: testChamberNumberName, newPropertyValue: newValue)
        }
        didSet {
            observer?.didChange(propertyName: testChamberNumberName, oldPropertyValue: oldValue)
        }
    }
}

final class Observer: PropertyObserver {
    func willChange(propertyName: String, newPropertyValue: Any?) {
        guard let newValue = newPropertyValue as? Int else { return }
        print(newValue)
    }
    
    func didChange(propertyName: String, oldPropertyValue: Any?) {
        guard let oldValue = oldPropertyValue as? Int else { return }
        print(oldValue)
    }
}

/// Usage:

var observerInstance = Observer()
var testChambers = TestChambers()
testChambers.observer = observerInstance
testChambers.testChamberNumber += 1

testChambers.testChamberNumber += 1

testChambers.testChamberNumber += 1
