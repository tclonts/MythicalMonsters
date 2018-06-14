//
//  MythicalMonsterListTableViewController.swift
//  MythicalMonsters
//
//  Created by Tyler Clonts on 6/1/18.
//  Copyright © 2018 Tyler Clonts. All rights reserved.
//

import UIKit

class MythicalMonsterListTableViewController: UITableViewController, UISearchResultsUpdating {
    

//    @IBOutlet weak var searchBar: UISearchBar!

//    var resultsController = UITableViewController()
    let searchController = UISearchController(searchResultsController: nil)

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
//        searchController = UISearchController(searchResultsController: self.resultsController)

//        self.resultsController.tableView.dataSource = self
//        self.resultsController.tableView.delegate = self
        definesPresentationContext = true
        setupNavBar()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCVC), name: MonstersController.shared.tableVCReloadNotification, object: nil)
    }
  
    // Function for reloading tableview
    @objc func reloadCVC() {
        self.tableView?.reloadData()
    }

    @IBAction func addMonsterButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    
    // MARK: - SearchBar Functions and Setup
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//        filterContent(searchText: self.searchBar.text!)
//    }
//
//    func filterContent(searchText: String) {
//            MonstersController.shared.filteredMonsters = MonstersController.shared.mythicalMonster.filter{ monster in
//                let monsterName = monster.name
//                return (monsterName.lowercased().contains(searchText.lowercased()))
//            }
//            tableView.reloadData()
//        }
    
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
        searchController.searchBar.placeholder = "Search monsters by name"
        navigationItem.searchController = searchController
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.isOpaque = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.barTintColor = ColorHelper.shared.gray
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
    
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
