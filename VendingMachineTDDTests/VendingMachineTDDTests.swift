//
//  VendingMachineTDDTests.swift
//  VendingMachineTDDTests
//
//  Created by 최혜선 on 01/06/2019.
//  Copyright © 2019 jamie. All rights reserved.
//

import XCTest

/// 음료 클래스
class Drink {
    /// 금액
    private var price: Int = 0
    
    init(_ price: Int) {
        self.price = price
    }
    
    /// 선택한 음료 금액 리턴
    func getPrice() -> Int {
        return price
    }
}

/// 코인 클래스
class Coin {
    /// 동전 단위
    enum CoinUnit: Int {
        case krw10 = 10
        case krw50 = 50
        case krw100 = 100
        case krw500 = 500
    }
    
    /// 전체 금액
    var deposit: Int = 0
    
    /// 동전 투입
    /// - parameter input: 동전 단위
    func insertCoin(_ input: CoinUnit) {
        self.deposit += input.rawValue
    }
    
    /// 음료 구매
    /// - parameter drink: 음료
    func getDrink(_ drink: Drink) {
        self.deposit -= drink.getPrice()
    }
    
    /// 전체 금액
    /// - Returns: 전체 금액
    func getTotalCoin() -> Int {
        return deposit
    }
    
    /// 동전 단위 갯수 구하기
    /// - parameter base: 가져올 동전
    /// - Returns: 동전 개수
    func calculateCoinCount(_ base: CoinUnit) -> Int {
        var totalCoinCount: Int = 0
        let baseCoin = base.rawValue
        if deposit / baseCoin > 0 {
            totalCoinCount += Int(deposit / baseCoin)
            deposit -= (Int(deposit / baseCoin) * baseCoin)
        }
        return totalCoinCount
    }
}

/// 자판기 클래스
class VendingMachine {
    enum InsertError: Error {
        case invalidation
    }
    
    enum BuyError: Error {
        case notEnoughMoney
    }
    
    private var deposit: Int = 0
    private var coin = Coin()
    
    func insertMoney(_ input: Int) throws {
        guard let insertCoin = Coin.CoinUnit(rawValue: input) else {
            throw InsertError.invalidation
        }
        coin.insertCoin(insertCoin)
    }
    
    func getTotalMoney() -> Int {
        return coin.getTotalCoin()
    }
    
    func getDrink(_ drink: Drink) throws {
        if drink.getPrice() > getTotalMoney() {
            throw BuyError.notEnoughMoney
        }
        coin.getDrink(drink)
    }
    
    func getCoinsCount(_ unit: Int) -> Int {
        guard let coin = Coin.CoinUnit(rawValue: unit) else {
            return 0
        }
        return self.coin.calculateCoinCount(coin)
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
