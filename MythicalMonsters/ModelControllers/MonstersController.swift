//
//  MonstersController.swift
//  MythicalMonsters
//
//  Created by Tyler Clonts on 6/2/18.
//  Copyright © 2018 Tyler Clonts. All rights reserved.
//

import Foundation
import CloudKit

class MonstersController {
    
    static let shared = MonstersController()
    let publicDB = CKContainer.default().publicCloudDatabase
    
    var mythicalMonsters: [MythicalMonsters] = []
    
    init() {
        loadFromPersistentStore()
    }
    // Create
    
    // Delete
    
    // Update
    
    // Fetch from CloudKit
    func loadFromPersistentStore() {
        CloudKitManager.shared.fetchRecordsOf(type: MythicalMonsters.typeKey, database: publicDB) { (records, error) in
            if let error = error {
                print("Error fetching recipes from cloudkit: \(error.localizedDescription)")
            } else {
                print("Success fetching recipes from cloudkit")
            }
            guard let records = records else { return }
            let monsters = records.compactMap{MythicalMonsters(cloudKitRecord: $0)}
            self.mythicalMonsters = monsters
            
        }
    }
    
    // Save to Cloudkit
    func saveToPersistentStore() {
        let monsterRecords = mythicalMonsters.map({$0.cloudKitRecord})
        
        CloudKitManager.shared.saveRecordsToCloudKit(record: monsterRecords, database: publicDB, perRecordCompletion: nil) { (_, _, error) in
            if let error = error {
                print("Error saving recipes to cloudkit: \(error.localizedDescription)")
            } else {
                print("Success saving recipes to cloudkit")
            }
        }
    }
}
