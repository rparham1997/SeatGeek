//
//  ViewController.swift
//  SeatGeekAPI
//
//  Created by J.A. Ramirez on 12/27/20.
//

import UIKit

class EventListViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var eventsTableView: UITableView!

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        // Register a custom class so that the table view can re-use and reference it to make copies.
        // The identifier is assigned in the cell xib. Xib has to be instantiated for outlets to be connected.
        eventsTableView.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: "EventTableViewCell")
        
        // Bug Fix - use the right register method.
        // WHEN WOULD I USE THIS?? Only use this if the cell is a custom class and has NO xib.
        // eventsTableView.register(EventTableViewCell.self, forCellReuseIdentifier: "EventTableViewCell")
        fetchEvents()
    }
    
    private func fetchEvents() {
        // I need to tell this to run specific code AFTER it downloads.
        NetworkManager().searchEvents(with: "Swift") { didSucceed, jsonString in
            DispatchQueue.main.async {
                if didSucceed {
                    // Get the data from closure.
                    print(jsonString)
                    self.eventsTableView.reloadData()
                } else {
                    self.showErrorAlert()
                }
            }
        }
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "There was an error fetching data.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Table View
extension EventListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Prototype Design Pattern: The table view creates an instance of EventTableViewCell type. When the next cell
        // will display on the table, it makes a copy of the instance and queues to be presented. When it's ready to present,
        // it will dequeue it and show on the table.
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as? EventTableViewCell {
            let model = EventTableViewCellModel(imageUrl: "", name: "Hello World", location: "San Francisco", date: "12/12/12")
            // The responsiblity for the cell's UI update is handed to the cell. The view controller does NOT have it.
            cell.setup(from: model)
            return cell
        }
        
        return UITableViewCell()
    }
}
