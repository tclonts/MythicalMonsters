//
//  MonsterDetailViewController.swift
//  MythicalMonsters
//
//  Created by Tyler Clonts on 6/14/18.
//  Copyright © 2018 Tyler Clonts. All rights reserved.
//

import UIKit

class MonsterDetailViewController: UIViewController {
    @IBOutlet weak var monsterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    var monster: MythicalMonster?

    private func updateViews() {
        guard let monster = monster else { return }
        
        guard let monsterImage = UIImage(data: monster.monsterImage!) else { return }
        monsterImageView.image = monsterImage
        nameLabel.text = monster.name
        originLabel.text = monster.origin
        regionLabel.text = monster.region
        descriptionTextView.text = monster.description
    }


}
