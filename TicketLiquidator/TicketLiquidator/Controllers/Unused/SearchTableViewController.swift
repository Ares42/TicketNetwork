//
//  SearchTableViewController.swift
//  TicketLiquidator
//
//  Created by Luke Solomon on 1/10/18.
//  Copyright © 2018 Luke Solomon. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    var searchResults: [Event] = [Event]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SearchCell
        
        cell.titleLabel.text = searchResults[indexPath.row].name
        cell.dateLabel.text = searchResults[indexPath.row].datetext
        
        return cell
    }
    

}
