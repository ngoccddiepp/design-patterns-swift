/*
The chain of responsibility pattern is used to process varied requests,
each of which may be dealt with by a different handler.
 */

protocol Withdrawing {
    func withdraw(amount: Int) -> Bool
}

final class MoneyPile: Withdrawing {
    
    let value: Int
    var quantity: Int
    let next: Withdrawing?
    
    init(value: Int, quantity: Int, next: Withdrawing?) {
        self.value = value
        self.quantity = quantity
        self.next = next
    }
    
    func withdraw(amount: Int) -> Bool {
        var amount = amount
        
        func canTakeSomeBill() -> Bool {
            return (amount / self.value) > 0
        }
        
        while canTakeSomeBill() {
            
            if self.quantity == 0 {
                break
            }
            
            amount -= self.value
            self.quantity -= 1
        }
        
        guard amount > 0 else { return true }
        guard let next = self.next else { return false }
        return next.withdraw(amount: amount)
    }
}

final class ATM: Withdrawing {
    private let hundred: Withdrawing
    
    private var startPile: Withdrawing {
        return hundred
    }
    
    init(hundred: Withdrawing) {
        self.hundred = hundred
    }
    
    func withdraw(amount: Int) -> Bool {
        return startPile.withdraw(amount: amount)
    }
}

/// Usage:

// Create piles of money and link them together
let ten = MoneyPile(value: 10, quantity: 6, next: nil)
let tweenty = MoneyPile(value: 20, quantity: 2, next: ten)
let fifty = MoneyPile(value: 50, quantity: 2, next: tweenty)
let hundred = MoneyPile(value: 100, quantity: 1, next: fifty)

// Build ATM
let atm = ATM(hundred: hundred)
atm.withdraw(amount: 100)
atm.withdraw(amount: 100)
atm.withdraw(amount: 100)
atm.withdraw(amount: 100)
atm.withdraw(amount: 100)

