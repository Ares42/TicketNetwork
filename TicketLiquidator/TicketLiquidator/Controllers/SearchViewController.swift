//
//  SearchViewController.swift
//  TicketLiquidator
//
//  Created by Luke Solomon on 1/12/18.
//  Copyright © 2018 Luke Solomon. All rights reserved.
//

import Foundation
import UIKit

fileprivate struct Constants
{
    static let inset: CGFloat = 10.0
    static let indicatorHeight: CGFloat = 100
}

class SearchViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let indicatorView = UIView()
    var topConstraint:NSLayoutConstraint = NSLayoutConstraint()
    
    // MARK: Properties
    var resultsArray = [SearchEvent]()
    var sectionHeaders = ["Concerts", "Theatre", "Sports", "Events"]
    
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.activityIndicator.isHidden = true

        self.setupIndicatorView()
        
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
    
    func setupIndicatorView () {
        self.view.addSubview(self.indicatorView)

        let margins = view.layoutMarginsGuide
        topConstraint = indicatorView.topAnchor.constraint(equalTo: margins.bottomAnchor, constant: Constants.inset)
        
        
        //layout the view off of the screen
        indicatorView.isHidden = true
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        topConstraint.isActive = true
        indicatorView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: Constants.inset).isActive = true
        indicatorView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -Constants.inset).isActive = true
        indicatorView.heightAnchor.constraint(equalToConstant: Constants.indicatorHeight).isActive = true
        
        indicatorView.layer.cornerRadius = 8
        indicatorView.layer.masksToBounds = true
        
        let label = UILabel.init()
        self.indicatorView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: indicatorView.topAnchor, constant:Constants.inset).isActive = true
        label.leadingAnchor.constraint(equalTo: indicatorView.leadingAnchor, constant:Constants.inset).isActive = true
        label.trailingAnchor.constraint(equalTo: indicatorView.trailingAnchor, constant:-Constants.inset).isActive = true
        label.bottomAnchor.constraint(equalTo: indicatorView.bottomAnchor, constant:-Constants.inset).isActive = true
        
        label.text = "Tap above to search!"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.adjustsFontForContentSizeCategory = true

        
        self.indicatorView.backgroundColor = UIColor.darkGray

        UIView.animate(withDuration:0.1, animations: {
            self.view.layoutIfNeeded()
        }) { (true) in
            self.indicatorView.isHidden = false
        }
        
        //animate into the view
        topConstraint = self.indicatorView.topAnchor.constraint(equalTo: self.searchField.layoutMarginsGuide.bottomAnchor, constant: Constants.inset)
        topConstraint.isActive = true
        UIView.animate(withDuration: 1.0) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showEvent" {

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
            cell.imageView!.backgroundColor = UIColor.randomColor()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showEvent", sender: self)
        
        
        
    }
}

// MARK: TextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        topConstraint = self.indicatorView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor)
        topConstraint.isActive = true
        
        UIView.animate(withDuration: 1.0) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.tableView.reloadData()
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }

}
