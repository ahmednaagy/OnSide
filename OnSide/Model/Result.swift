//
//  Result.swift
//  OnSide
//
//  Created by Ahmed Nagy on 01/03/2022.
//

import Foundation

struct Result: Codable{
    
    var idEvent:String?
    var strEvent:String? //the names of team vs team
    var strFilename:String?
    var strLeague:String?
    var strSeason:String?
    
    var strHomeTeam:String?
    var strAwayTeam:String?
    var intHomeScore:String? //Home team result
    var intAwayScore:String? //Away team result
    
    var dateEvent:String?
    var strTime:String?
    
    var strVenue:String? // Match staduim
    var strThumb:String? // Event logo
    var strVideo:String? // Youtube Video
    var strStatus:String? //Finished or not
 
}
