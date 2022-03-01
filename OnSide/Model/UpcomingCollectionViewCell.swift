//
//  UpcomingCollectionViewCell.swift
//  OnSide
//
//  Created by Ahmed Nagy on 01/03/2022.
//

import UIKit

class UpcomingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var upcomingEventImage: UIImageView!
    
    func configure(with event: UpcomingEvent) {
        if let data = NSData(contentsOf: event.strThumb!) {
            upcomingEventImage.image = UIImage(data: data as Data)
        } else {
            upcomingEventImage.image = UIImage(named: "placeholder")
        }
    }
}
