//
//  MonsterCollectionViewCell.swift
//  MythicalMonsters
//
//  Created by Tyler Clonts on 6/21/18.
//  Copyright © 2018 Tyler Clonts. All rights reserved.
//

import UIKit

class MonsterCollectionViewCell: UICollectionViewCell {
    
    var stackview = UIStackView()
    var monsterImageView = UIImageView()
//    var monsterNameLabel = UILabel()
    var monster: MythicalMonster?
    
    var link: CustomView?
    
    func setupViews() {
        self.backgroundColor = .white
        
        // Monster Image View
        self.addSubview(monsterImageView)
        monsterImageView.translatesAutoresizingMaskIntoConstraints = false
        monsterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        monsterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        monsterImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        monsterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        guard let monsterImage = UIImage(data: (monster?.monsterImage)!) else { return }
        monsterImageView.image = monsterImage
        
    }
}
