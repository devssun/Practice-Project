//
//  FizzBuzzTDDTests.swift
//  FizzBuzzTDDTests
//
//  Created by 최혜선 on 04/07/2019.
//  Copyright © 2019 jamie. All rights reserved.
//

import XCTest

class FizzBuzz {
    private var number: Int = 0
    
    init(_ number: Int) {
        self.number = number
    }
    
    func checkCurrentNumber() -> String {
        if isMultiplyNumber(3) && isMultiplyNumber(5) {
            return "FizzBuzz"
        }else if isMultiplyNumber(3) {
            return "Fizz"
        }else if isMultiplyNumber(5) {
            return "Buzz"
        }else{
            return "\(number)"
        }
    }

    func is3MultipleNumber() -> String {
        return isMultiplyNumber(3) ? "Fizz" : "\(number)"
    }
    
    
    func is5MultipleNumber() -> String {
        return isMultiplyNumber(5) ? "Buzz" : "\(number)"
    }
    
    
    func is3and5MultipleNumber() -> String {
        return isMultiplyNumber(3) && isMultiplyNumber(5) ? "FizzBuzz" : "\(number)"
    }
    
    func isMultiplyNumber(_ multiply: Int) -> Bool {
        return number % multiply == 0
    }
}

class FizzBuzzTDDTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIs3MultipleNumber() {
        // 1부터 100까지 숫자를 출력하면서 3의 배수는 숫자 대신 "Fizz", 5의 배수는 숫자 대신 "Buzz", 3과 5의 공배수는 숫자 대신 "FizzBuzz"를 출력
        // 그 외는 숫자 출력
        let fizzBuzz = FizzBuzz(3)
        XCTAssertEqual(fizzBuzz.is3MultipleNumber(), "Fizz")
    }
    
    func testIs5MultipleNumber() {
        let fizzBuzz = FizzBuzz(5)
        XCTAssertEqual(fizzBuzz.is5MultipleNumber(), "Buzz")
    }
    
    
    func testIs3and5MultipleNumber() {
        let fizzBuzz = FizzBuzz(15)
        XCTAssertEqual(fizzBuzz.is3and5MultipleNumber(), "FizzBuzz")
    }
    
    
    func testCheckCurrentNumber() {
        let fizzBuzz = FizzBuzz(20)
        XCTAssertEqual(fizzBuzz.checkCurrentNumber(), "Buzz")
    }
}
