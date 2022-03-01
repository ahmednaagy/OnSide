//
//  AllSportsCustomCell.swift
//  OnSide
//
//  Created by Ahmed Nagy on 24/02/2022.
//

import Foundation
import UIKit

class AllSportsCustomCell: UICollectionViewCell {
    
    @IBOutlet weak var sportImageView: UIImageView!
    
    @IBOutlet weak var sportName: UILabel!
    
    func configure(with sport: Sport) {
        if let data = NSData(contentsOf: sport.strSportThumb) {
            sportImageView.image = UIImage(data: data as Data)
        } else {
            sportImageView.image = UIImage(named: "placeholder")
        }
        sportName.text = sport.strSport
    }
}
