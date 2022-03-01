//
//  NetworkManager.swift
//  OnSide
//
//  Created by Ahmed Nagy on 24/02/2022.
//

import Foundation


class SportsAPI {
    
    class func requestAllSports(completionHandler: @escaping ([Sport]? , Error?) -> Void) {
        let _ = URLSession.shared.dataTask(with: Endpoints.allSportsURL.url) { data, response, error in
            guard let data = data else {
                completionHandler(nil, error)
                print("Error loading All sports data...")
                return
            }
            let jsonDecoder = JSONDecoder()
            let sports = try! jsonDecoder.decode([String: [Sport]].self, from: data)
            completionHandler(sports["sports"], nil)
        }.resume()
    }
    
    class func requestLeagues(sport: String, completionHandler: @escaping ([League]?, Error?) -> Void) {
        let _ = URLSession.shared.dataTask(with: Endpoints.leaguesURL(sport).url) { data, response, error in
            guard let data = data else {
                completionHandler(nil, error)
                print("Error loading All sports data...")
                return
            }
            let jsonDecoder = JSONDecoder()
            let leagues = try! jsonDecoder.decode([String: [League]].self, from: data)
            print(leagues)
            completionHandler(leagues["countrys"], nil)
        }.resume()
    }
    
    class func requestUpcomingEvents(leagueName: String, completionHandler: @escaping ([UpcomingEvent]?, Error?) -> Void) {
        
        let _ = URLSession.shared.dataTask(with: Endpoints.upcomingEvents(leagueName).url) { data, response, error in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            let events = try! jsonDecoder.decode([String: [UpcomingEvent]].self, from: data)
            completionHandler(events["event"], nil)

        }.resume()
    }
}
