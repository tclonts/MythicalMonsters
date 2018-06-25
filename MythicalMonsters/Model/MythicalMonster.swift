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

class MythicalMonster {
    
    // Coding Keys
    static let typeKey = "MythicalMonsters"
    private let nameKey = "name"
    private let originKey = "origin"
    private let descriptionKey = "description"
    private let typeKey = "type"
    private let webLinkKey = "webLink"
    private let monsterImageKey = "monsterImage"
    
    // Properties
    let name: String
    let origin: String
    let description: String
    let type: String
    let webLink: String
    var cloudKitRecordID: CKRecordID?
    
    let monsterImage: Data?
    var photo: UIImage? {
        guard let monsterImage = self.monsterImage else { return nil}
        return UIImage(data: monsterImage)
    }
    
    // Initializer
    init(name: String, origin: String, description: String, type: String, webLink: String, monsterImage: Data? = UIImagePNGRepresentation(#imageLiteral(resourceName: "MysticalMonstersLogo-1"))) {
        self.name = name
        self.origin = origin
        self.description = description
        self.type = type
        self.webLink = webLink
        self.monsterImage = monsterImage
    }
    
    // Failable Initializer
    
    init?(cloudKitRecord: CKRecord) {
        guard let name = cloudKitRecord[nameKey] as? String,
            let origin = cloudKitRecord[originKey] as? String,
            let description = cloudKitRecord[descriptionKey] as? String,
            let type = cloudKitRecord[typeKey] as? String,
            let webLink = cloudKitRecord[webLinkKey] as? String,
            let photoAsset = cloudKitRecord[monsterImageKey] as? CKAsset else { return nil}
            let monsterImage = try? Data(contentsOf: photoAsset.fileURL)

        
        self.name = name
        self.origin = origin
        self.description = description
        self.type = type
        self.webLink = webLink
        self.monsterImage = monsterImage
        self.cloudKitRecordID = cloudKitRecord.recordID
    }
    
    // Used to save to CloudKit
    
    var cloudKitRecord: CKRecord {
       
        let recordID = cloudKitRecordID ?? CKRecordID(recordName: UUID().uuidString)
        let record = CKRecord(recordType: MythicalMonster.typeKey, recordID: recordID)
            
        record.setValue(name, forKey: nameKey)
        record.setValue(origin, forKey: originKey)
        record.setValue(description, forKey: descriptionKey)
        record.setValue(type, forKey: typeKey)
        record.setValue(webLink, forKey: webLinkKey)
        
        if let monsterImage = monsterImage{
            record[monsterImageKey] = CKAsset(fileURL: temporaryPhotoURL)
        }
        
        cloudKitRecordID = recordID
        return record
    }
    
    fileprivate var temporaryPhotoURL: URL {
        
        // Must write to temporary directory to be able to pass image file path url to CKAsset
        
        let temporaryDirectory = NSTemporaryDirectory()
        let temporaryDirectoryURL = URL(fileURLWithPath: temporaryDirectory)
        let fileURL = temporaryDirectoryURL.appendingPathComponent(UUID().uuidString).appendingPathExtension("jpg")
        
        try? monsterImage?.write(to: fileURL, options: [.atomic])
        
        return fileURL
    }
}

