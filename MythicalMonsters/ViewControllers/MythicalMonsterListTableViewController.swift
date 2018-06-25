//
//  MythicalMonsterListTableViewController.swift
//  MythicalMonsters
//
//  Created by Tyler Clonts on 6/1/18.
//  Copyright © 2018 Tyler Clonts. All rights reserved.
//

import UIKit

class MythicalMonsterListTableViewController: UITableViewController, UISearchResultsUpdating {
    
    let searchController = UISearchController(searchResultsController: nil)

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        definesPresentationContext = true
        setupNavBar()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCVC), name: MonstersController.shared.tableVCReloadNotification, object: nil)
        
        self.view.backgroundColor = UIColor.mmDarkBrown
    }
    
    // Function for reloading tableview
    @objc func reloadCVC() {
        self.tableView?.reloadData()
    }

    @IBAction func addMonsterButtonTapped(_ sender: UIBarButtonItem) {
        
    }

    
    func updateSearchResults(for searchController: UISearchController) {
                    MonstersController.shared.filteredMonsters = MonstersController.shared.mythicalMonster.filter{ monster in
                        let monsterName = monster.name
                        return (monsterName.lowercased().contains(searchController.searchBar.text!.lowercased()))
                    }
                    self.tableView.reloadData()
                }

    
    func setupNavBar() {
        
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false

        searchController.searchBar.tintColor = UIColor.mmWhiteIce
//        searchController.searchBar.placeholder = "Search monsters by name"

        
     
        if #available(iOS 11.0, *) {
            
            if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
                if let backgroundview = textfield.subviews.first {
                    
                   
                    // Background color
//                    searchController.searchBar.didMoveToSuperview()
                    backgroundview.backgroundColor = UIColor.mmDeepBlue
                    backgroundview.removeFromSuperview()
                    
                   
                    // Rounded corner
                    backgroundview.layer.borderWidth = 1.0
                   backgroundview.layer.borderColor = UIColor.mmWhiteIce.cgColor
                    // Rounded corner
                    backgroundview.layer.cornerRadius = 10
                    backgroundview.clipsToBounds = true
                    
                }
            }
        
          
        }
        
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.mmWhiteIce]
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "Search monsters by name...", attributes: [NSAttributedStringKey.foregroundColor: UIColor.mmWhiteIce])




//        searchController.searchBar.searchBarStyle = .minimal
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.isOpaque = true
        
    
     
        
        

        navigationItem.title = "Mystical Creatures"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.barTintColor = UIColor.mmKhaki
        navigationController?.navigationBar.tintColor = UIColor.mmWhiteIce
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.mmWhiteIce]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.mmWhiteIce]
    
    }
    // MARK: - Table view data source

   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            if searchController.searchBar.text != "" {
                return MonstersController.shared.filteredMonsters.count
            } else {
                return MonstersController.shared.mythicalMonster.count
            }

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "monsterCell", for: indexPath) as? MonsterTableViewCell else { return UITableViewCell() }
        
//        let monster = MonstersController.shared.mythicalMonster[indexPath.row]
//        cell.monster = monster
        cell.link = self
        if searchController.searchBar.text != "" {
            let filteredMonsters = MonstersController.shared.filteredMonsters[indexPath.row]
            cell.monster = filteredMonsters
        } else {
            let monsters = MonstersController.shared.mythicalMonster[indexPath.row]
            cell.monster = monsters
           
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMonsterDetail" {
            if let destinationVC = segue.destination as? MonsterDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow?.row {
            let monster = MonstersController.shared.mythicalMonster[indexPath]
            destinationVC.monster = monster
            }
        }
    }
 

   
}
