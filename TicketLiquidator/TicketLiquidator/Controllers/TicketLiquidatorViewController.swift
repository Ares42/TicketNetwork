//
//  TicketLiquidatorViewController.swift
//  
//
//  Created by Luke Solomon on 12/14/17.
//

import UIKit
import SwiftyJSON


class TicketLiquidatorViewController: UIViewController {
    
    // pragma mark - IBOutlets
    @IBOutlet weak var eventTableView: UITableView!
    @IBOutlet weak var searchField: UITextField!
    
    // pragma mark - Properties
    //let model: [[UIColor]] = generateRandomData()
    //varfa model: [(String, [UIImage])] = generateUsefulData()
    
    var model = [Event]()
    var storedOffsets = [Int: CGFloat]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reUpdateTableView()
        
        
        NetworkService.getEventsAsCorrectArray(completion: { (events) in
            
        })
    }
    
    func reUpdateTableView() {
        NetworkService.getEvents(completion: { (events) in
            self.model = events
            self.eventTableView.reloadData()
        })
        
        
    }
    
    @IBAction func editingChanged(_ sender: Any) {

        //        let searchBarEncodedText = textField.text!.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
        //
        
        if let text = self.searchField.text {
            NetworkService.getSearch(text, completion: { (responseArray) -> Void in
//                self.tableView.reloadData()
            })
        }
        
        
    }
    // When users tap search, load up new table view cotroller (gesture recogizer)
    // As Each letter is typed, make a new request to the server
    // When
    
    
    @objc func editingCancelled (view: UIView) {
        view.removeFromSuperview()
        self.searchField.resignFirstResponder()
        
    }
    
}

extension TicketLiquidatorViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as! EventTableViewCell
        
        cell.eventTitleLabel.text = model[indexPath.row].name
        
        return cell
     }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? EventTableViewCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? EventTableViewCell else { return }
        
        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
}

extension TicketLiquidatorViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCollectionViewCell", for: indexPath) as! EventCollectionViewCell
        
//        cell.imageView.image = model[collectionView.tag].1[indexPath.item]
        cell.title.text = model[indexPath.item].name
        cell.subtitle.text = model[indexPath.item].datetext
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
}

extension TicketLiquidatorViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        let viewRect = CGRect.init(x: 0, y: self.searchField.frame.minY , width: self.view.frame.width, height: self.view.frame.height/2)
        let resultsView = UIView.init(frame: viewRect)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(UIInputViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
        let resultsTableView = UITableView.init(frame: resultsView.frame)
        
        
        resultsView.addSubview(resultsTableView)
//        resultsTableViewController.view.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
//        resultsTableViewController.view.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
//        resultsTableViewController.view.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
//        resultsTableViewController.view.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        self.view.addSubview(resultsView)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        //        self.dismissKeyboard()
        return true
    }
}
