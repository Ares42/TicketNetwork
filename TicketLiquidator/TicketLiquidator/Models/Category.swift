//
//  Category.swift
//  TicketLiquidator
//
//  Created by Luke Solomon on 12/27/17.
//  Copyright © 2017 Luke Solomon. All rights reserved.
//

import Foundation
import SwiftyJSON

class Category {
    var eventArray:[Event] = [Event]()
    
    init(json: JSON) {
        eventArray =  [Event]()
        
        for (key, item) in json["results"] {
            eventArray.append(Event.init(json: item))
        }
        
        
    }
    
    init() {
        eventArray = [Event]()
    }
}
