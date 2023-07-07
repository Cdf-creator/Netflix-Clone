//
//  Netflix_CloneTests.swift
//  Netflix CloneTests
//
//  Created by Olanrewaju Olakunle  on 15/10/2022.
//

import XCTest
@testable import Netflix_Clone

class GetTrendingMoviesTests: XCTestCase {
    
    var sut: APICaller!
    var mock: MockAPICaller!
    
    override func setUp() {
        super.setUp()
        sut = APICaller()
        mock = MockAPICaller()
    }
    
    override func tearDown() {
        sut = nil
        mock = nil
        super.tearDown()
    }

    func testGetTrendingMovies_Success() {
            let expectation = XCTestExpectation(description: "Get trending movies")
        
        sut.getTrendingMovies { result in
                switch result {
                case .success(let titles):
                    XCTAssertFalse(titles.isEmpty, "Returned titles should not be empty")
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail("Failed to get trending movies with error: \(error.localizedDescription)")
                }
            }
            wait(for: [expectation], timeout: 5.0)
        }
    
    func testGetTrendingMovies_Failure(){
        let expectation = XCTestExpectation(description: "Get trending movies Error")
        
        mock.getTrendingMovies { result in
            switch result {
            case .success(_):
                XCTFail("Fetching discover movies should have failed")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, APIError.FailedTogetData.localizedDescription, "Returned error should match APIError.FailedTogetData")
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
}

class SearchedMoviesTests: XCTestCase {

    var sut: APICaller!
    var mock: MockAPICaller!
    
    override func setUp() {
        super.setUp()
        sut = APICaller()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testSearchWithURLRequest() {
        // Given
        let query = "example"
        let expectation = XCTestExpectation(description: "Search completion")
        
        // When
        sut.search(with: query) { result in
            // Then
            switch result {
            case .success(let titles):
                XCTAssertFalse(titles.isEmpty, "Returned titles should not be empty")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Search failed with error: \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testSearchWithEmptyQuery() {
        // Given
        let query = ""
        let expectation = XCTestExpectation(description: "Search completion with empty query")
        
        // When
        sut.search(with: query) { result in
            // Then
            switch result {
            case .success(let titles):
                XCTAssertTrue(titles.isEmpty, "Returned titles should be empty for an empty query")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Search failed with error: \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }


}

class GetMoviesTests: XCTestCase {
    
    var sut: APICaller!
    
    override func setUp() {
        super.setUp()
        sut = APICaller()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testGetMovie() {
        let expectation = XCTestExpectation(description: "Fetch movie")
        
        let query = "Dune"
        sut.getMovie(with: query) { result in
            switch result {
            case .success(let videoElement):
                // Assert the videoElement or perform any other validation
                XCTAssertNotNil(videoElement)
                
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Failed to fetch movie: \(error.localizedDescription)")
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testGetMovieWithInvalidQuery() {
            let expectation = XCTestExpectation(description: "Fetch movie with invalid query")
            
            let query = "cart" // Replace with an invalid query
            
        sut.getMovie(with: query) { result in
                switch result {
                case .success:
                    XCTFail("Expected failure, but got success")
                    
                case .failure(let error):
                    XCTAssertNotNil(error)
                    expectation.fulfill()
                }
            }
            
            wait(for: [expectation], timeout: 5.0) // Set an appropriate timeout value
        }
    
    func testGetMovieWithInvalidAPIKey() {
            let expectation = XCTestExpectation(description: "Fetch movie with invalid API key")
            
            let query = "Avengers" // Replace with a valid query
            let invalidAPIKey = "INVALID_API_KEY"
            
            let originalAPIKey = constants.YoutubeAPI_KEY
           
            constants.YoutubeAPI_KEY = invalidAPIKey
            
        sut.getMovie(with: query) { result in
                switch result {
                case .success:
                    XCTFail("Expected failure, but got success")
                    
                case .failure(let error):
                    XCTAssertNotNil(error)
                    expectation.fulfill()
                }
            }
            
            constants.YoutubeAPI_KEY = originalAPIKey
            
            wait(for: [expectation], timeout: 5.0) // Set an appropriate timeout value
        }
    
}

class GetUpComingMoviesTests: XCTestCase {
    
    var sut: APICaller!
    var mock: MockAPICaller!
    
    override func setUp() {
        super.setUp()
        sut = APICaller()
        mock = MockAPICaller()
    }
    
    override func tearDown() {
        sut = nil
        mock = nil
        super.tearDown()
    }
    
    func testGetUpcomingMovies() {
        let expectation = XCTestExpectation(description: "Get upcoming movies")
        
        sut.getUpcomingMovies { result in
            switch result {
            case .success(let titles):
                XCTAssertFalse(titles.isEmpty, "Upcoming movies list should not be empty")
                expectation.fulfill()
                
            case .failure(let error):
                XCTFail("Failed to get upcoming movies with error: \(error)")
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testGetUpcomingMoviesFailure() {
            let expectation = XCTestExpectation(description: "Get upcoming movies failure")
            
        mock.getUpcomingMovies { result in
                switch result {
                case .success:
                    XCTFail("Expected failure, but got success")
                    expectation.fulfill()
                    
                case .failure(let error):
                    // Verify that the correct error is returned
                    XCTAssertEqual(error.localizedDescription, APIError.FailedTogetData.localizedDescription, "Unexpected error")
                    expectation.fulfill()
                }
            }
            
        wait(for: [expectation], timeout: 10.0)
    }
}

class CachedImagesTests: XCTestCase {
    
    var sut: ImageCache!
    var mock: MockAPICaller!
    
    override func setUp() {
        super.setUp()
        sut = ImageCache()
        mock = MockAPICaller()
    }
    
    override func tearDown() {
        sut = nil
        mock = nil
        super.tearDown()
    }

    func testFetchImageWithValidURL() {
        let url = URL(string: "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8fDA%3D&w=1000&q=80")!
        
        let expectation = XCTestExpectation(description: "Image fetched successfully")
        
        mock.fetchImage(url: url) { image in
            XCTAssertNotNil(image, "Image should not be nil")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchImageWithInvalidURL() {
        let url = URL(string: "invalid-url")!
        
        let expectation = XCTestExpectation(description: "Invalid URL")
        
        mock.fetchImage(url: url) { image in
            XCTAssertNil(image, "Image should be nil")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchImageWithServerError() {
        let url = URL(string: "https://example.com/image.jpg")!
        
        let expectation = XCTestExpectation(description: "Server error")
        
        mock.fetchImage(url: url) { image in
            XCTAssertNil(image, "Image should be nil")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchImageWithUnsupportedData() {
        let url = URL(string: "https://example.com/unsupported-image")!
        
        let expectation = XCTestExpectation(description: "Unsupported image data")
        
        mock.fetchImage(url: url) { image in
            XCTAssertNil(image, "Image should be nil")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }

}

/*
 override func setUpWithError() throws {
     // Put setup code here. This method is called before the invocation of each test method in the class.
 }

 override func tearDownWithError() throws {
     // Put teardown code here. This method is called after the invocation of each test method in the class.
 }

 func testExample() throws {
     // This is an example of a functional test case.
     // Use XCTAssert and related functions to verify your tests produce the correct results.
 }

 func testPerformanceExample() throws {
     // This is an example of a performance test case.
     self.measure {
         // Put the code you want to measure the time of here.
     }
 }

*/
