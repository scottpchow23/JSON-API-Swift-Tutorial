//
//  Movie.swift
//  API-Sandbox
//
//  Created by Dion Larson on 6/24/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Movie {
    let name: String
 //   let rightsOwner: String
    let price: Double
    let link: String
    let releaseDate: String
    let poster: String
    
    init(json: JSON) {
        self.name = json["trackName"].stringValue
      //  self.rightsOwner = json["rights"]["label"].stringValue
      //  print(self.rightsOwner)
        self.price = json["trackHdPrice"].doubleValue
        self.link = json["trackViewUrl"].stringValue
        self.releaseDate = json["releaseDate"].stringValue
        self.poster = json["artworkUrl60"].stringValue
    }
}
