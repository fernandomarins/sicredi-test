//
//  EventsListViewController.swift
//  sicredi-test
//
//  Created by Fernando Marins on 15/12/21.
//

import UIKit

class EventsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let cellID = "cellID"
    let segueID = "toDetails"
    
    var events = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        loadData()
    }
    
    fileprivate func loadData() {
        Client.getEvents { events, error in
            if let error = error {
                self.showAlert(title: "Error",
                               message: error.localizedDescription,
                               titleAction: "OK")
                return
            }
            
            guard let events = events else {
                return
            }
            
            self.events = events
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueID {
            let vc = segue.destination as? DetailsViewController
            vc?.event = events[tableView.indexPathForSelectedRow!.row]
        }
    }

}

extension EventsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        cell.textLabel?.text = events[indexPath.row].title
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: segueID, sender: self)
//    }
    
}
