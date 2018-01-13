//
//  TL_Category.swift
//  TicketLiquidator
//
//  Created by Luke Solomon on 12/27/17.
//  Copyright © 2017 Luke Solomon. All rights reserved.
//

import Foundation
import SwiftyJSON

class TL_Category {
    var eventArray:[Event] = [Event]()
    var title:String
    
    
    init(json: JSON) {
        eventArray =  [Event]()
        
        for (key, item) in json["results"] {
            eventArray.append(Event.init(json: item))
        }
        self.title = ""
    }
    
    init(title: String, events:[Event]) {
        self.eventArray = events
        self.title = title
    }
    
    
  
}
