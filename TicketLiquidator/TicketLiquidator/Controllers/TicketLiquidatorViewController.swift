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
    
    // pragma mark - Properties
    //let model: [[UIColor]] = generateRandomData()
//    varfa model: [(String, [UIImage])] = generateUsefulData()
    
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
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
