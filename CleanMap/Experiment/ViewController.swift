//
//  ViewController.swift
//  CleanMap
//
//  Created by Paul Lee on 2018/6/11.
//  Copyright © 2018年 Paul Lee. All rights reserved.
//

import UIKit
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var rsvpView: RsvpView!
  @IBOutlet weak var myTableView: UITableView!
  var displayedEvents: [ListEvents.FetchEvents.ViewModel.DisplayedEvent] = []
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    
  
    
    
  }
  
  private func congifureTableView() {
    myTableView.dataSource = self
    myTableView.delegate = self
    myTableView.rowHeight = UITableViewAutomaticDimension
    myTableView.estimatedRowHeight = 200
    myTableView.register(R.nib.eventTableViewCell)
  }
  
//  private func prepareDisplayedEvetns() {
//    let events = [Seed.event1, Seed.event2, Seed.event3]
//    typealias DisplayedEvent = ListEvents.FetchEvents.ViewModel.DisplayedEvent
//    let displayedEvents: [DisplayedEvent] = events.map {
//      
//      let eventSecondSince1970 = $0.time * pow(10, -3)
//      let eventDate = Date(timeIntervalSince1970: eventSecondSince1970)
//      
//      let localFormate = DateFormatter.dateFormat(fromTemplate: "EEEEdMMMhmm", options: 0, locale: Locale.current)
//      let formatter = DateFormatter()
//      formatter.dateFormat = localFormate
//      
//      let dateTime = formatter.string(from: eventDate)
//      return DisplayedEvent(id: $0.id,
//                            name: $0.name,
//                            groupName: $0.group.name,
//                            dateTime: dateTime,
//                            venueName: $0.venue.name,
//                            yesRsvpCount: "\($0.yesRsvpCount)")
//    }
//    
//    self.displayedEvents = displayedEvents
//    
//  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return displayedEvents.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.eventTableViewCell, for: indexPath) else {
      fatalError()
    }
    
    let displayedEvent = displayedEvents[indexPath.row]
    cell.nameLabel.text = displayedEvent.name
    cell.groupNameLabel.text = displayedEvent.groupName
    cell.dateTimeLabel.text = displayedEvent.dateTime
    cell.venueNameLabel.text = displayedEvent.venueName
    
    return cell
    
  }

}
