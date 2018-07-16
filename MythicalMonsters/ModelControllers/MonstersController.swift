//
//  MonstersController.swift
//  MythicalMonsters
//
//  Created by Tyler Clonts on 6/2/18.
//  Copyright © 2018 Tyler Clonts. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class MonstersController {
    
    static let shared = MonstersController()
    let publicDB = CKContainer.default().publicCloudDatabase
    let tableVCReloadNotification = Notification.Name("reloadTVC")
    
    var filteredMonsters = [MythicalMonster]()
    var mythicalMonster: [MythicalMonster] = [] {
        didSet {
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: self.tableVCReloadNotification, object: nil)
//                self.mythicalMonster.sort{ $0.name < $1.name}
            }
        }
    }
    
    init() {
        loadFromPersistentStore()
    }
    
    // Create
    
    func createMonster(monsterImage: UIImage?, name: String, longitude: String, latitude: String, coordinate: CLLocationCoordinate2D, origin: String, description: String, type: String, webLink: String,  completion: @escaping(_ success: Bool) -> Void) {
        guard let monsterImage = monsterImage else { return }
        guard let data = UIImageJPEGRepresentation(monsterImage, 0.8) else { return }
        
        guard let latittude = Double(latitude) else { return }
        guard let longittude = Double(longitude) else { return }
        let locationCoordinates = CLLocationCoordinate2D(latitude: latittude, longitude: longittude)
        
        let newMonster = MythicalMonster(name: name, longitude: longitude, latitude: latitude, coordinate: locationCoordinates, origin: origin, monsterDescription: description, type: type, webLink: webLink, monsterImage: data)
        mythicalMonster.append(newMonster)
        saveToPersistentStore()
        completion(true)
        
    }

    // Delete
    
    // Update
    
    // Fetch from CloudKit
    func loadFromPersistentStore() {
        CloudKitManager.shared.fetchRecordsOf(type: MythicalMonster.typeKey, database: publicDB) { (records, error) in
            if let error = error {
                print("Error fetching monsters from cloudkit: \(error.localizedDescription)")
            } else {
                print("Success fetching monsters from cloudkit")
            }
            guard let records = records else { return }
            var monsters = records.compactMap{MythicalMonster(cloudKitRecord: $0)}
            let sortedMonstersArray = monsters.sorted (by:{ $0.name < $1.name })
            self.mythicalMonster = sortedMonstersArray
        }
    }
    
    // Save to Cloudkit
    func saveToPersistentStore() {
        let monsterRecords = mythicalMonster.map({$0.cloudKitRecord})
        
        CloudKitManager.shared.saveRecordsToCloudKit(record: monsterRecords, database: publicDB, perRecordCompletion: nil) { (_, _, error) in
            if let error = error {
                print("Error saving monster to cloudkit: \(error.localizedDescription)")
            } else {
                print("Success saving monster to cloudkit")
            }
        
        }
    }
}
