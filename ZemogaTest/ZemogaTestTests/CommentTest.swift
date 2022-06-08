//
//  CommentTest.swift
//  ZemogaTestTests
//
//  Created by Jose Valero Vegazo on 7/06/22.
//

import XCTest
@testable import ZemogaTest

class CommentTest: XCTestCase {
    var comment:[Comment] = []

    func testResponseComment() throws {
        data()
        XCTAssertEqual(comment.count,2,"Add comment Error")
    }
    
    func testRemoverComment() throws {
        data()
        comment.removeAll()
        XCTAssertEqual(comment.count,0,"Remove All Comments")
    }
    
    func data(){
        var com = Comment()
        com.id = 1
        com.body = "Test body"
        com.postId = 1
        comment.append(com)
        
        var com1 = Comment()
        com1.id = 2
        com1.body = "Test body Test body Test body"
        com1.postId = 1
        comment.append(com1)
    }

}
