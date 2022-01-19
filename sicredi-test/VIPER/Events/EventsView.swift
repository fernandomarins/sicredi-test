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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var presenter: EventsPresenterContract?
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EventCell.nib, forCellReuseIdentifier: EventCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.fetchEvents()
    }
    
    func toggleActivityIndicator(show: Bool) {
        DispatchQueue.main.async {
            show ? self.activityIndicator?.startAnimating() : self.activityIndicator.stopAnimating()
        }
    }
    
    func updateContent() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError(message: String) {
        showAlert(title: "Error", message: message, titleAction: "OK")
    }
    
}

extension EventsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let genericCell = tableView.dequeueReusableCell(withIdentifier: EventCell.identifier, for: indexPath)
        
        guard let item = presenter?.contentArray[indexPath.row] else { return genericCell }
        guard let cell = genericCell as? EventCell else { return genericCell }
        
        cell.setContent(item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.toDetails(contentIndex: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.contentArray.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
