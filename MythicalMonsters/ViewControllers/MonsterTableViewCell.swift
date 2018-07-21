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
    @IBOutlet weak var view: UIView!
    
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
        monsterOriginsLabel.backgroundColor = UIColor.clear
        monsterOriginsLabel.textColor = UIColor.mmWhiteIce

        
        monsterNameLabel.text = monster.name
        monsterNameLabel.backgroundColor = UIColor.clear
        monsterNameLabel.textColor = UIColor.mmWhiteIce

        
        view.backgroundColor = UIColor.mmDarkBrown.withAlphaComponent(0.8)
        
    }

//    let color = self.myLabel.backgroundColor
//    super.setSelected(selected, animated: animated)
//    self.myLabel.backgroundColor = color
//
    override func setSelected(_ selected: Bool, animated: Bool) {
        let color = self.view.backgroundColor
        super.setSelected(selected, animated: animated)
//        self.monsterNameLabel.backgroundColor = color
//        self.monsterOriginsLabel.backgroundColor = color
        self.view.backgroundColor = color
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        let color = self.view.backgroundColor
        super.setHighlighted(highlighted, animated: animated)
//        self.monsterNameLabel.backgroundColor = color
//        self.monsterOriginsLabel.backgroundColor = color
        self.view.backgroundColor = color
    }
}
