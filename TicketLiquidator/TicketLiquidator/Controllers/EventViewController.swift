//
//  EventViewController.swift
//  TicketLiquidator
//
//  Created by Luke Solomon on 1/23/18.
//  Copyright © 2018 Luke Solomon. All rights reserved.
//

import UIKit


class EventViewController : UIViewController {
    
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    
    var image = UIImage()
    var eventTitle = String()
    var eventDate = String()
    
    
    override func viewDidLoad() {
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.imageView.backgroundColor = UIColor.randomColor()
        self.eventTitleLabel.text = self.eventTitle
        self.eventDateLabel.text = self.eventDate
    }
    
    
    
    
    
}
