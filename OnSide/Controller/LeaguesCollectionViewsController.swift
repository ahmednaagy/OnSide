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
    var fetchedLeague = [FavouriteLeague]()
    
    var notificationButton: UIBarButtonItem!
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = league.strLeague!
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToFavorite))
        notificationButton = UIBarButtonItem(image: UIImage(systemName: "suit.heart"), style: .plain, target: self, action: #selector(notifyMe))
        //        let barbutton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(notifyMe))
        self.navigationItem.rightBarButtonItems?.append(notificationButton)
        
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
    
    @objc func notifyMe() {
        
        // Gets you half way there //
        UIView.animate(withDuration: 0.05, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.notificationButton.customView?.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
            self.notificationButton.image = UIImage(systemName: "heart.fill")
        }, completion: nil)
        
        // Rotates all the way around //
        UIView.animate(withDuration: 0.5, delay: 0.5, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.notificationButton.customView?.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 2))
            self.notificationButton.image = UIImage(systemName: "heart.fill")
            
        }, completion: nil)
        
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Match Call! 🔔"
        content.subtitle = "You favorite leage is starting 🎉"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: (upcomingevents.first?.strTimestamp!)!)
        
        
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date!)
        
                let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request, withCompletionHandler: nil)
        
    }
    
    @objc func addToFavorite() {
        save()
    }
    
    func save() {
        
        
        
        let favoriteLeagues = FavouriteLeague(context: context)
        favoriteLeagues.idLeague = self.league.idLeague
        favoriteLeagues.strLeague = self.league.strLeague
        favoriteLeagues.strBadge = self.league.strBadge
        favoriteLeagues.strYoutube = self.league.strYoutube
        favoriteLeagues.strPoster = self.league.strPoster
        favoriteLeagues.strDescriptionEN = self.league.strDescriptionEN
        
        if let tabItems = tabBarController?.tabBar.items {
            // In this case we want to modify the badge number of the third tab:
            let tabItem = tabItems[1]
            tabItem.badgeValue = String(fetchedLeague.count + 1)
        }
        
        try? context.save()
        
    }
    
    
    func checkIfItemExist(league: League) -> Bool {
        
        //        let managedContext = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavouriteLeague")
        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = NSPredicate(format: "idLeague == %@" ,league.idLeague!)
        
        do {
            let count = try context.count(for: fetchRequest)
            if count > 0 {
                return true
            }else {
                return false
            }
        }catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
        }
    }
    
    func fetchLeagues() -> [FavouriteLeague]? {
        do {
            return try context.fetch(FavouriteLeague.fetchRequest())
        } catch {
            print("fetching error")
            return nil
        }
    }
    
    
    
}
