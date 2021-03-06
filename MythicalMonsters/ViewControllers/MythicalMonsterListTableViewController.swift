//
//  MythicalMonsterListTableViewController.swift
//  MythicalMonsters
//
//  Created by Tyler Clonts on 6/1/18.
//  Copyright © 2018 Tyler Clonts. All rights reserved.
//

import UIKit
import MapKit


class MythicalMonsterListTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate, UISearchBarDelegate, UINavigationControllerDelegate, UISearchResultsUpdating {
 
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapTableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addButton.isEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
        mapView.delegate = self
        mapTableView.delegate = self
        mapTableView.dataSource = self
        self.mapTableView.isHidden = true
        definesPresentationContext = true
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCVC), name: MonstersController.shared.tableVCReloadNotification, object: nil)
        
        
        self.view.backgroundColor = UIColor.mmDarkBrown
        
        tableView.backgroundColor = UIColor.mmDarkBrown
        navigationItem.searchController?.searchBar.delegate = self
        setupNavBar()
        updateSearchResults(for: searchController)
    }
    
    @IBAction func unwindToMainMenu(sender: UIStoryboardSegue)
    {
    }
    
    // MARK: -Properties
    
    var isFlip = true
    var coordinates: CLLocationCoordinate2D?
    
    
    @IBAction func mapButtonTapped(_ sender: UIBarButtonItem) {
        navigationItem.searchController?.searchBar.text = ""

        if (isFlip == true) {
            
            mapView.isHidden = true
            if let image = UIImage(named: "listIcon") {
                mapButton.image = image
            }
//            navigationItem.searchController?.searchBar.isHidden = true
            navigationItem.searchController?.searchBar.placeholder = "Search region by name..."
            
            let textFieldInsideSearchBar = navigationItem.searchController?.searchBar.value(forKey: "searchField") as? UITextField
            textFieldInsideSearchBar?.textColor = UIColor.mmWhiteIce
            
            let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.value(forKey: "placeholderLabel") as? UILabel
            textFieldInsideSearchBarLabel?.textColor = UIColor.mmWhiteIce
            
            populateMapView()
            let regionRadius: CLLocationDistance = 5000000
            let utahLocation = CLLocationCoordinate2D(latitude: 28.0, longitude: 30.0)
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(utahLocation, regionRadius, regionRadius)
            mapView.setRegion(coordinateRegion, animated: true)
        } else {
            mapView.isHidden = false
            navigationItem.searchController?.searchBar.isHidden = false
            navigationItem.searchController?.searchBar.placeholder = "Search monster by name..."
            
            let textFieldInsideSearchBar = navigationItem.searchController?.searchBar.value(forKey: "searchField") as? UITextField
            textFieldInsideSearchBar?.textColor = UIColor.mmWhiteIce
            
            let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.value(forKey: "placeholderLabel") as? UILabel
            textFieldInsideSearchBarLabel?.textColor = UIColor.mmWhiteIce
            
            if let image = UIImage(named: "mapIcon") {
                mapButton.image = image
            }
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
        for monster in monsters {
            guard let lat = Double(monster.latitude),
                let lon = Double(monster.longitude) else { return }
            guard let image = monster.photo else { return }
            let locationCoordinates = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            let monster = MythicalMonster(name: monster.name, longitude: monster.longitude, latitude: monster.latitude, coordinate: monster.coordinate, origin: monster.origin, monsterDescription: monster.monsterDescription, type: monster.type, webLink: monster.webLink, monsterImage: monster.monsterImage)
            
            if let monsterAnnotationIndex = annotations.index(where: {$0.coordinate == monster.coordinate}) {
                annotations.remove(at: monsterAnnotationIndex)
            }
            mapView.removeAnnotations(annotations)
            mapView.addAnnotation(monster)
        }
    }

    let regionRadius: CLLocationDistance = 50000
    func centerMapOn(monster: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(monster.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    

    func updateSearchResults(for searchController: UISearchController) {
        
                    MonstersController.shared.filteredMonsters = MonstersController.shared.mythicalMonster.filter{ monster in
                        let monsterName = monster.name
                        return (monsterName.lowercased().contains(searchController.searchBar.text!.lowercased()))
                    }
                    self.tableView.reloadData()
                }

    
    func setupNavBar() {
        self.searchController.searchResultsUpdater = self as? UISearchResultsUpdating
        self.searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.delegate = self
        
        searchController.searchBar.tintColor = UIColor.mmWhiteIce

        if #available(iOS 11.0, *) {
            
            if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
                if let backgroundview = textfield.subviews.first {
                   
                    // Background color
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if mapTableView.isHidden == true {
            if navigationItem.searchController?.searchBar.text != ""{
                return MonstersController.shared.filteredMonsters.count
            } else {
                return MonstersController.shared.mythicalMonster.count
            }
        }
        else if mapTableView.isHidden == false {
            if navigationItem.searchController?.searchBar.text != "" {
                return MonstersController.shared.mythicalMonster.count
            }
        }
        return 0
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if mapTableView.isHidden == true {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "monsterCell", for: indexPath) as? MonsterTableViewCell else { return UITableViewCell() }
        
        cell.link = self
        if navigationItem.searchController?.searchBar.text != "" {
            let filteredMonsters = MonstersController.shared.filteredMonsters[indexPath.row]
            cell.monster = filteredMonsters
        } else {
            let monsters = MonstersController.shared.mythicalMonster[indexPath.row]
            cell.monster = monsters
           
        }
        
        return cell
        } else {
            return UITableViewCell()
        }
    }
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if mapView.isHidden == false {
        //Ignoring user
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        //Activity Indicator
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        self.view.addSubview(activityIndicator)
        
        //Hide search bar
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        //Create the search request
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = searchBar.text
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        
        activeSearch.start { (response, error) in
            
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if response == nil
            {
                print("ERROR")
            }
            else
            {
                //Remove annotations
                let annotations = self.mapView.annotations
//                self.mapView.removeAnnotations(annotations)
                
                //Getting data
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                //Create annotation
                let annotation = MKPointAnnotation()
                annotation.title = searchBar.text
                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                
                self.mapView.addAnnotation(annotation)
                
                
                
                //Zooming in on annotation
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                let span = MKCoordinateSpanMake(0.1, 0.1)
                let region = MKCoordinateRegionMake(coordinate, span)
                self.mapView.setRegion(region, animated: true)
            }
            }
        }
    }

//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

//
//        let geocoder = CLGeocoder()
//
//        geocoder.geocodeAddressString(searchController.searchBar.text!) { (placemarks: [CLPlacemark]?, error: Error?) in
//            if error == nil {
//
//                let placemark = placemarks?.first
//                let annotation = MKPointAnnotation()
//                annotation.coordinate = (placemark?.location?.coordinate)!
//                annotation.title = self.searchController.searchBar.text
//
//                self.mapView.addAnnotation(annotation)
//                self.mapView.selectAnnotation(annotation, animated: true)
//
//
//            }else {
//                print(error?.localizedDescription ?? "Error")
//            }
//        }
//    }
    
// This is the table view for the search during
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        mapTableView.isHidden = true
//        let geocoder = CLGeocoder()
//
//        geocoder.geocodeAddressString(searchController.searchBar.text!) { (placemarks: [CLPlacemark]?, error: Error?) in
//            if error == nil {
//
//                let placemark = placemarks?.first
//                let annotation = MKPointAnnotation()
//                annotation.coordinate = (placemark?.location?.coordinate)!
//                annotation.title = self.searchController.searchBar.text
//
//                self.mapView.addAnnotation(annotation)
//                self.mapView.selectAnnotation(annotation, animated: true)
//
//
//            }else {
//                print(error?.localizedDescription ?? "Error")
//            }
//        }
//    }
    

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
        } else if segue.identifier == "fromPinToDetail" {
                guard let view = sender as? MKAnnotationView,
                    let detailVC = segue.destination as? MonsterDetailViewController else { return }
                let monster = view.annotation as? MythicalMonster
                detailVC.monster = monster
            }
        }
    }
// MARK: - MKMapViewDelegate

// This is what we use to edit our annotations (bubbles) on the map...
extension MythicalMonsterListTableViewController: MKMapViewDelegate {
    // 1
    
    // The MapView's cellForRowAt
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        let annotation = annotation as? MythicalMonster
        
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else if searchController.searchBar.text == "" || searchController.searchBar.text == annotation?.title {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .infoDark)
            view.markerTintColor = UIColor.mmDeepBlue

            view.glyphImage = #imageLiteral(resourceName: "MML")

        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .infoDark)
            view.markerTintColor = UIColor.mmWhiteIce
            view.glyphText = "📍"

        }
//        else {
//            // 5
//            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//            view.canShowCallout = true
//            view.calloutOffset = CGPoint(x: -5, y: 5)
//            view.rightCalloutAccessoryView = UIButton(type: .infoDark)
//            view.markerTintColor = UIColor.mmDeepBlue
//
//            view.glyphImage = #imageLiteral(resourceName: "MML")     }
//         ✪⚑⚐🐟
        return view

    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        performSegue(withIdentifier: "fromPinToDetail", sender: view)
    }

}
