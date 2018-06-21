//
//  EventsAPI.swift
//  CleanMap
//
//  Created by Paul Lee on 2018/6/8.
//  Copyright © 2018年 Paul Lee. All rights reserved.
//

import Foundation
import Alamofire
import Alamofire_SwiftyJSON
import SwiftyJSON
import Hydra

class EventsAPI: EventsStoreProtocol {
  
  private var parameters: [String: Any] = ["key": "your_meet_up_api_key"]
  private let apiBaseUrl = "https://api.meetup.com/"
  func fetchEvents(page: Int, offset: Int, completion: @escaping (Result<[Event]>) -> Void) {
    
    async { (_) -> ([Event]) in
      let events = try await(self.fetchEvents(page: page, offset: offset))
      let fullEventPromises = events.map{ return self.addRsvp(for: $0) }
      let fullEvents = try await(all(fullEventPromises))
      return fullEvents
      
    }.then { (events) in
        let result = Result<[Event]>.value(events)
        completion(result)
        
    }.catch { (error) in
        let result = Result<[Event]>.error(error)
        completion(result)
    }
    
  }
  
  private func fetchEvents(page: Int, offset: Int) -> Promise<[Event]> {
    let url = apiBaseUrl + "find/upcoming_events"
    parameters["page"] = page
    parameters["offset"] = offset
    return Promise<[Event]>(in: .main, { [weak self] (resolve, reject, _) in
      Alamofire.request(url,
                        method: .get,
                        parameters: self?.parameters,
                        encoding: URLEncoding.default)
        .validate()
        .responseSwiftyJSON(queue: Context.main.queue ,completionHandler: { (response) in
          if response.result.isFailure, let e = response.result.error {
            reject(e)
            
          } else if let json = response.result.value {
            let eventsJSON = json["events"]
            
            do {
              let data = try eventsJSON.rawData(options: .prettyPrinted)
              let decoder = JSONDecoder()
              let events = try decoder.decode([Event].self, from: data)
              resolve(events)
              
            } catch {
              reject(error)
              
            }
          }
        })
    })
  }
  
  
  private func addRsvp(for event: Event) -> Promise<Event> {
    let eventId = event.id
    let groupUrl = event.group.urlname
    let url = apiBaseUrl + "\(groupUrl)/" + "events/" + "\(eventId)/" + "rsvps"
    return Promise<Event>(in: .main, { [weak self] (resolve, reject, _) in
      Alamofire.request(url,
                        method: .get,
                        parameters: self?.parameters,
                        encoding: URLEncoding.default)
        .validate()
        .responseSwiftyJSON(queue: Context.main.queue ,completionHandler: { (response) in
          if response.result.isFailure, let e = response.result.error {
            if response.response?.statusCode == 403 {
              resolve(event)
            } else {
              reject(e)
              
            }
            
          } else if let json = response.result.value {
            let yesRsvpMember: [RsvpMember] = json.filter({ (key, json) -> Bool in
              return json["response"].stringValue == "yes"
              
            }).map({ (_, json) in
              let member = json["member"]
              let name = member["name"].stringValue
              let id = member["id"].intValue
              let thumbnail = member["photo"]["thumb_link"].stringValue
              let isHoster = member["event_context"]["host"].boolValue
              return RsvpMember(id: id, name: name, thumbnail: thumbnail, isHoster: isHoster )
              
            })
            
            let event = Event(id: event.id,
                              name: event.name,
                              time: event.time,
                              duration: event.duration,
                              yesRsvpCount: event.yesRsvpCount,
                              group: event.group,
                              venue: event.venue,
                              rsvpMembers: yesRsvpMember)
            
            resolve(event)
            
          }
        })
    })
  }

  
  
  func fetchEvents1(completion: @escaping (Result<[Event]>) -> Void) {
    let url = apiBaseUrl + "find/upcoming_events"
    parameters["page"] = 2
    Alamofire.request(url, method: .get,
                      parameters: parameters,
                      encoding: URLEncoding.default)
      .validate()
      .responseSwiftyJSON(queue: Context.background.queue) { (response) in
        
        if response.result.isFailure, let e = response.result.error {
          let result = Result<[Event]>.error(e)
          completion(result)
          
        } else if let json = response.result.value {
          let eventsJSON = json["events"]
          
          do {
            let data = try eventsJSON.rawData(options: .prettyPrinted)
            let decoder = JSONDecoder()
            let events = try decoder.decode([Event].self, from: data)
            
            var fullEvent: [Event] = []
            for event in events {
              self.addRsvp1(for: event, completion: { (result) in
                
                if let event = result.value {
                  fullEvent.append(event)
                }
                
                if fullEvent.count == events.count {
                  let fullResult = Result<[Event]>.value(fullEvent)
                  completion(fullResult)
                }
                
              })
              
            }
            
          } catch {
            let result = Result<[Event]>.error(error)
            completion(result)
            
          }
        }
    }
  }
  
  
  private func addRsvp1(for event: Event, completion: @escaping (Result<Event>) -> Void) {
    let eventId = event.id
    let groupUrl = event.group.urlname
    let url = apiBaseUrl + "\(groupUrl)/" + "events/" + "\(eventId)/" + "rsvps"
    Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default)
      .validate()
      .responseSwiftyJSON(queue: Context.background.queue) { (response) in
        if response.result.isFailure, let e = response.result.error {
          let result = Result<Event>.error(e)
          completion(result)
          
        } else if let json = response.result.value {
          let yesRsvpMember: [RsvpMember] = json.filter({ (key, json) -> Bool in
            return json["response"].stringValue == "yes"
            
          }).map({ (_, json) in
            let member = json["member"]
            let name = member["name"].stringValue
            let id = member["id"].intValue
            let thumbnail = member["photo"]["thumb_link"].stringValue
            let isHoster = member["event_context"]["host"].boolValue
            return RsvpMember(id: id, name: name, thumbnail: thumbnail, isHoster: isHoster)
            
          })
          
          let event = Event(id: event.id,
                            name: event.name,
                            time: event.time,
                            duration: event.duration,
                            yesRsvpCount: event.yesRsvpCount,
                            group: event.group,
                            venue: event.venue,
                            rsvpMembers: yesRsvpMember)
          
          let result = Result<Event>.value(event)
          completion(result)
          
          
        }
    }
    
    
  }
  
  
  
  
}



