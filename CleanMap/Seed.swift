//
//  Seed.swift
//  CleanMapTests
//
//  Created by Paul Lee on 2018/6/5.
//  Copyright © 2018年 Paul Lee. All rights reserved.
//

//@testable import CleanMap
//import XCTest

public struct Seed {
  static let group1 = Group(id: 1401754854000,
                            name: "Swift Taipei User Group",
                            urlname: "Swift-Taipei-User-Group",
                            latitude: 25.020000457763672,
                            longitude: 121.44999694824219)
  
  static let venue1 = Venue(id: 25634409,
                            name: "iCHEF 樓下的 屋脊",
                            latitude: 0,
                            longitude: 0,
                            address1: "松山區敦化北路145巷12號2樓")
  
  static let event1 = Event(id: "250974725", //this is weird, but meet up api use string type in this field
                            name: "Swift Meetup #34",
                            time: 1528196400000,
                            duration: 7200000,
                            yesRsvpCount: 45,
                            group: group1,
                            venue: venue1,
                            rsvpMembers: rsvpMembers1)
  
  static let rsvpMembers1 = [RsvpMember(id: 123,
                                        name: "Paul Lee",
                                        thumbnail: "",
                                        isHoster: false),
                             RsvpMember(id: 198090313,
                                        name: "Ming Cheng Ho",
                                        thumbnail: "https://secure.meetupstatic.com/photos/member/e/7/e/0/thumb_252899360.jpeg",
                                        isHoster: true),
                             RsvpMember(id: 112528022,
                                        name: "Yu Hsiang, Lin",
                                        thumbnail: "https://secure.meetupstatic.com/photos/member/8/f/5/e/thumb_148236702.jpeg",
                                        isHoster: true)]
  
  
  static let group2 = Group(id: 22404525,
                            name: "Taipei Corda Meetup",
                            urlname: "Taipei-Corda-Meetup",
                            latitude: 25.020000457763672,
                            longitude: 121.44999694824219)
  
  static let venue2 = Venue(id: 25752567,
                            name: "台灣金融研訓院",
                            latitude: 25.022382736206055,
                            longitude: 121.5258560180664,
                            address1: "No.62,Sec.3,Roosevelt Road,TAIPEI 100,TAIWAN")
 
  static let event2 = Event(id: "250643357",
                            name: "Corda Taipei Meetup #6 - Featuring Antony Lewis (R3研究總監，央行數位貨幣專家）！",
                            time: 1528282800000,
                            duration: 7200000,
                            yesRsvpCount: 50,
                            group: group2,
                            venue: venue2,
                            rsvpMembers: [])
  
  static let group3 = Group(id: 22404525,
                            name: "Gemba Lean Internet of Things and Bi Data Meetup Taiwan",
                            urlname: "Gemba-Lean-Internet-of-Things-and-Bi-Data-Meetup-Taiwan",
                            latitude: 25.020000457763672,
                            longitude: 121.44999694824219)
  
  static let venue3 = Venue(id: 25752567,
                            name: "MR.BROWN 伯朗咖啡館(小巨蛋店)",
                            latitude: 25.022382736206055,
                            longitude: 121.5258560180664,
                            address1: "No.62,Sec.3,Roosevelt Road,TAIPEI 100,TAIWAN")
  
  static let event3 = Event(id: "220643357",
                            name: "Warm up and greetings with each other-Chat the link between Quality and ML）！",
                            time: 1528282800000,
                            duration: 7200000,
                            yesRsvpCount: 50,
                            group: group3,
                            venue: venue3,
                            rsvpMembers: [])

  
}
