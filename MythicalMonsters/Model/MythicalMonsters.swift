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
    private let monsterImageKey = "monsterImage"
    
    // Properties
    let name: String
    let origin: String
//    let monsterImage: Data?
    var cloudKitRecordID: CKRecordID?
//    var photo: UIImage? {
//        guard let monsterImage = self.monsterImage else { return nil}
//        return UIImage(data: monsterImage)
//    }
    
    // Initializer
    init(name: String, origin: String) {
        self.name = name
        self.origin = origin
//        self.monsterImage = monsterImage
    }
    
    // Failable Initializer
    
    init?(cloudKitRecord: CKRecord) {
        guard let name = cloudKitRecord[nameKey] as? String,
            let origin = cloudKitRecord[originKey] as? String else { return nil }
        
        self.name = name
        self.origin = origin
        self.cloudKitRecordID = cloudKitRecord.recordID
    }
    
    var cloudKitRecord: CKRecord {
       
        let recordID = cloudKitRecordID ?? CKRecordID(recordName: UUID().uuidString)
        let record = CKRecord(recordType: MythicalMonsters.typeKey, recordID: recordID)
            
        record.setValue(name, forKey: nameKey)
        record.setValue(origin, forKey: originKey)
        
        cloudKitRecordID = recordID
        return record
    }
    
    
    
    
}
