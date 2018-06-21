//
//  Events.swift
//  CleanMap
//
//  Created by Paul Lee on 2018/5/31.
//  Copyright © 2018年 Paul Lee. All rights reserved.
//

import Foundation

struct Event: Equatable, Codable {
  var id: String
  var name: String
  var time: TimeInterval
  var duration: TimeInterval? = nil
  var yesRsvpCount: Int
  var group: Group
  var venue: Venue? = nil
  var rsvpMembers: [RsvpMember] = []
  
  private enum CodingKeys: String, CodingKey {
    case id, name, time, duration, yesRsvpCount = "yes_rsvp_count", group, venue//, rsvpMembers
  }
  
  init(id: String,
       name: String,
       time: TimeInterval,
       duration: TimeInterval?,
       yesRsvpCount: Int,
       group: Group,
       venue: Venue?,
       rsvpMembers: [RsvpMember]) {
    self.id = id
    self.name = name
    self.time = time
    self.duration = duration
    self.yesRsvpCount = yesRsvpCount
    self.group = group
    self.venue = venue
    self.rsvpMembers = rsvpMembers
  }
  
  
  
}

struct Group: Equatable, Codable {
  var id: Int
  var name: String
  var urlname: String
  var latitude: Double
  var longitude: Double
  
  private enum CodingKeys: String, CodingKey {
    case id, name, urlname, latitude = "lat", longitude = "lon"
  }
}

struct Venue: Equatable, Codable {
  var id: Int
  var name: String
  var latitude: Double
  var longitude: Double
  var address1: String
  
  private enum CodingKeys: String, CodingKey {
    case id, name, latitude = "lat", longitude = "lon", address1 = "address_1"
  }
}


struct RsvpMember: Equatable, Codable {
  var id: Int
  var name: String
  var thumbnail: String
  var isHoster: Bool
}



