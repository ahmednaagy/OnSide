//
//  Team.swift
//  OnSide
//
//  Created by Ahmed Nagy on 01/03/2022.
//

import Foundation

struct Team: Codable{
    
    var idTeam:String?
    var strTeam:String?
    
    var strStadium:String?
    var strStadiumThumb:URL? // staduim photo
    
    var strWebsite:String?
    var strFacebook:String?
    var strTwitter:String?
    var strInstagram:String?
    var strYoutube:String?
    var strDescriptionEN: String?
    
    var strTeamBadge:URL? //Logo
    var strTeamLogo:URL? //Title logo
    var strTeamJersey:URL?
    var strTeamBanner:URL?

}
