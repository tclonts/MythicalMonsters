//
//  MythicalMonsters.swift
//  MythicalMonsters
//
//  Created by Tyler Clonts on 6/1/18.
//  Copyright © 2018 Tyler Clonts. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class MythicalMonsters {
    
    // Coding Keys
    static let typeKey = "MythicalMonsters"
    private let nameKey = "name"
    private let originKey = "origin"
    private let descriptionKey = "description"
    private let regionKey = "region"
    private let monsterImageKey = "monsterImage"
    
    // Properties
    let name: String
    let origin: String
    let description: String
    let region: String
    var cloudKitRecordID: CKRecordID?
    
//    let monsterImage: Data?
//    var photo: UIImage? {
//        guard let monsterImage = self.monsterImage else { return nil}
//        return UIImage(data: monsterImage)
//    }
    
    // Initializer
    init(name: String, origin: String, description: String, region: String) {
        self.name = name
        self.origin = origin
        self.description = description
        self.region = region
//        self.monsterImage = monsterImage
    }
    
    // Failable Initializer
    
    init?(cloudKitRecord: CKRecord) {
        guard let name = cloudKitRecord[nameKey] as? String,
            let origin = cloudKitRecord[originKey] as? String,
            let description = cloudKitRecord[descriptionKey] as? String,
            let region = cloudKitRecord[regionKey] as? String else { return nil }
        
        self.name = name
        self.origin = origin
        self.description = description
        self.region = region
        self.cloudKitRecordID = cloudKitRecord.recordID
    }
    
    // Used to save to CloudKit
    
    var cloudKitRecord: CKRecord {
       
        let recordID = cloudKitRecordID ?? CKRecordID(recordName: UUID().uuidString)
        let record = CKRecord(recordType: MythicalMonsters.typeKey, recordID: recordID)
            
        record.setValue(name, forKey: nameKey)
        record.setValue(origin, forKey: originKey)
        record.setValue(description, forKey: descriptionKey)
        record.setValue(region, forKey: regionKey)
        
        cloudKitRecordID = recordID
        return record
    }
    
    
    
    
    
    
}
