//
//  SearchCategory.swift
//  TicketLiquidator
//
//  Created by Luke Solomon on 1/12/18.
//  Copyright © 2018 Luke Solomon. All rights reserved.
//

import Foundation
import SwiftyJSON

class SearchCategory {
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
