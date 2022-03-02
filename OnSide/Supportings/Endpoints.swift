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
    case results(String)
    case teams(String)
    
    var url: URL {
        return URL(string: self.stringValue)!
    }
    
    var stringValue: String {
        switch self {
        case .allSportsURL:
            return "https://www.thesportsdb.com/api/v1/json/2/all_sports.php?"
        case .leaguesURL(let sport):
            return "https://www.thesportsdb.com/api/v1/json/2/search_all_leagues.php?c=England&s=\(sport)"
        case .upcomingEvents(let league):
            let leagueName = league.replacingOccurrences(of: " ", with: "%20")
            return "https://www.thesportsdb.com/api/v1/json/2/searchfilename.php?e=\(leagueName)"
        case .results(let id):
            return "https://www.thesportsdb.com/api/v1/json/2/eventsseason.php?id=\(id)&s=2021-2022"
        case .teams(let league):
            let leagueName = league.replacingOccurrences(of: " ", with: "%20")
            return "https://www.thesportsdb.com/api/v1/json/2/search_all_teams.php?l=\(leagueName)"
            
        }
    }
    
    
}
