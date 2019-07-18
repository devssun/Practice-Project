//
//  LibraryTDDTests.swift
//  LibraryTDDTests
//
//  Created by 최혜선 on 18/07/2019.
//  Copyright © 2019 jamie. All rights reserved.
//

import XCTest

struct Book {
    let title: String
    let author: String
    let publisher: String
}

class Library {
    private var books: [Book] = []
    
    init() {
        books.append(Book(title: "테스트 주도 개발", author: "켄트 벡", publisher: "인사이트(insight)"))
        books.append(Book(title: "여행의 이유", author: "김영하", publisher: "문학동네"))
        books.append(Book(title: "설민석의 삼국지 ", author: "설민석", publisher: "세계사"))
        books.append(Book(title: "아주 작은 습관의 힘", author: "제임스 클리어", publisher: "비즈니스북스"))
        books.append(Book(title: "죽음 1", author: "베르나르 베르베르", publisher: "열린책들"))
        books.append(Book(title: "Go Go 카카오프렌즈 9", author: "김미영", publisher: "아울북"))
    }
    
    func isExistBookHaveTitle(_ title: String) -> Bool {
        return books.contains { $0.title == title }
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
        let oneBook = library.getBook()
        XCTAssertTrue(oneBook.isLoan())
    }
}
