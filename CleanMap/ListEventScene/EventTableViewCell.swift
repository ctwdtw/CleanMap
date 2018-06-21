//
//  EventTableViewCell.swift
//  CleanMap
//
//  Created by Paul Lee on 2018/5/30.
//  Copyright © 2018年 Paul Lee. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var groupNameLabel: UILabel!
  @IBOutlet weak var dateTimeLabel: UILabel!
  @IBOutlet weak var venueNameLabel: UILabel!
  @IBOutlet weak var rsvpView: RsvpView!
  @IBOutlet weak var rsvpViewHeightLayout: NSLayoutConstraint!
  @IBOutlet weak var rsvpViewTopVerticalLayout: NSLayoutConstraint!
  override func awakeFromNib() {
    super.awakeFromNib()
    self.selectionStyle = .none
  }
  
  
}
