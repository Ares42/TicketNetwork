//
//  EventTableViewCell.swift
//  
//
//  Created by Luke Solomon on 12/14/17.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var eventTitleLabel: UILabel!
    
    @IBOutlet fileprivate weak var eventCollectionView: UICollectionView!
    
}
extension EventTableViewCell {
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        eventCollectionView.delegate = dataSourceDelegate
        eventCollectionView.dataSource = dataSourceDelegate
        eventCollectionView.tag = row
        eventCollectionView.setContentOffset(eventCollectionView.contentOffset, animated:false)
        eventCollectionView.reloadData()
    }
    
    var collectionViewOffset: CGFloat {
        set { eventCollectionView.contentOffset.x = newValue }
        get { return eventCollectionView.contentOffset.x }
    }
}

