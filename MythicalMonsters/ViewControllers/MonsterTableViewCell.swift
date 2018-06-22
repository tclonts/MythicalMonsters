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
        monsterImageView.contentMode = .scaleAspectFill
        monsterImageView.clipsToBounds = false
        
        monsterOriginsLabel.text = ("(" + "\(monster.origin)" + ")")
        monsterOriginsLabel.backgroundColor = UIColor.mmDarkBrown.withAlphaComponent(0.8)
        monsterOriginsLabel.textColor = UIColor.mmWhiteIce
        monsterOriginsLabel.layer.borderWidth = 1.0
        
        monsterNameLabel.text = monster.name
        monsterNameLabel.backgroundColor = UIColor.mmDarkBrown.withAlphaComponent(0.8)
        monsterNameLabel.textColor = UIColor.mmWhiteIce
        monsterNameLabel.layer.borderWidth = 1.0
//        monsterNameLabel.layer.borderColor = UIColor.mmWhiteIce.cgColor
    }

//    let color = self.myLabel.backgroundColor
//    super.setSelected(selected, animated: animated)
//    self.myLabel.backgroundColor = color
//
    override func setSelected(_ selected: Bool, animated: Bool) {
        let color = self.monsterNameLabel.backgroundColor
        super.setSelected(selected, animated: animated)
        self.monsterNameLabel.backgroundColor = color
        self.monsterOriginsLabel.backgroundColor = color
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        let color = self.monsterNameLabel.backgroundColor
        super.setHighlighted(highlighted, animated: animated)
        self.monsterNameLabel.backgroundColor = color
        self.monsterOriginsLabel.backgroundColor = color
    }
}
