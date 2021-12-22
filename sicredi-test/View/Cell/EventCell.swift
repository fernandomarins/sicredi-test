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
    
    var cellViewMode: EventCellViewModel? {
        didSet {
            titleLabel.text = cellViewMode?.title
            dateLabel.text = convertDate(event: cellViewMode?.date ?? 0)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
