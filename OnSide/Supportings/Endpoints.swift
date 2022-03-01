//
//  Endpoints.swift
//  OnSide
//
//  Created by Ahmed Nagy on 24/02/2022.
//

import Foundation


enum Endpoints {
    case allSportsURL
    case leaguesURL(String)
    case upcomingEvents(String)
    
    var url: URL {
        return URL(string: self.stringValue)!
    }
    
    var stringValue: String {
        switch self {
        case .allSportsURL:
            return "https://www.thesportsdb.com/api/v1/json/2/all_sports.php?"
        case .leaguesURL(let sport):
            return "https://www.thesportsdb.com/api/v1/json/2/search_all_leagues.php?s=\(sport)"
        case .upcomingEvents(let league):
            let leagueName = league.replacingOccurrences(of: " ", with: "%20")
            return "https://www.thesportsdb.com/api/v1/json/2/searchfilename.php?e=\(leagueName)"
        }
    }
    
    
}
