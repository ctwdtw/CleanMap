//
//  EventsAPITests.swift
//  CleanMapTests
//
//  Created by Paul Lee on 2018/6/10.
//  Copyright © 2018年 Paul Lee. All rights reserved.
//

import XCTest
@testable import CleanMap
class EventsAPITests: XCTestCase {
  var sut: EventsAPI!
  override func setUp() {
    super.setUp()
    sut = EventsAPI()
    
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func _fetchEvents1_returnsEvents_whenSuccess() {
    let exp = expectation(description: "fetchEvents(completion:) fetch asynchronously")
    //when
    var eventsResult: Result<[Event]> = Result.value([])
    sut.fetchEvents1 { (fetchedEventsResult) in
      eventsResult = fetchedEventsResult
      exp.fulfill()
    }
    waitForExpectations(timeout: 30)
    
    //then
    guard eventsResult.isSuccess else {
      return //nothing to test when failed
    }
    
    guard let events = eventsResult.value else {
      XCTFail("success fetch should have events")
      return
    }
    
    XCTAssertNotNil(events.first, "success fetch should have at least one event")
    XCTAssertNotNil(events.first?.id)
    XCTAssertNotNil(events.first?.name)
    XCTAssertNotNil(events.first?.group.name)
    XCTAssertNotNil(events.first?.time)
  
  
  }
  
  func test_fetchEvents_returnsEvents_whenSuccess() {
    //given
    let exp = expectation(description: "fetchEvents(completion:) fetch asynchronously")
    //when
    var eventsResult: Result<[Event]> = Result.value([])
    sut.fetchEvents(page: 5, offset: 1) { (fetchedEventsResult) in
      eventsResult = fetchedEventsResult
      exp.fulfill()
    }
    waitForExpectations(timeout: 10)
    
    //then
    guard eventsResult.isSuccess else {
      return //nothing to test when failed
    }
    
    guard let events = eventsResult.value else {
      XCTFail("success fetch should have events")
      return
    }
    
    
    XCTAssertNotNil(events.first, "success fetch should have at least one event")
    XCTAssertNotNil(events.first?.id)
    XCTAssertNotNil(events.first?.name)
    XCTAssertNotNil(events.first?.group.name)
    XCTAssertNotNil(events.first?.time)
    
    
  }
  
  
  
}
