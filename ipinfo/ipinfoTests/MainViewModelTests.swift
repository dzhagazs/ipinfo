//
//  MainViewModelTests.swift
//  ipinfoTests
//
//  Created by Oleksandr Vasildzhahaz on 30.05.2021.
//

import XCTest

class IPApiSpy: IPAPIProtocol {
    
    weak var expectation: XCTestExpectation?
    
    init(resultModel: Result<IPSearchResultModel, Error>) {
        self.resultModel = resultModel
    }
    
    let resultModel: Result<IPSearchResultModel, Error>
    
    func searchIP(with term: String, completion: @escaping ResultCallback<IPSearchResultModel>) {
        completion(resultModel)
        expectation?.fulfill()
    }
}

class MainRouteHandlerSpy: MainRouteHandler {
    
    weak var expectation: XCTestExpectation?

    func handle(route: MainRoute) {
        expectation?.fulfill()
    }
}

class MainViewModelPresenterSpy: MainViewModelPresenter {
    var viewModel: MainViewModelProtocol?
    var title: String?
    var subtitle: String?
    var searchButtonTitle: String?
    var searchText: String?
    var searchEnabled: Bool?
    var loadingShown: Bool?
    func update(title: String) {
        self.title = title
    }
    func update(subtitle: String) {
        self.subtitle = subtitle
    }
    func update(searchButtonTitle: String) {
        self.searchButtonTitle = searchButtonTitle
    }
    func update(searchText: String) {
        self.searchText = searchText
    }
    func setSearch(enabled: Bool) {
        self.searchEnabled = enabled
    }
    func showLoadingIndicator() {
        self.loadingShown = true
    }
    func hideLoadingIndicator() {
        self.loadingShown = false
    }
}

class MainViewModelTests: XCTestCase {

    var validApi: IPApiSpy!
    var errorApi: IPApiSpy!
    var routeHandler: MainRouteHandlerSpy!
    var presenter: MainViewModelPresenterSpy!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        validApi = IPApiSpy(resultModel: .success(IPSearchResultModel(with: [])))
        errorApi = IPApiSpy(resultModel: .failure(ErrorConstants.emptyResponse))
        routeHandler = MainRouteHandlerSpy()
        presenter = MainViewModelPresenterSpy()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoadsCorrectly() throws {
        let sut = validSut()
        
        XCTAssertNil(presenter.title)
        XCTAssertNil(presenter.subtitle)
        sut.viewDidLoad()
        XCTAssertEqual(presenter.title, "API Demo")
        XCTAssertEqual(presenter.subtitle, "Search any IP address")
        XCTAssertEqual(presenter.searchButtonTitle, "Search")
        
        XCTAssertNil(presenter.searchText)
        XCTAssertEqual(presenter.searchEnabled, false)
        XCTAssertNil(presenter.loadingShown)
    }
    
    func testManagesInputCorrectly() throws {
        let sut = validSut()
        
        XCTAssertFalse(sut.shouldHandleInput(text: "abc"))
        XCTAssertTrue(sut.shouldHandleInput(text: "1."))
        
        XCTAssertThrowsError(try sut.handleInput(text: "abc"))
        XCTAssertNoThrow(try sut.handleInput(text: "1."))
        
        XCTAssertEqual(sut.searchTerm, "1.")
        
        XCTAssertNoThrow(try sut.handleInput(text: "1.0.0.0"))
        XCTAssertEqual(sut.searchTerm, "1.0.0.0")
    }
    
    func testEnablesSearchOnCorrectInput() throws {
        let sut = validSut()
                
        XCTAssertNoThrow(try sut.handleInput(text: "1.0.0.0"))
        XCTAssertEqual(presenter.searchEnabled, true)
    }
    
    func testDisablesSearchOnIncorrectInput() throws {
        let sut = validSut()
                
        XCTAssertNoThrow(try sut.handleInput(text: "1.0.0.0"))
        XCTAssertEqual(presenter.searchEnabled, true)
        
        XCTAssertNoThrow(try sut.handleInput(text: "1.0.0."))
        XCTAssertEqual(presenter.searchEnabled, false)
    }
    
    func testSkipsSearchActionOnInvalidInput() throws {
        let sut = validSut()
        
        let expectation = XCTestExpectation()
        expectation.isInverted = true
        validApi.expectation = expectation
        
        try? sut.handleInput(text: "1.0.0.")
        
        sut.searchAction()
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testPerformsSearchAndRoute() throws {
        let sut = validSut()
        
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 2
        validApi.expectation = expectation
        routeHandler.expectation = expectation
        
        try? sut.handleInput(text: "1.0.0.1")
        
        sut.searchAction()
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testPerformsSearchAndNotRouteOnError() throws {
        let sut = inValidSut()
        
        let apiExpectation = XCTestExpectation()
        errorApi.expectation = apiExpectation
        
        let routeExpectation = XCTestExpectation()
        routeExpectation.isInverted = true
        routeHandler.expectation = routeExpectation
        
        try? sut.handleInput(text: "1.0.0.1")
        
        sut.searchAction()
        
        wait(for: [apiExpectation, routeExpectation], timeout: 0.1)
    }
    
    // MARK: Helper functions
    
    private func validSut() -> MainViewModel {
        let sut = MainViewModel(ipApi: validApi, routeHandler: routeHandler)
        
        presenter.viewModel = sut
        sut.presenter = presenter
        return sut
    }
    
    private func inValidSut() -> MainViewModel {
        let sut = MainViewModel(ipApi: errorApi, routeHandler: routeHandler)
        
        presenter.viewModel = sut
        sut.presenter = presenter
        return sut
    }
}
