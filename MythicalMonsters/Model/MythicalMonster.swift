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
import MapKit

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude &&
            lhs.longitude == rhs.longitude
    }
}

class MythicalMonster: NSObject, MKAnnotation{
    
    // Coding Keys
    static let typeKey = "MythicalMonsters"
    private let longitudeKey = "longitutde"
    private let latitudeKey = "latitude"
    private let nameKey = "name"
    private let originKey = "origin"
    private let descriptionKey = "description"
    private let typeKey = "type"
    private let webLinkKey = "webLink"
    private let monsterImageKey = "monsterImage"
    
    // Properties
    let name: String
    let origin: String
    let longitude: String
    let latitude: String
    var coordinate: CLLocationCoordinate2D
    let type: String
    let webLink: String
    let monsterDescription: String
    var cloudKitRecordID: CKRecordID?
    
    let monsterImage: Data?
    var photo: UIImage? {
        guard let monsterImage = self.monsterImage else { return nil}
        return UIImage(data: monsterImage)
    }
    
    // Initializer
    init(name: String, longitude: String, latitude: String, coordinate: CLLocationCoordinate2D, origin: String, monsterDescription: String, type: String, webLink: String, monsterImage: Data? = UIImagePNGRepresentation(#imageLiteral(resourceName: "WolfPaths"))) {
        self.name = name
        self.longitude = longitude
        self.latitude = latitude
        self.coordinate = coordinate
        self.origin = origin
        self.monsterDescription = monsterDescription
        self.type = type
        self.webLink = webLink
        self.monsterImage = monsterImage
    }
    
    // Failable Initializer- used for fetching from Cloudkit
    
    init?(cloudKitRecord: CKRecord) {
        guard let name = cloudKitRecord[nameKey] as? String,
            let longitudeString = cloudKitRecord[longitudeKey] as? String,
            let latitudeString = cloudKitRecord[latitudeKey] as? String,
            let origin = cloudKitRecord[originKey] as? String,
            let monsterDescription = cloudKitRecord[descriptionKey] as? String,
            let longitude = Double(longitudeString),
            let latitude = Double(latitudeString),
            let type = cloudKitRecord[typeKey] as? String,
            let webLink = cloudKitRecord[webLinkKey] as? String,
            let photoAsset = cloudKitRecord[monsterImageKey] as? CKAsset else { return nil}
            let monsterImage = try? Data(contentsOf: photoAsset.fileURL)

        
        self.name = name
        self.longitude = longitudeString
        self.latitude = latitudeString
        self.origin = origin
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.monsterDescription = monsterDescription
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
        record.setValue(longitude, forKey: longitudeKey)
        record.setValue(latitude, forKey: latitudeKey)
        record.setValue(origin, forKey: originKey)
        record.setValue(monsterDescription, forKey: descriptionKey)
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

