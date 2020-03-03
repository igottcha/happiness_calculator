//
//  EntryListTableViewController.swift
//  NotificationPatternsJournal
//
//  Created by Chris Gottfredson on 3/3/20.
//  Copyright © 2020 Trevor Walker. All rights reserved.
//

import UIKit

class EntryListTableViewController: UITableViewController {

    var averageHappiness: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Average Happiness: \(averageHappiness)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Average Happiness: \(averageHappiness)"
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
        for entry in EntryController.entries {
            if entry.isIncluded {
                totalHappiness += entry.happiness
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
