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
    
    // MARK: Properties
    //    var resultsArray = [Category]()
    var resultsArray = [TL_Category]()
    
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        resultsArray = generateMockedCategoryArray()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    // MARK: IBActions
    @IBAction func editingChanged(_ sender: Any) {
        if let text = self.searchField.text {
            guard let searchBarEncodedText = text.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlHostAllowed) else { return }
            NetworkService.getSearch(searchBarEncodedText, completion: { (responseArray) -> Void in
                self.resultsArray = responseArray
                self.tableView.reloadData()
            })
        }
    }

    // MARK: Functions
    func generateMockedEvent() -> Event {
        var randomNames = ["New York Mets vs. Minnesota Twins", "Toronto FC vs. New York Red Bulls", "New York Mets vs. Atlanta Braves", "New York City FC vs. FC Dallas", "Ed Sheeran"]
        var randomDateTexts = ["1/2/2018",  "3/5/2018", "9/20/2018", "6/16/2016", "4/30/2018"]
        let mockedEvent = Event.init(name: randomNames[Int(arc4random_uniform(5))], datetext: randomDateTexts[Int(arc4random_uniform(5))])
        return mockedEvent
    }
    
    
    func generateMockedCategory() -> TL_Category {
        var randomNames = ["Baseball","Soccer","Music","Football"]
        
        var mockEventArray = [Event]()
        for _ in 0...4 {
            mockEventArray.append(generateMockedEvent())
        }
        
        let mockedCategory: TL_Category = TL_Category.init(title: randomNames[Int(arc4random_uniform(4))], events: mockEventArray)
        return mockedCategory
    }
    
    func generateMockedCategoryArray() -> [TL_Category] {
        var mockCategoryArray = [TL_Category]()
        for _ in 0...4 {
            mockCategoryArray.append(generateMockedCategory())
        }
        return mockCategoryArray
    }
    

}
// MARK: TableView
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return resultsArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsArray[section].eventArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        
        if indexPath.row == 0 {
            cell.titleLabel.font = UIFont.systemFont(ofSize: 12)
            cell.titleLabel.text = resultsArray[indexPath.section].eventArray[indexPath.row].name
        } else {
            cell.titleLabel.font = UIFont.systemFont(ofSize: 20)
            cell.titleLabel.text = resultsArray[indexPath.section].eventArray[indexPath.row].name
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 25
        } else {
            return 40
        }
    }
}

// MARK: TextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
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
