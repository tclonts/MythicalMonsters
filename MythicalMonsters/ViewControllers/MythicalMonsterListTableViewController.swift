//
//  MythicalMonsterListTableViewController.swift
//  MythicalMonsters
//
//  Created by Tyler Clonts on 6/1/18.
//  Copyright © 2018 Tyler Clonts. All rights reserved.
//

import UIKit
import MapKit


class MythicalMonsterListTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate, UISearchBarDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapTableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapButton: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.delegate = self
        tableView.dataSource = self
        mapView.delegate = self as! MKMapViewDelegate
        mapTableView.delegate = self
        mapTableView.dataSource = self
        self.mapTableView.isHidden = true
        
        
//        addButton.tintColor = .clear
        definesPresentationContext = true
        setupNavBar()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCVC), name: MonstersController.shared.tableVCReloadNotification, object: nil)
        
        self.view.backgroundColor = UIColor.mmDarkBrown
    }
    
    // MARK: -Properties
    
    var isFlip = true
    var coordinates: CLLocationCoordinate2D?
    
    
    
    @IBAction func mapButtonTapped(_ sender: UIBarButtonItem) {
        if (isFlip == true) {
            mapView.isHidden = true

            self.mapButton.image = UIImage(named: "listIcon")
//            self.mapButton.setImage(UIImage(named: "MonsterIcon3"), for: .normal)
            self.searchBar.placeholder = "Search by monster name..."
            populateMapView()
            let regionRadius: CLLocationDistance = 500000
            let utahLocation = CLLocationCoordinate2D(latitude: 39.4759385, longitude: -111.54658374)
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(utahLocation, regionRadius, regionRadius)
            mapView.setRegion(coordinateRegion, animated: true)
        } else {
            mapView.isHidden = false
            self.mapButton.image = UIImage(named: "mapIcon")

//            self.mapButton.setImage(UIImage(named: "mapIcon"), for: .normal)
            self.searchBar.placeholder = "Search by region name..."
        }
        
        UIView.transition(from: isFlip ? tableView : mapView,
                          to: isFlip ? mapView : tableView,
                          duration: 0.6,
                          options: [.transitionFlipFromLeft, .showHideTransitionViews]) { (finish) in
                            if finish {
                                self.isFlip = !self.isFlip
                                if self.tableView != nil {
                                    self.mapView.isHidden = false
                                } else {
                                    self.mapView.isHidden = true
                                }
                            }
        }
    }
    
    
    @IBAction func addMonsterButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    
    // Function for reloading tableview
    @objc func reloadCVC() {
        self.tableView?.reloadData()
    }
    
    func populateMapView() {
        var annotations = mapView.annotations
        let monsters = MonstersController.shared.mythicalMonster
        for location in locations {
            guard let lat = Double(location.latitude),
                let lon = Double(location.longitude) else { return }
            guard let image = location.image else { return }
            let locationCoordinates = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            let location = Location(locationName: location.locationName, longitude: location.longitude, latitude: location.latitude, coordinate: locationCoordinates, hatches: location.hatches ?? [], species: location.species, waterflowURL: location.waterflowURL ?? "", hotness: location.hotness ?? "Unknown", image: image)
            if let locationAnnotationIndex = annotations.index(where: {$0.coordinate == location.coordinate}) {
                annotations.remove(at: locationAnnotationIndex)
            }
            mapView.removeAnnotations(annotations)
            mapView.addAnnotation(location)
        }
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

        navigationItem.title = "Maze of Monsters"
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
            if let indexPath = tableView.indexPathForSelectedRow,
                let detailVC = segue.destination as? MonsterDetailViewController {
                if searchController.searchBar.text != "" {
                    let filteredMonsters = MonstersController.shared.filteredMonsters[indexPath.row]
                    detailVC.monster = filteredMonsters
                } else {
                    let monster = MonstersController.shared.mythicalMonster[indexPath.row]
                    detailVC.monster = monster
                }
            }
        }
    }
 

   
}
