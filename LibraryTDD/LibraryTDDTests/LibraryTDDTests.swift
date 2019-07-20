//
//  LibraryTDDTests.swift
//  LibraryTDDTests
//
//  Created by 최혜선 on 18/07/2019.
//  Copyright © 2019 jamie. All rights reserved.
//

import XCTest

struct Book {
    var title: String
    var author: String
    var publisher: String
    var isLoan: Bool
    var resvCount: Int
    
    enum LoanError: Error {
        case loanError
        case resvFullError
    }
    
    mutating func loan() throws {
        guard !isLoan else {
            throw LoanError.loanError
        }
        
        self.isLoan = true
    }
    
    mutating func reservation() throws {
        guard resvCount != 5 else {
            throw LoanError.resvFullError
        }
    }
}

class Library {
    private var books: [Book] = []
    
    init() {
        books.append(Book(title: "테스트 주도 개발", author: "켄트 벡", publisher: "인사이트(insight)", isLoan: false, resvCount: 5))
        books.append(Book(title: "여행의 이유", author: "김영하", publisher: "문학동네", isLoan: true, resvCount: 3))
        books.append(Book(title: "설민석의 삼국지 ", author: "설민석", publisher: "세계사", isLoan: false, resvCount: 0))
        books.append(Book(title: "아주 작은 습관의 힘", author: "제임스 클리어", publisher: "비즈니스북스", isLoan: true, resvCount: 4))
        books.append(Book(title: "죽음 1", author: "베르나르 베르베르", publisher: "열린책들", isLoan: false, resvCount: 0))
        books.append(Book(title: "Go Go 카카오프렌즈 9", author: "김미영", publisher: "아울북", isLoan: true, resvCount: 0))
    }
    
    func isExistBookHaveTitle(_ title: String) -> Bool {
        return books.contains { $0.title == title }
    }
    
    func getBook(title: String) -> Book {
        return books.filter { $0.title.contains(title) }.first!
    }
}

class LibraryTDDTests: XCTestCase {
    
    let library = Library()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testIsHaveBookInLibrary() {
        XCTAssertTrue(library.isExistBookHaveTitle("테스트 주도 개발"))
        XCTAssertFalse(library.isExistBookHaveTitle("책"))
    }
    
    func testIsOnLoan() {
        // 책 대출 여부 확인
        let oneBook = library.getBook(title: "테스트 주도 개발")
        XCTAssertEqual(false, oneBook.isLoan)
    }
    
    func testLoanTheBook() {
        var bookToLoan = library.getBook(title: "여행의 이유")
        XCTAssertThrowsError(try bookToLoan.loan())
        
        var bookToLoan2 = library.getBook(title: "테스트 주도 개발")
        XCTAssertNoThrow(try bookToLoan2.loan())
    }
    
    func testReservationTheBook() {
        var bookToResv = library.getBook(title: "테스트 주도 개발")
        XCTAssertThrowsError(try bookToResv.reservation())
    }
}
