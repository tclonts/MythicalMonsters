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
    @IBOutlet weak var originPermanentLabel: UILabel!
    @IBOutlet weak var regionPermanentLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentViewTwo: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        nameLabel.textColor = UIColor.mmWhiteIce
        
        originLabel.textColor = UIColor.mmWhiteIce

        regionLabel.textColor = UIColor.mmWhiteIce
        
        descriptionTextView.backgroundColor = UIColor.mmDarkGray
        descriptionTextView.textColor = UIColor.mmWhiteIce
        
        originPermanentLabel.textColor = UIColor.mmWhiteIce
        regionPermanentLabel.textColor = UIColor.mmWhiteIce
        
        contentViewTwo.backgroundColor = UIColor.mmDarkBrown
        contentView.backgroundColor = UIColor.mmDarkGray
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
