//
//  ProfilesTest.swift
//  ZemogaTestTests
//
//  Created by Jose Valero Vegazo on 8/06/22.
//

import XCTest
@testable import ZemogaTest

class ProfilesTest: XCTestCase {

    var profiles:[Profiles] = []

    func testResponseComment() throws {
        data()
        XCTAssertEqual(profiles.count,2,"Add comment Error")
    }
    
    func testRemoverComment() throws {
        data()
        profiles.removeAll()
        XCTAssertEqual(profiles.count,0,"Remove All Comments")
    }
    
    func data(){
        var pro = Profiles()
        pro.name = "jose"
        pro.email = "test@email.com"
        pro.phone = "99776655"
        pro.website = "web.com"
        profiles.append(pro)
        
        var pro1 = Profiles()
        pro1.name = "jose1"
        pro1.email = "test1@email.com"
        pro1.phone = "99776644"
        pro1.website = "www.bbb.com"
        profiles.append(pro1)
    }

}
