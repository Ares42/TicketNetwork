//
//  ObjectService.swift
//  TicketLiquidator
//
//  Created by Luke Solomon on 1/2/18.
//  Copyright © 2018 Luke Solomon. All rights reserved.
//

import Foundation
import SwiftyJSON

class ObjectService {
    
    func parseResponseToCorrectFormat (json: JSON) -> [String:[Event]] {
        var dict:[String:[Event]] = [String:[Event]]()
        
        if let results = json["results"].array {
            
            for i in 0..<results.count {
                
                let category = results[i]["defaultCategory"]["ancestors"][1]["text"]["name"].stringValue
                var event = Event.init(json: results[i])
                var arr: [Event] = []
                
                if let dictt = dict[category] {
                    arr.append(event)
                    dict[category] = arr
                }
            }
        }
        return dict
    }
}
