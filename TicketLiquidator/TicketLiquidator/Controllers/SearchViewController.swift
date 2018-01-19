//
//  SearchViewController.swift
//  TicketLiquidator
//
//  Created by Luke Solomon on 1/12/18.
//  Copyright © 2018 Luke Solomon. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let indicatorView = UIView()
    
    // MARK: Properties
    var resultsArray = [SearchEvent]()
    var sectionHeaders = ["Concerts", "Theatre", "Sports", "Events"]
    
    
    // MARK: View Lifecycle
    override func viewDidLoad() {

    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.activityIndicator.isHidden = true
        
        let indicatorFrame = CGRect.init(x: 10, y: self.view.frame.maxY, width: self.view.frame.width - 20, height: self.view.frame.height / 4)
        self.indicatorView.frame = indicatorFrame
        let label = UILabel.init(frame: indicatorView.layer.bounds)
        label.text = "Tap above to search!"
        label.textColor = UIColor.white
        self.indicatorView.addSubview(label)
        self.indicatorView.backgroundColor = UIColor.black
        
        UIView.animate(withDuration: 1.0) {
            self.indicatorView.frame = CGRect.init(x: 10, y: self.searchField.frame.maxY, width: self.view.frame.width - 20, height: self.view.frame.height / 4)
            
            self.view.addSubview(self.indicatorView)
        }
    }
    
    // MARK: IBActions
    @IBAction func editingChanged(_ sender: Any) {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        updateTableView()
    }
    
    func updateTableView() {
        if let text = self.searchField.text {
            guard let searchBarEncodedText = text.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlHostAllowed) else { return }
            
            NetworkService.getSearch(searchBarEncodedText, completion: { (responseArray) -> Void in
                self.resultsArray = responseArray
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            })
        }
    }
    
}

// MARK: TableView
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchHeaderCell", for: indexPath) as! SearchHeaderCell
            cell.titleLabel.text = sectionHeaders[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
            cell.titleLabel.text = resultsArray[indexPath.row].name
            cell.dateLabel.text  = resultsArray[indexPath.row].date
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 40
        } else {
            return 100
        }
        
    }
    
}

// MARK: TextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.indicatorView.frame = CGRect.init(x: 10, y: self.view.frame.maxY, width: self.view.frame.width - 20, height: self.view.frame.height / 4)
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {

    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
}
