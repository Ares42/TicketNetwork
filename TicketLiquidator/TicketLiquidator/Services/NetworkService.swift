//
//  NetworkService.swift
//  TicketLiquidator
//
//  Created by Luke Solomon on 12/27/17.
//  Copyright © 2017 Luke Solomon. All rights reserved.
//

import Foundation
import Alamofire


import SwiftyJSON


let apiToContact = "https://sandbox.tn-apis.com/catalog/v1/"

let headers: HTTPHeaders = [
    "Accept": "application/json",
    "x-listing-context": "website-config-id=237",
    "Authorization": "Bearer 4412e623-f1b1-3f21-926c-14ed71e71d61"
]


class NetworkService {
    
    static func getCategories(_ completion: @escaping (TL_Category) -> Void) {
        
        Alamofire.request(apiToContact + "categories/", headers: headers).validate().responseJSON(){ response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    
                    let json = JSON(value)
                    
                    let results = TL_Category.init(json: json)
                    
                    completion(results)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func getEvents(completion: @escaping ([Event]) -> Void) {
        
        Alamofire.request( "\(apiToContact)events/", headers: headers).validate().responseJSON(){ response in
            
            switch response.result {
            case .success:
                guard let value = response.result.value  else { return }
                
                let json = JSON(value)
                var events = [Event]()
                
                guard let results = json["results"].array else { return }
                
                for i in 0..<results.count {
                   events.append(Event.init(json: results[i]))
                }
                
                completion(events)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func getEvent(_ event:String, completion: @escaping (Event) -> Void) {
        
        Alamofire.request( "\(apiToContact)events/\(event)", headers: headers).validate().responseJSON(){ response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    let event = Event.init(json: json)
                    
                    completion(event)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func getEventsAsCorrectArray(completion: @escaping ([String:[Event]]) -> Void) {
        
        Alamofire.request( "\(apiToContact)events/", headers: headers).validate().responseJSON(){ response in
            
            switch response.result {
            case .success:
                guard let value = response.result.value  else { return }
                let json = JSON(value)
                
                var dict:[String:[Event]] = [String:[Event]]()
                if let results = json["results"].array {
                    for i in 0..<results.count {
                        
                        let category = results[i]["defaultCategory"]["ancestors"][1]["text"]["name"].stringValue
                        var event = Event.init(json: results[i])
                        
//                        if let dictt = dict[category] as? [String:[Event]] {
//                            dictt[category]?.append(event)
//                        } else {
//                            dictt[category] = [event]()
//                        }
                    }
                }

                
                completion(dict)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func getSearch(_ searchString:String, completion: @escaping ([SearchEvent]) -> Void) {
        
        Alamofire.request( "\(apiToContact)suggest?q=\(searchString)&eventsRequested=10&performersRequested=10&venuesRequested=10&citiesRequested=10", headers: headers).validate().responseJSON() { response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    var responseArray = [SearchEvent]()
                    
                    if let results = json["events"]["results"].array {
                        for i in 0..<results.count {
                            let event = SearchEvent.init(json: results[i])
                            responseArray.append(event)
                        }
                    }
                    
                    completion(responseArray)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
