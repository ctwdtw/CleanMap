//
//  ListEventsRouter.swift
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

@objc protocol ListEventsRoutingLogic {
  func routeToShowEventDetail(segue: UIStoryboardSegue?)
}

protocol ListEventsDataPassing {
  var dataStore: ListEventsDataStore? { get }
}

class ListEventsRouter: NSObject, ListEventsRoutingLogic, ListEventsDataPassing {
  weak var viewController: ListEventsVC?
  var dataStore: ListEventsDataStore?

  // MARK: Routing

  //func routeToSomewhere(segue: UIStoryboardSegue?)
  //{
  //  if let segue = segue {
  //    let destinationVC = segue.destination as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //  } else {
  //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }
  //}

  // MARK: Navigation

  //func navigateToSomewhere(source: ListEventsViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}

  // MARK: Passing data

  //func passDataToSomewhere(source: ListEventsDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
  
  func routeToShowEventDetail(segue: UIStoryboardSegue?) {
    if let segue = segue {
      
      
    } else {
      let destinationVC = R.storyboard.main.showEventDetailVC()!
      var destinationDS = destinationVC.router!.dataStore!
      passDataToShowEventDetail(source: dataStore!, destination: &destinationDS)
      navigateToShowEventDetail(source: viewController!, destination: destinationVC)
    
    }
    
    
  }
  
  func passDataToShowEventDetail(source: ListEventsDataStore,
                                 destination: inout ShowEventDetailDataStore) {
    if let selectedRow = viewController?.tableView.indexPathForSelectedRow?.row {
      destination.eventToBeShown = source.fetchedEvents[selectedRow]
      
    }
    
  }
  
  func navigateToShowEventDetail(source: ListEventsVC, destination: ShowEventDetailVC) {
    source.show(destination, sender: nil)
  }
  
  
}