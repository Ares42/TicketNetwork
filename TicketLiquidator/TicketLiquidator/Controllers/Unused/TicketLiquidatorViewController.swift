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
    var model = [Event]()
    var storedOffsets = [Int: CGFloat]()

    let resultsView = UIView()
    

    // pragma mark - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reUpdateTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        resultsView.frame = CGRect.init(x: 5, y: searchField.layer.bounds.minY + 45, width: self.view.frame.width - 20, height: self.view.frame.height / 2)
        self.view.addSubview(resultsView)
        resultsView.isHidden = true
    }
    
    // pragma mark - Other Functions
    func reUpdateTableView() {
        NetworkService.getEvents(completion: { (events) in
            self.model = events
            self.eventTableView.reloadData()
        })
    }
    
    // pragma mark - IBActions
    @IBAction func editingChanged(_ sender: Any) {
        
        //let searchBarEncodedText = textField.text!.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
        
        if let text = self.searchField.text {
            NetworkService.getSearch(text, completion: { (responseArray) -> Void in
                // self.tableView.reloadData()
            })
        }
    }
    
    @objc func editingCancelled (view: UIView) {
        view.removeFromSuperview()
        self.searchField.resignFirstResponder()
    }
    
    
    
    
}

// pragma mark - TableView
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

// pragma mark - CollectionView
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

// pragma mark - TextFieldDelegate
extension TicketLiquidatorViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(UIInputViewController.dismissKeyboard))
//        self.view.addGestureRecognizer(tap)
        
        let resultsTableView = UITableView.init(frame: resultsView.frame)
        resultsTableView.layer.borderWidth = 2.0
        resultsTableView.layer.borderColor = UIColor.black.cgColor
        resultsView.addSubview(resultsTableView)
        
        UIView.animate(withDuration: 2) {
            self.resultsView.isHidden = false
        }
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
