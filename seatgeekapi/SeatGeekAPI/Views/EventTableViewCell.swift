//
//  EventTableViewCell.swift
//  SeatGeekAPI
//
//  Created by J.A. Ramirez on 12/27/20.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    var model: EventTableViewCellModel?
    
    // Update the UI with the new data.
    func setup(from model: EventTableViewCellModel) {
        self.model = model
        // Download image and set to image view.
        eventNameLabel.text = model.name
        eventLocationLabel.text = model.location
        eventDateLabel.text = model.date
    }
}
