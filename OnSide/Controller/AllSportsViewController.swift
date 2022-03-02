//
//  AllSportsViewController.swift
//  OnSide
//
//  Created by Ahmed Nagy on 24/02/2022.
//

import UIKit

class AllSportsViewController: UIViewController, UICollectionViewDelegate {
    
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    
    private let cellPadding: CGFloat = 8
    
    // data Source
    var sports = [Sport]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "OnSide"
        
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = self.view.center
        indicator.color = .green
        self.view.addSubview(indicator)
        indicator.startAnimating()
        
        // Do any additional setup after loading the view.
        SportsAPI.requestAllSports { sportsRes, error in
            guard let sportsRes = sportsRes else {
                return
            }
            self.sports = sportsRes
            DispatchQueue.main.async {
                self.myCollectionView.reloadData()
                indicator.stopAnimating()
            }
            print(self.sports)
        }
    }
    
    //MARK: - UICollectionViewDelegate Methods
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let leagesVC = storyboard?.instantiateViewController(withIdentifier: Constants.LeaguesTableViewControllerIdentifier) as! LeaguesTableViewController
        leagesVC.sport = sports[indexPath.row].strSport
        self.navigationController?.pushViewController(leagesVC, animated: true)
    }
    
}

extension AllSportsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.sportsCellIdentifier, for: indexPath) as! AllSportsCustomCell
        cell.configure(with: sports[indexPath.row])
        cell.contentView.layer.cornerRadius = 8
        return cell
    }
    
}


extension AllSportsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width * 0.26)
        return CGSize(width: size, height: size + 30)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellPadding, left: 10, bottom: cellPadding, right: 10)
    }
}
