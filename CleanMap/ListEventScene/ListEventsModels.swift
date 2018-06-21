//
//  ListEventsModels.swift
//  CleanMap
//
//  Created by Paul Lee on 2018/5/30.
//  Copyright (c) 2018年 Paul Lee. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum ListEvents {
  // MARK: Use cases
  
  enum FetchEvents {
    struct Request {
      var page: Int = 0
      var offset: Int = 0
    }
    struct Response {
      var events: [Event]?
      var error: Error?
    }
    struct ViewModel {
      struct DisplayedEvent {
        var id: String
        var name: String
        var groupName: String
        var dateTime: String
        var venueName: String
        var yesRsvpCount: String
        var avatorUrls: [String]
        
      }
      var displayedEvents: [DisplayedEvent]?
      
      
    }
  }
  
  
}