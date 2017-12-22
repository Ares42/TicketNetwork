//
//  UIColor+Helper.swift
//  TicketLiquidator
//
//  Created by Luke Solomon on 12/14/17.
//  Copyright © 2017 Luke Solomon. All rights reserved.
//

import UIKit

func generateRandomData() -> [[UIColor]] {
    let numberOfRows = 20
    let numberOfItemsPerRow = 15
    
    return (0..<numberOfRows).map { _ in
        return (0..<numberOfItemsPerRow).map { _ in UIColor.randomColor() }
    }
}

func generateUsefulData() -> [(String, [UIImage])] {
    
    let usefulData = [("Concerts", [UIImage.init(imageLiteralResourceName: "ed sheeran"),
                                    UIImage.init(imageLiteralResourceName: "u2"),
                                    UIImage.init(imageLiteralResourceName: "pitbull"),
                                    UIImage.init(imageLiteralResourceName: "transsiberian")]),
                      
                      ("Sports",   [UIImage.init(imageLiteralResourceName: "football"),
                                    UIImage.init(imageLiteralResourceName: "hockey")]),
                      
                      ("Theatre",  [UIImage.init(imageLiteralResourceName: "hamilton"),
                                    UIImage.init(imageLiteralResourceName: "jersey boys"),
                                    UIImage.init(imageLiteralResourceName: "frozen")]),
                      
                      ("Events",   [UIImage.init(imageLiteralResourceName: "jesus"),
                                    UIImage.init(imageLiteralResourceName: "kevin hart")])
                      ]
    
    return usefulData
}


extension UIColor {
    
    class func randomColor() -> UIColor {
        
        let hue = CGFloat(arc4random() % 100) / 100
        let saturation = CGFloat(arc4random() % 100) / 100
        let brightness = CGFloat(arc4random() % 100) / 100
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
    }
}
