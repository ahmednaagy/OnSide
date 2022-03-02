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
    


}
