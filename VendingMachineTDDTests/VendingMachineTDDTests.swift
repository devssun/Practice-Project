//
//  VendingMachineTDDTests.swift
//  VendingMachineTDDTests
//
//  Created by 최혜선 on 01/06/2019.
//  Copyright © 2019 jamie. All rights reserved.
//

import XCTest

class Drink {
    private var price: Int = 0
    
    init(_ price: Int) {
        self.price = price
    }
    
    func getPrice() -> Int {
        return price
    }
}

class Coin {
    enum CoinUnit: Int {
        case krw10 = 10
        case krw50 = 50
        case krw100 = 100
        case krw500 = 500
    }
}

class VendingMachine {
    enum InsertError: Error {
        case invalidation
    }
    
    enum BuyError: Error {
        case notEnoughMoney
    }
    
    private var deposit: Int = 0
    
    func insertMoney(_ input: Int) throws {
        guard Coin.CoinUnit(rawValue: input) != nil else {
            throw InsertError.invalidation
        }
        deposit += input
    }
    
    func getTotalMoney() -> Int {
        return deposit
    }
    
    func getDrink(_ drink: Drink) throws {
        if drink.getPrice() > deposit {
            throw BuyError.notEnoughMoney
        }
        deposit -= drink.getPrice()
    }
    
    private func calculateCointCount(_ base: Int) -> Int {
        var totalCoinCount: Int = 0
        if deposit / base > 0 {
            totalCoinCount += Int(deposit / base)
            deposit -= (Int(deposit / base) * base)
        }
        return totalCoinCount
    }
    
    func getCoinsCount(_ unit: Int) -> Int {
        return calculateCointCount(unit)
    }
}

class VendingMachineTDDTests: XCTestCase {
    private let vendingMachine = VendingMachine()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInsertMoneyValidation() {
        // 1000원까지 넣을 수 있음 10 50 100 500 1000
        XCTAssertNoThrow(try vendingMachine.insertMoney(500))
    }
    
    func testInsertTotalMoney() {
        XCTAssertNoThrow(try vendingMachine.insertMoney(500))
        XCTAssertNoThrow(try vendingMachine.insertMoney(100))
        XCTAssertNoThrow(try vendingMachine.insertMoney(100))
        XCTAssertEqual(vendingMachine.getTotalMoney(), 700)
    }
    
    func testChangeCoinCountPerUnit() {
        XCTAssertNoThrow(try vendingMachine.insertMoney(500))
        XCTAssertNoThrow(try vendingMachine.insertMoney(100))
        XCTAssertNoThrow(try vendingMachine.insertMoney(100))
        XCTAssertNoThrow(try vendingMachine.getDrink(Drink(350)))
        
        XCTAssertEqual(vendingMachine.getCoinsCount(500), 0)
        XCTAssertEqual(vendingMachine.getCoinsCount(100), 3)
        XCTAssertEqual(vendingMachine.getCoinsCount(50), 1)
        XCTAssertEqual(vendingMachine.getCoinsCount(10), 0)
    }
}
