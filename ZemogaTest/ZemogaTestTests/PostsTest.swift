//
//  PostsTest.swift
//  ZemogaTestTests
//
//  Created by Jose Valero Vegazo on 8/06/22.
//

import XCTest
@testable import ZemogaTest

class PostsTest: XCTestCase {
    var posts:[Posts] = []

    func testResponseComment() throws {
        data()
        XCTAssertEqual(posts.count,2,"Add comment Error")
    }
    
    func testRemoverComment() throws {
        data()
        posts.removeAll()
        XCTAssertEqual(posts.count,0,"Remove All Comments")
    }
    
    func data(){
        var pos = Posts()
        pos.id = 1
        pos.title = "title 1"
        pos.author = "test"
        pos.body = "test test test test"
        pos.favorite = true
        posts.append(pos)
        
        var pos1 = Posts()
        pos1.id = 2
        pos1.title = "title 2"
        pos1.author = "ios"
        pos1.body = "ios test ios test ios test ios test ios test"
        pos.favorite = false
        posts.append(pos1)
    }
}
