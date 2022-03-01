//
//  LeaguesTableViewCell.swift
//  OnSide
//
//  Created by Ahmed Nagy on 25/02/2022.
//

import UIKit

protocol MyLeagueTableViewCellDelegate: AnyObject  {
    func didTapBuuton(with youtubeURL: String)
}

class LeaguesTableViewCell: UITableViewCell {

    weak var delegate: MyLeagueTableViewCellDelegate?
    
    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var youtubeButton: UIButton!
    private var youtubeURL: String = ""
    
    @IBAction func youtubeButtonTapped(_ sender: Any) {
        delegate?.didTapBuuton(with: youtubeURL)
    }
    
    
    func configure(with league: League) {
        if let data = NSData(contentsOf: league.strBadge) {
            leagueImage.image = UIImage(data: data as Data)
        } else {
            leagueImage.image = UIImage(named: "placeholder")
        }
        leagueName.text = league.strLeague
        self.youtubeURL = league.strYoutube
    }
    
}
