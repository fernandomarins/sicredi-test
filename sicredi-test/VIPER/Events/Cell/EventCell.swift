//
//  EventCell.swift
//  sicredi-test
//
//  Created by Fernando Marins on 17/12/21.
//

import UIKit

class EventCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    class var identifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
//    var cellViewMode: EventCellViewModel? {
//        didSet {
//            titleLabel.text = cellViewMode?.title
//            dateLabel.text = convertDate(event: cellViewMode?.date ?? 0)
//        }
//    }
    
    func setContent(_ event: Event) {
        titleLabel.text = event.title
        dateLabel.text = convertDate(event: event.date)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        dateLabel.text = nil
    }
    
}
