//
//  EventsWorder.swift
//  CleanMapTests
//
//  Created by Paul Lee on 2018/6/1.
//  Copyright © 2018年 Paul Lee. All rights reserved.
//

@testable import CleanMap
import XCTest
class EventsWorkerTests: XCTestCase {
  var sut: EventsWorker!
  static var testEvents: [Event]!
  override func setUp() {
    super.setUp()
    setupEventsWorker()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func setupEventsWorker() {
    sut = EventsWorker(store: nil)
    EventsWorkerTests.testEvents = [Seed.event1, Seed.event2]
  }
  
  //MARK: - test doubles
  public class EventsStoreSpy: EventsStoreProtocol {
    
    var fetchEventsIsCalled = false
    func fetchEvents(page: Int, offset: Int, completion: @escaping (Result<[Event]>) -> Void) {
      let result: Result<[Event]> = Result.value(EventsWorkerTests.testEvents)
      fetchEventsIsCalled = true
      DispatchQueue.global().async {
        sleep(1)
        DispatchQueue.main.async {
            completion(result)
        }
      }
      
    }
  }
  
  
  func test_fetchEvents_whenSuccess_returnsListOfOrders() {
    //given
    let rq = ListEvents.FetchEvents.Request(page: 2, offset: 0)
    let eventsStoreSpy = EventsStoreSpy()
    sut.eventsStore = eventsStoreSpy //property injection
    let exp = expectation(description: "expect fetchEvents(completion:) to return")
    //when
    var fetchedEvents: [Event] = []
    sut.fetchEvents(request: rq) { (eventsResult) in
      fetchedEvents = eventsResult.value!
      exp.fulfill()
    }
    wait(for: [exp], timeout: 1.1)
    //then
    XCTAssert(fetchedEvents.count == EventsWorkerTests.testEvents.count, "fetchEvents(completion:) should return a list of events")
    for event in fetchedEvents {
      XCTAssert(EventsWorkerTests.testEvents.contains(event), "Fetched events should match the events in the data store")
    }
    
  }

  func test_fetchEvents_askEventsStoreToFetchEvents() {
    //given
    let rq = ListEvents.FetchEvents.Request(page: 2, offset: 0)
    let eventsStoreSpy = EventsStoreSpy()
    sut.eventsStore = eventsStoreSpy //property injection
    let exp = expectation(description: "expect fetchEvents(completion:) to return")
    //when
    sut.fetchEvents(request: rq) { (events) in
      exp.fulfill()
    }
    wait(for: [exp], timeout: 1.1)
    //then
    XCTAssert(eventsStoreSpy.fetchEventsIsCalled, "fetchEvents(completion:) should call eventsStore to fetch events")
  }
  
  func test_init_takesEventsStoreProtocolObjAsParameter() {
    //given
    let store = EventsStoreSpy()
    //when
    let worker = EventsWorker(store: store)
    //then
    XCTAssertNotNil(worker)
  }
  
  
}







