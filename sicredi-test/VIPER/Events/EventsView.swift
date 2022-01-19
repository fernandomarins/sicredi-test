//
//  EventsView.swift
//  sicredi-test
//
//  Created by Fernando Marins on 19/01/22.
//

import Foundation
import UIKit

class EventsView: UIViewController, EventsContract {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: EventsPresenterContract?
    
    func updateContent() {
        tableView.reloadData()
    }
    
}

extension EventsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}
