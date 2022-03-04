//
//  FavoriteTableViewCell.swift
//  OnSide
//
//  Created by Ahmed Nagy on 03/03/2022.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var leageName: UILabel!
    
    
    func configure(with team: FavouriteLeague) {
        if let data = NSData(contentsOf: team.strBadge!) {
            leagueImage.image = UIImage(data: data as Data)
        } else {
            leagueImage.image = UIImage(named: "placeholder")
        }
        leageName.text = team.strLeague
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
