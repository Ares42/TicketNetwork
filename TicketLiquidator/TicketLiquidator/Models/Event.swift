//
//  Event
//  TicketLiquidator
//
//  Created by Luke Solomon on 12/27/17.
//  Copyright © 2017 Luke Solomon. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Event {
    
    var name : String
//    var date : [String : JSON] // must contain other date info if you're going to do it this way
    var datetime : String
    var datetext : String
    var timeZone : String
    var latitude : Float
    var longitude : Float
    var lowPrice : Int
    
    init(json: JSON) {
        
        self.name = json["text"]["name"].stringValue
//        self.date = json["date"].dictionaryValue
        self.datetime = json["date"]["datetime"].stringValue
        self.datetext = json["date"]["datetext"].stringValue
        self.timeZone = json["date"]["timeZone"].stringValue
        self.latitude = json["geoLocation"]["latitude"].floatValue
        self.longitude = json["geoLocation"]["longitude"].floatValue
        self.lowPrice = json["lowPrice"]["value"].intValue
        
        
    }
}

struct SearchResult {
    var category : String
    var eventArray : [SearchEvent]
    
    init(json: JSON) {
        self.category = json["defaultCategory"]["text"]["name"].stringValue
        
       self.eventArray = json["results"].arrayValue.map({
            (value: JSON) -> SearchEvent in
        
            var searchEvent = SearchEvent.init(json: value)
            return searchEvent
        })
        
//        self.eventArray = json["results"].arrayValue
    }
}

struct SearchEvent {
    var name : String
    var date : String
    var eventID : String

    init(json: JSON) {
        self.name = json["name"].stringValue
        self.date = json["date"].stringValue
        self.eventID = json[].stringValue
    }
}


