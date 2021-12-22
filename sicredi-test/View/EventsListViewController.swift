//
//  EventsListViewController.swift
//  sicredi-test
//
//  Created by Fernando Marins on 15/12/21.
//

import UIKit

class EventsListViewController: UIViewController {

    // MARK: - Variables/Constants
    
    @IBOutlet weak var tableView: UITableView!
    
    var activityView: UIActivityIndicatorView!
    
    lazy var viewModel = {
        EventsListViewModel()
    }()
    
    lazy var detailsViewModel = {
        DetailsViewViewModel()
    }()
    
    let cellID = "cellID"
    
    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        // Adding the activtiy indicator
        activityView = UIActivityIndicatorView(style: .large)
        activityView.center = view!.center
        activityView.hidesWhenStopped = true
        view.addSubview(activityView)
        
        tableView.register(EventCell.nib, forCellReuseIdentifier: EventCell.identifier)
        initViewModel()
    }
    
    func initViewModel() {
        viewModel.getEvents()
        showHideActivityIndicator(show: true)
        viewModel.reloadedTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.showHideActivityIndicator(show: false)
                self?.tableView.reloadData()
            }
            
        }
    }
    
    // MARK: - Private methods
    
    fileprivate func showHideActivityIndicator(show: Bool) {
        DispatchQueue.main.async {
            show ? self.activityView?.startAnimating() : self.activityView.stopAnimating()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func refreshAction(_ sender: Any) {
        initViewModel()
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == viewModel.segue {
            let vc = segue.destination as? DetailsViewController
            vc?.viewModel = detailsViewModel
            

            detailsViewModel.event = viewModel.events[tableView.indexPathForSelectedRow!.row]
//            vc?.event = events[tableView.indexPathForSelectedRow!.row]

            tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
        }
    }

}

extension EventsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.eventCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        let detailsViewModel = viewModel.getCellViewModel(at: indexPath)
//        detailsViewModel.event = viewModel.events[tableView.indexPathForSelectedRow!.row]
//        let vc = DetailsViewController(viewModel: detailsViewModel)
//
//        navigationController?.pushViewController(vc, animated: true)
////        present(vc, animated: true, completion: nil)
        performSegue(withIdentifier: viewModel.segue, sender: self)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.identifier, for: indexPath) as? EventCell else {
            fatalError("xib does not exist")
        }
        
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewMode = cellVM
        
        return cell
    }
    
}
