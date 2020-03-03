//
//  EntryListTableViewController.swift
//  NotificationPatternsJournal
//
//  Created by Chris Gottfredson on 3/3/20.
//  Copyright © 2020 Trevor Walker. All rights reserved.
//

import UIKit

let notificationKey = Notification.Name("didChangeHappiness")

class EntryListTableViewController: UITableViewController {

    var averageHappiness: Int = 0 {
        //Property Observer
        didSet {
            NotificationCenter.default.post(name: notificationKey, object: self.averageHappiness)
            self.title = "Average Happiness: \(averageHappiness)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EntryController.entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath) as? EntryTableViewCell else {return UITableViewCell()}
        let entry = EntryController.entries[indexPath.row]
        cell.setEntry(entry: entry, averageHappiness: averageHappiness)
        cell.delegate = self
        return cell
    }

    func updateAverageHappiness() {
        var totalHappiness = 0
//        var entriesIncluded: [Entry] = []
        for entry in EntryController.entries {
            if entry.isIncluded {
                totalHappiness += entry.happiness
//                entriesIncluded.append(entry)
            }
        }
        averageHappiness = totalHappiness / EntryController.entries.count
    }
}

extension EntryListTableViewController: EntryTableViewCellDelegate {
   
    func switchToggledOnCell(cell: EntryTableViewCell) {
        guard let entry = cell.entry else {return}
        EntryController.updateEntry(entry: entry)
        updateAverageHappiness()
        cell.updateUI(averageHappiness: averageHappiness)
    }
}
