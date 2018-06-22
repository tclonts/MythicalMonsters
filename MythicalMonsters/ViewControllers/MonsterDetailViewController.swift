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
        
//        let titleImageView = UIImageView(image: #imageLiteral(resourceName: "MysticalMonstersLogo-1"))
//        titleImageView.frame = CGRect(x: -10, y: 0, width: 60, height: 60)
//        titleImageView.contentMode = .scaleAspectFit
//        navigationItem.titleView = titleImageView
        //create a new button
        let button = UIButton.init(type: .custom)
        //set image for button
        button.setImage(UIImage(named: "MonsterIcon2"), for: .normal)
        //add function for button
        button.addTarget(self, action: "fbButtonPressed", for: .touchUpInside)
        //set frame
        button.frame = CGRect(x: -10, y: 0, width: 53, height: 51)
        let barButton = UIBarButtonItem(customView: button)
        
        //assign button to navigationbar
        self.navigationItem.rightBarButtonItem = barButton
        navigationItem.title = "Monster Details"
    }

    var monster: MythicalMonster?

    private func updateViews() {
        guard let monster = monster else { return }
        
        guard let monsterImage = UIImage(data: monster.monsterImage!) else { return }
        monsterImageView.image = monsterImage
//        monsterImageView.contentMode = .scaleToFill
//        monsterImageView.clipsToBounds = true
        nameLabel.text = monster.name
        originLabel.text = monster.origin
        regionLabel.text = monster.region
        descriptionTextView.text = monster.description
    }


}
