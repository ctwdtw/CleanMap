//
//  ShowDetailEventPresenterTest.swift
//  CleanMapTests
//
//  Created by Paul Lee on 2018/6/18.
//  Copyright © 2018年 Paul Lee. All rights reserved.
//

import XCTest
@testable import CleanMap
class ShowDetailEventPresenterTest: XCTestCase {
  var sut: ShowEventDetailPresenter!
  override func setUp() {
    super.setUp()
    sut = ShowEventDetailPresenter()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  //MARK: - test doubles
  class ShowEventDetailVCSpy: ShowEventDetailDisplayLogic {
    var viewModel: ShowEventDetail.getEvent.ViewModel!
    func displaySomething(viewModel: ShowEventDetail.Something.ViewModel) {
      
    }
    
    func displayEvent(viewModel: ShowEventDetail.getEvent.ViewModel) {
      self.viewModel = viewModel
      
    }
    
  }
  
  func test_presentDetailedEvent_formateDetailedEvent() {
    //given
    let event = Seed.event1
    let response = ShowEventDetail.getEvent.Response(event: event)
    let showEventDetailVCSpy = ShowEventDetailVCSpy()
    sut.viewController = showEventDetailVCSpy
    
    //when
    sut.presentDetailedEvent(response: response)
     
    //then
    let detailedEvent = showEventDetailVCSpy.viewModel.displayedEvent
    XCTAssertEqual(detailedEvent.name, event.name)
    XCTAssertEqual(detailedEvent.date, "6月5日 星期二")
    XCTAssertEqual(detailedEvent.startAndEndTime, "下午7:00 - 下午9:00")
    XCTAssertEqual(detailedEvent.address, "松山區敦化北路145巷12號2樓")
    XCTAssertEqual(detailedEvent.hosters, "Hosted by Ming Cheng Ho, Yu Hsiang, Lin")
    XCTAssertEqual(detailedEvent.venueName, "iCHEF 樓下的 屋脊")
    
  }
  
}
