//
//  ResultsCollectionViewCell.swift
//  OnSide
//
//  Created by Ahmed Nagy on 01/03/2022.
//

import UIKit

class ResultsCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var resultsImage: UIImageView!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    func configure(with result: Result) {
        if let data = NSData(contentsOf: result.strThumb!) {
            resultsImage.image = UIImage(data: data as Data)
        } else {
            resultsImage.image = UIImage(named: "placeholder")
        }
        resultLabel.text = "\(result.strHomeTeam!) \(result.intHomeScore!) : \(result.strAwayTeam!) \(result.intAwayScore!)"
    }
    
}
