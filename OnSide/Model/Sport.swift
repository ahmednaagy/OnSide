//
//  Sports.swift
//  OnSide
//
//  Created by Ahmed Nagy on 24/02/2022.
//

import Foundation


struct Sport: Codable {
    
    var strSport: String
    var strSportThumb: URL
//
//    enum CodingKeys: String, CodingKey {
//        case sportName = "strSport"
//        case sportImage = "strSportThumb"
//    }
}

struct SportsResponse: Codable {
    var sports: [String: [Sport]]
}
