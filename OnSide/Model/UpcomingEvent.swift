//
//  UpcomingEvent.swift
//  OnSide
//
//  Created by Ahmed Nagy on 01/03/2022.
//

import Foundation

struct UpcomingEvent: Codable {
    
    var idEvent:String?
    var strEvent:String? //the names of team vs team
    var strFilename:String?
    var strLeague:String?
    var strSeason:String?

    var strHomeTeam:String?
    var strAwayTeam:String?

    var dateEvent:String?
    var strTime:String?

    var strVenue:String? // Match staduim
    var strThumb:URL? // Event logo
    var strStatus:String? //Finished or not
    
}
