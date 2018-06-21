//
//  EventsWorker.swift
//  CleanMap
//
//  Created by Paul Lee on 2018/5/30.
//  Copyright © 2018年 Paul Lee. All rights reserved.
//

import Foundation
import Hydra
enum Result<T> {
  case value(T)
  case error(Error)
  var value: T? {
    switch self {
    case .value(let value):
      return value
    case .error(_):
      return nil
    }
  }
  
  var error: Error? {
    switch self {
    case .value(_):
      return nil
    case .error(let e):
      return e
    }
  }
  
  var isSuccess: Bool {
    switch self {
    case .value(_):
      return true
    case .error(_):
      return false
    }
  }
}

protocol EventsStoreProtocol {
  //CRUD Result
  func fetchEvents(page: Int, offset: Int, completion: @escaping (Result<[Event]>) -> Void)
  
  //CRUD Promise
  //func fetchEvents() -> Promise<[Event]>
}

class EventsWorker {
  var eventsStore: EventsStoreProtocol?
  var isFetching = false
  init(store: EventsStoreProtocol?) {
    self.eventsStore = store
  }
  
  func fetchEvents(request: ListEvents.FetchEvents.Request, completion: @escaping (Result<[Event]>) -> Void) {
    guard isFetching == false else {
      return
    }
    isFetching = true
    eventsStore?.fetchEvents(page: request.page,
                             offset: request.offset,
                             completion: { (eventResult) in
      
      
      completion(eventResult)
      self.isFetching = false
                              

    })
  }
  
}
