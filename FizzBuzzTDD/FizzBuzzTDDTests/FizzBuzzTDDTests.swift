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
    
    func is3MultipleNumber() -> String {
        return number % 3 == 0 ? "Fizz" : ""
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
}
