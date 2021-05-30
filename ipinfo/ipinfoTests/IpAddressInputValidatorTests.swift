//
//  IpAddressInputValidatorTests.swift
//  ipinfoTests
//
//  Created by Oleksandr Vasildzhahaz on 30.05.2021.
//

import XCTest

class IpAddressInputValidatorTests: XCTestCase {

    lazy var sut: IpAddressInputValidator = { IpAddressInputValidator() }()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAllowsCorrectInput() throws {
        XCTAssertTrue(sut.shouldHandle(input: "0"))
        XCTAssertTrue(sut.shouldHandle(input: "1"))
        XCTAssertTrue(sut.shouldHandle(input: "2"))
        XCTAssertTrue(sut.shouldHandle(input: "3"))
        XCTAssertTrue(sut.shouldHandle(input: "4"))
        XCTAssertTrue(sut.shouldHandle(input: "5"))
        XCTAssertTrue(sut.shouldHandle(input: "6"))
        XCTAssertTrue(sut.shouldHandle(input: "7"))
        XCTAssertTrue(sut.shouldHandle(input: "8"))
        XCTAssertTrue(sut.shouldHandle(input: "9"))
        XCTAssertTrue(sut.shouldHandle(input: "."))
        XCTAssertTrue(sut.shouldHandle(input: "0.0.0.1"))
        XCTAssertTrue(sut.shouldHandle(input: "255.255.255.255"))
    }
    
    func testNotAllowsIncorrectInput() throws {
        XCTAssertFalse(sut.shouldHandle(input: "!"))
        XCTAssertFalse(sut.shouldHandle(input: "@"))
        XCTAssertFalse(sut.shouldHandle(input: "#"))
        XCTAssertFalse(sut.shouldHandle(input: "$"))
        XCTAssertFalse(sut.shouldHandle(input: "%"))
        XCTAssertFalse(sut.shouldHandle(input: "^"))
        XCTAssertFalse(sut.shouldHandle(input: "&"))
        XCTAssertFalse(sut.shouldHandle(input: "*"))
        XCTAssertFalse(sut.shouldHandle(input: "("))
        XCTAssertFalse(sut.shouldHandle(input: ")"))
        XCTAssertFalse(sut.shouldHandle(input: "~"))
        XCTAssertFalse(sut.shouldHandle(input: "Q"))
        XCTAssertFalse(sut.shouldHandle(input: "W"))
        XCTAssertFalse(sut.shouldHandle(input: "E"))
        XCTAssertFalse(sut.shouldHandle(input: "R"))
        XCTAssertFalse(sut.shouldHandle(input: "T"))
        XCTAssertFalse(sut.shouldHandle(input: "Y"))
        XCTAssertFalse(sut.shouldHandle(input: "U"))
        XCTAssertFalse(sut.shouldHandle(input: "I"))
        XCTAssertFalse(sut.shouldHandle(input: "O"))
        XCTAssertFalse(sut.shouldHandle(input: "P"))
        XCTAssertFalse(sut.shouldHandle(input: "A"))
        XCTAssertFalse(sut.shouldHandle(input: "S"))
        XCTAssertFalse(sut.shouldHandle(input: "D"))
        XCTAssertFalse(sut.shouldHandle(input: "F"))
        XCTAssertFalse(sut.shouldHandle(input: "G"))
        XCTAssertFalse(sut.shouldHandle(input: "H"))
        XCTAssertFalse(sut.shouldHandle(input: "J"))
        XCTAssertFalse(sut.shouldHandle(input: "K"))
        XCTAssertFalse(sut.shouldHandle(input: "L"))
        XCTAssertFalse(sut.shouldHandle(input: "Z"))
        XCTAssertFalse(sut.shouldHandle(input: "X"))
        XCTAssertFalse(sut.shouldHandle(input: "C"))
        XCTAssertFalse(sut.shouldHandle(input: "V"))
        XCTAssertFalse(sut.shouldHandle(input: "B"))
        XCTAssertFalse(sut.shouldHandle(input: "N"))
        XCTAssertFalse(sut.shouldHandle(input: "M"))
        XCTAssertFalse(sut.shouldHandle(input: "["))
        XCTAssertFalse(sut.shouldHandle(input: "]"))
        XCTAssertFalse(sut.shouldHandle(input: "\\"))
        XCTAssertFalse(sut.shouldHandle(input: ";"))
        XCTAssertFalse(sut.shouldHandle(input: "'"))
        XCTAssertFalse(sut.shouldHandle(input: ","))
        XCTAssertFalse(sut.shouldHandle(input: "/"))
        XCTAssertFalse(sut.shouldHandle(input: "-"))
        XCTAssertFalse(sut.shouldHandle(input: "="))
        XCTAssertFalse(sut.shouldHandle(input: "+"))
    }
    
    func testAcceptsCorrectAddresses() throws {
        XCTAssertTrue(sut.isValid(input: "0.0.0.0"))
        XCTAssertTrue(sut.isValid(input: "0.0.0.1"))
        XCTAssertTrue(sut.isValid(input: "0.0.1.0"))
        XCTAssertTrue(sut.isValid(input: "0.1.0.0"))
        XCTAssertTrue(sut.isValid(input: "1.0.0.0"))
        
        XCTAssertTrue(sut.isValid(input: "0.0.0.10"))
        XCTAssertTrue(sut.isValid(input: "0.0.10.0"))
        XCTAssertTrue(sut.isValid(input: "0.10.0.0"))
        XCTAssertTrue(sut.isValid(input: "10.0.0.0"))
        
        XCTAssertTrue(sut.isValid(input: "0.0.0.100"))
        XCTAssertTrue(sut.isValid(input: "0.0.100.0"))
        XCTAssertTrue(sut.isValid(input: "0.100.0.0"))
        XCTAssertTrue(sut.isValid(input: "100.0.0.0"))
        
        XCTAssertTrue(sut.isValid(input: "0.0.0.200"))
        XCTAssertTrue(sut.isValid(input: "0.0.200.0"))
        XCTAssertTrue(sut.isValid(input: "0.200.0.0"))
        XCTAssertTrue(sut.isValid(input: "200.0.0.0"))
        
        XCTAssertTrue(sut.isValid(input: "0.0.0.255"))
        XCTAssertTrue(sut.isValid(input: "0.0.255.0"))
        XCTAssertTrue(sut.isValid(input: "0.255.0.0"))
        XCTAssertTrue(sut.isValid(input: "255.0.0.0"))
        
        XCTAssertTrue(sut.isValid(input: "100.100.100.100"))
        XCTAssertTrue(sut.isValid(input: "200.200.200.200"))
        XCTAssertTrue(sut.isValid(input: "255.255.255.255"))
        XCTAssertTrue(sut.isValid(input: "121.56.48.99"))
    }
    
    func testNotAcceptsIncorrectAddresses() throws {
        XCTAssertFalse(sut.isValid(input: "-1.0.0.0"))
        XCTAssertFalse(sut.isValid(input: "0.-1.0.0"))
        XCTAssertFalse(sut.isValid(input: "0.0.-1.0"))
        XCTAssertFalse(sut.isValid(input: "0.0.0.-1"))
        
        XCTAssertFalse(sut.isValid(input: "-10.0.0.0"))
        XCTAssertFalse(sut.isValid(input: "0.-10.0.0"))
        XCTAssertFalse(sut.isValid(input: "0.0.-10.0"))
        XCTAssertFalse(sut.isValid(input: "0.0.0.-10"))
        
        XCTAssertFalse(sut.isValid(input: "-100.0.0.0"))
        XCTAssertFalse(sut.isValid(input: "0.-100.0.0"))
        XCTAssertFalse(sut.isValid(input: "0.0.-100.0"))
        XCTAssertFalse(sut.isValid(input: "0.0.0.-100"))
        
        XCTAssertFalse(sut.isValid(input: "-200.0.0.0"))
        XCTAssertFalse(sut.isValid(input: "0.-200.0.0"))
        XCTAssertFalse(sut.isValid(input: "0.0.-200.0"))
        XCTAssertFalse(sut.isValid(input: "0.0.0.-200"))
        
        XCTAssertFalse(sut.isValid(input: "-255.0.0.0"))
        XCTAssertFalse(sut.isValid(input: "0.-255.0.0"))
        XCTAssertFalse(sut.isValid(input: "0.0.-255.0"))
        XCTAssertFalse(sut.isValid(input: "0.0.0.-255"))
        
        XCTAssertFalse(sut.isValid(input: "256.0.0.0"))
        XCTAssertFalse(sut.isValid(input: "0.256.0.0"))
        XCTAssertFalse(sut.isValid(input: "0.0.256.0"))
        XCTAssertFalse(sut.isValid(input: "0.0.0.256"))
        
        XCTAssertFalse(sut.isValid(input: "300.0.0.0"))
        XCTAssertFalse(sut.isValid(input: "0.300.0.0"))
        XCTAssertFalse(sut.isValid(input: "0.0.300.0"))
        XCTAssertFalse(sut.isValid(input: "0.0.0.300"))
    }
}
