//
//  TeamsCollectionViewCell.swift
//  OnSide
//
//  Created by Ahmed Nagy on 01/03/2022.
//

import UIKit

class TeamsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var teamImage: UIImageView!
    
    func configure(with team: Team) {
        if let data = NSData(contentsOf: team.strTeamBadge!) {
            teamImage.image = UIImage(data: data as Data)
        } else {
            teamImage.image = UIImage(named: "placeholder")
        }
    }
}
