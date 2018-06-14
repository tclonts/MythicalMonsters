//
//  MonsterTableViewCell.swift
//  MythicalMonsters
//
//  Created by Tyler Clonts on 6/12/18.
//  Copyright © 2018 Tyler Clonts. All rights reserved.
//

import UIKit

class MonsterTableViewCell: UITableViewCell {

    @IBOutlet weak var monsterImageView: UIImageView!
    @IBOutlet weak var monsterNameLabel: UILabel!
    @IBOutlet weak var monsterOriginsLabel: UILabel!
    
    var link: MythicalMonsterListTableViewController?
    
    var monster: MythicalMonster? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        
        guard let monster = monster else { return }
        monsterImageView.image = monster.photo
        monsterNameLabel.text = monster.name
        monsterOriginsLabel.text = monster.origin
    }

}
