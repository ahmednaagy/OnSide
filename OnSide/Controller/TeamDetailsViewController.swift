//
//  TeamDetailsViewController.swift
//  OnSide
//
//  Created by Ahmed Nagy on 02/03/2022.
//

import UIKit

class TeamDetailsViewController: UIViewController {

    @IBOutlet weak var clubStadiumImage: UIImageView!
    @IBOutlet weak var clubLogo: UIImageView!
    @IBOutlet weak var clubName: UILabel!
    @IBOutlet weak var clubDescription: UITextView!
    
    
    
    var team = Team()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let data = NSData(contentsOf: team.strStadiumThumb!), let logo = NSData(contentsOf: team.strTeamBadge!){
            clubStadiumImage.image = UIImage(data: data as Data)
            clubLogo.image = UIImage(data: logo as Data)
        } else {
            clubStadiumImage.image = UIImage(named: "placeholder-image")
            clubLogo.image = UIImage(named: "placeholder-image")
        }
        
        clubName.text = team.strTeam
        clubDescription.text = team.strDescriptionEN
        
        
    }
    
    
    @IBAction func openTwitter(_ sender: Any) {
        if !team.strTwitter!.isEmpty {
            print(team.strTwitter!)
//            print(URL(string: "https://\(String(describing: team.strTwitter))")!)
            let fullURL = URL(string: "https://\(String(describing: team.strTwitter!))")
            UIApplication.shared.open(fullURL!, options: [:]) { success in
                print("Twitter Opened")
            }
        }
        
    }
    
    @IBAction func openInstgram(_ sender: Any) {
        if !team.strInstagram!.isEmpty {
            let fullURL = URL(string: "https://\(String(describing: team.strInstagram!))")
            UIApplication.shared.open(fullURL!, options: [:]) { success in
                print("Instgram Opened")
            }
        }

    }

    @IBAction func openFacebook(_ sender: Any) {
        if !team.strFacebook!.isEmpty {
            let fullURL = URL(string: "https://\(String(describing: team.strFacebook!))")
            UIApplication.shared.open(fullURL!, options: [:]) { success in
                print("Facebook Opened")
            }
        }

    }
//
//    @IBAction func openTeamWebsite(_ sender: Any) {
//        if !team.strWebsite!.isEmpty {
//            let fullURL = URL(string: "https://\(String(describing: team.strWebsite!))")
//            UIApplication.shared.open(fullURL!, options: [:]) { success in
//                print("Website Opened")
//            }
//
//        }
//    }
}
