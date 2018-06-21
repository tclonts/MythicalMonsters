//
//  CustomView.swift
//  MythicalMonsters
//
//  Created by Tyler Clonts on 6/20/18.
//  Copyright © 2018 Tyler Clonts. All rights reserved.
//

import UIKit

class CustomView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let monsterCellIdentifier = "monsterCell"
    
 
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MonsterCollectionViewCell.self, forCellWithReuseIdentifier: monsterCellIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.red
        collectionView.contentMode = .scaleAspectFit
      
        return collectionView
    }()
    
    override init(frame: CGRect) {
            super.init(frame: frame)
        
        self.addSubview(collectionView)

        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MonstersController.shared.mythicalMonster.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: monsterCellIdentifier, for: indexPath) as? MonsterCollectionViewCell else { return UICollectionViewCell()}
        
        let monsters = MonstersController.shared.mythicalMonster[indexPath.row]
        cell.monster = monsters
        cell.setupViews()
        cell.link = self
     
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.size.width, height: 200)
    }
    
}
