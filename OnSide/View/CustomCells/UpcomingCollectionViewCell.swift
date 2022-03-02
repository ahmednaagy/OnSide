//
//  UpcomingCollectionViewCell.swift
//  OnSide
//
//  Created by Ahmed Nagy on 01/03/2022.
//

import UIKit

class UpcomingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var upcomingEventImage: UIImageView!
    
//    lazy var spinner = UIActivityIndicatorView(style: .large)
//
//            override init(frame: CGRect) {
//                super.init(frame: frame)
//                commonInit()
//            }
//
//            required init?(coder: NSCoder) {
//                super.init(coder: coder)
//                commonInit()
//            }
//
//            private func commonInit() {
//                 spinner.translatesAutoresizingMaskIntoConstraints = false
//                contentView.addSubview(spinner)
//
//                spinner.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
//                spinner.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
//             }
    
    func configure(with event: UpcomingEvent) {
        if let data = NSData(contentsOf: event.strThumb!) {
            upcomingEventImage.image = UIImage(data: data as Data)
        } else {
            upcomingEventImage.image = UIImage(named: "placeholder")
        }
    }
}
