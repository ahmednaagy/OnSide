//
//  LeaguesTableViewController.swift
//  OnSide
//
//  Created by Ahmed Nagy on 24/02/2022.
//

import UIKit

class LeaguesTableViewController: UITableViewController {
    
    
    // data source
    var leagues = [League]()
    var sport: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = CGPoint(x: self.view.bounds.width / 2, y: 300)
        indicator.color = .green
        self.view.addSubview(indicator)
        indicator.startAnimating()
        
        SportsAPI.requestLeagues(sport: sport!) { myLeagues, error in
            guard let myLeagues = myLeagues else {
                return
            }
            self.leagues = myLeagues
            DispatchQueue.main.async {
                self.tableView.reloadData()
                indicator.stopAnimating()
            }
        }
        
        title = sport
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leagues.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leaguesCell", for: indexPath) as! LeaguesTableViewCell
        
        // Configure the cell...
        cell.configure(with: leagues[indexPath.row])
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let leaguesCollectionViewsController = storyboard?.instantiateViewController(withIdentifier: Constants.LeaguesCollectionViewsController) as! LeaguesCollectionViewsController
        leaguesCollectionViewsController.league = leagues[indexPath.row]
        navigationController?.pushViewController(leaguesCollectionViewsController, animated: true)
    }
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    //        let cellLabel = cell.viewWithTag(1001) as! UILabel
    //        let cellImage = cell.viewWithTag(1000) as! UIImageView
    //        let cellButton = cell.viewWithTag(1002) as! UIButton
    //
    //        if let data = NSData(contentsOf: leagues[indexPath.row].strBadge) {
    //            cellImage.image = UIImage(data: data as Data)
    //        } else {
    //            cellImage.image = UIImage(named: "placeholder")
    //        }
    //        cellLabel.text = leagues[indexPath.row].strLeagueAlternate

    
}


extension LeaguesTableViewController: MyLeagueTableViewCellDelegate {
    
    func didTapBuuton(with youtubeURL: String) {
        if youtubeURL.isEmpty {
            InvalidUrlAlert()
            return
        }
        guard let url = URL(string: "https://\(youtubeURL)") else {
                return
            }
            UIApplication.shared.open(url, completionHandler: { success in
                if !success {
                    self.InvalidUrlAlert()
                }
            })
    }
    
    func InvalidUrlAlert() {
        let alert = UIAlertController(title: "NO LINK FOUND", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        present(alert, animated: true) {
            print("Alert invalid youtube link triggered")
        }
    }
    
    
}
