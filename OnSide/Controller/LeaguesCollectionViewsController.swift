//
//  LeaguesCollectionViewsController.swift
//  OnSide
//
//  Created by Ahmed Nagy on 01/03/2022.
//

import UIKit
import CoreData

class LeaguesCollectionViewsController: UITableViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    @IBOutlet weak var upcomingCollectionView: UICollectionView!
    @IBOutlet weak var resultsCollectionView: UICollectionView!
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    
    var league: League!
    var upcomingevents = [UpcomingEvent]()
    var results = [Result]()
    var teams = [Team]()
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = league.strLeague!
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToFavorite))
        
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = CGPoint(x: self.view.bounds.width / 2, y: 300)
        indicator.color = .green
        self.view.addSubview(indicator)
        indicator.startAnimating()
        
        
        self.upcomingCollectionView.delegate = self
        self.upcomingCollectionView.dataSource = self
        
        let layout = self.upcomingCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        
        self.resultsCollectionView.delegate = self
        self.resultsCollectionView.dataSource = self
        
        let layout2 = self.resultsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout2.scrollDirection = .vertical
        
        self.teamsCollectionView.delegate = self
        self.teamsCollectionView.dataSource = self
        
        let layout3 = self.teamsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout3.scrollDirection = .horizontal
        
        SportsAPI.requestUpcomingEvents(leagueName: league.strLeague ?? "") { leagueUpcomingEvents, error in
            
            guard let leagueUpcomingEvents = leagueUpcomingEvents else {
                return
            }
            self.upcomingevents = leagueUpcomingEvents
            print(self.upcomingevents)
            DispatchQueue.main.async {
                self.upcomingCollectionView.reloadData()
                indicator.stopAnimating()
            }
        }
        
        SportsAPI.requestResults(id: league.idLeague ?? "4617") { leagueResult, error in
            
            guard let leagueResult = leagueResult else {
                return
            }
            
            self.results = leagueResult
            DispatchQueue.main.async {
                self.resultsCollectionView.reloadData()
                indicator.stopAnimating()
            }
        }
        
        SportsAPI.requestTeams(league: league.strLeague ?? "English Premier League") { leagueTeams, error in
            
            guard let leagueTeams = leagueTeams else {
                return
            }
            
            self.teams = leagueTeams
            DispatchQueue.main.async {
                self.teamsCollectionView.reloadData()
                indicator.stopAnimating()
            }
        }
        
    }
    
    // MARK: - Table view data source
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case upcomingCollectionView:
            print(upcomingevents.count)
            return upcomingevents.count
        case resultsCollectionView:
            return results.count
        case teamsCollectionView:
            return teams.count
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case upcomingCollectionView:
            
            let cell = upcomingCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.upcomingCollectionViewCell, for: indexPath) as! UpcomingCollectionViewCell
            cell.contentView.layer.cornerRadius = 20
            cell.configure(with: upcomingevents[indexPath.row])
            return cell
            
        case resultsCollectionView:
            
            let cell = resultsCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.resultCollectionViewCell, for: indexPath) as! ResultsCollectionViewCell
            cell.contentView.layer.cornerRadius = 20
            cell.configure(with: results[indexPath.row])
            return cell
            
        case teamsCollectionView:
            
            let cell = teamsCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.teamsCollectionViewCell, for: indexPath) as! TeamsCollectionViewCell
            cell.contentView.layer.cornerRadius = 20
            cell.configure(with: teams[indexPath.row])
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case upcomingCollectionView:
            return CGSize(width: upcomingCollectionView.bounds.size.width - 35, height: 130)
        case resultsCollectionView:
            return CGSize(width: resultsCollectionView.bounds.size.width - 35, height: 130)
        case teamsCollectionView:
            return CGSize(width: teamsCollectionView.bounds.size.width - 35, height: 130)
        default:
            return CGSize(width: view.bounds.size.width, height: 50)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let TeamDetailsViewController = storyboard?.instantiateViewController(withIdentifier: Constants.TeamDetailsViewController) as! TeamDetailsViewController
        TeamDetailsViewController.team = teams[indexPath.row]
        if collectionView == teamsCollectionView {
            self.navigationController?.pushViewController(TeamDetailsViewController, animated: true)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case upcomingCollectionView:
            return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 10)
        case resultsCollectionView:
            return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 10)
        case teamsCollectionView:
            return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 10)
        default:
            return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 10)
            
        }
    }
    
    @objc func addToFavorite() {
        save()
    }
    
    func save() {
        
        
        let favoriteLeague = FavouriteLeague(context: context)
        favoriteLeague.leagueName = league.strLeague
        favoriteLeague.leagueBadge = league.strBadge
        favoriteLeague.youtube = league.strYoutube
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    

    func retrieveSavedMovies() {
        
    }
    
    
    
    
    
}
