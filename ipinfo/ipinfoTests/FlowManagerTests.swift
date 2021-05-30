//
//  FlowManagerTests.swift
//  ipinfoTests
//
//  Created by Oleksandr Vasildzhahaz on 30.05.2021.
//

import XCTest

class RootPresenterSpy: RootPresenter {
    weak var expectation: XCTestExpectation?
    
    func present(_ presentable: RootPresentable) {
        expectation?.fulfill()
    }
}

class RouterSpy: Router {
    weak var expectation: XCTestExpectation?
    weak var presentable: RootPresentable?
    
    var callsCompletion: Bool = true
    var callsExpectation: Bool = true
    
    // Dont forget to assign rootpresentable!
    func start(_ completion: (RootPresentable) -> Void) {
        if callsCompletion { completion(presentable!) }
        if callsExpectation { expectation?.fulfill() }
    }
}

class RootPresentableSpy: RootPresentable { }

class FlowManagerTests: XCTestCase {

    var router: RouterSpy!
    var rootPresenter: RootPresenterSpy!
    var presentable: RootPresentableSpy!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        router = RouterSpy()
        rootPresenter = RootPresenterSpy()
        presentable = RootPresentableSpy()
        router.presentable = presentable
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCallsStart() throws {
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 1
        router.expectation = expectation
        let sut = FlowManager(with: rootPresenter, mainRouter: router)
        sut.setupMainFlow()
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testCallsPresentAfterStart() throws {
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 1
        rootPresenter.expectation = expectation
        let sut = FlowManager(with: rootPresenter, mainRouter: router)
        sut.setupMainFlow()
        wait(for: [expectation], timeout: 0.1)
    }
}
