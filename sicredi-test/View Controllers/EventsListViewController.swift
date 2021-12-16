//
//  EventsListViewController.swift
//  sicredi-test
//
//  Created by Fernando Marins on 15/12/21.
//

import UIKit

class EventsListViewController: UIViewController {

    var activityView: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    
    let cellID = "cellID"
    let segueID = "toDetails"
    
    var events = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        activityView = UIActivityIndicatorView(style: .large)
        activityView.center = view!.center
        activityView.hidesWhenStopped = true
        view.addSubview(activityView)
        
        loadData()
    }
    
    fileprivate func loadData() {
        showHideActivityIndicator(show: true)
        Client.getEvents { events, error in
            if let error = error {
                self.showHideActivityIndicator(show: false)
                self.showAlert(title: "Error",
                               message: error.localizedDescription,
                               titleAction: "OK")
                return
            }
            
            self.showHideActivityIndicator(show: false)
            guard let events = events else {
                return
            }
            
            self.events = events
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
            }
            
        }
    }
    
    fileprivate func showHideActivityIndicator(show: Bool) {
        DispatchQueue.main.async {
            show ? self.activityView?.startAnimating() : self.activityView.stopAnimating()
        }
    }
    
    @IBAction func refreshAction(_ sender: Any) {
        loadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueID {
            let vc = segue.destination as? DetailsViewController
            vc?.event = events[tableView.indexPathForSelectedRow!.row]
            
            tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
        }
    }

}

extension EventsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 15)
        
        let title = events[indexPath.row].title
        let date = events[indexPath.row].date
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = convertDate(event: date)
        
        return cell
    }
    
}
