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
    @IBOutlet weak var webLinkButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        setupLogo()
        
        self.view.backgroundColor = UIColor.mmDarkBrown
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }

    var monster: MythicalMonster?
    
    func setupLogo() {
        //create a new button
        let button = UIButton.init(type: .custom)
        //set image for button
        button.setImage(UIImage(named: "MML"), for: .normal)
        //set frame
        button.frame = CGRect(x: -10, y: 0, width: 53, height: 51)
        let barButton = UIBarButtonItem(customView: button)
        
        
        //assign button to navigationbar
        self.navigationItem.rightBarButtonItem = barButton
        navigationItem.title = "Monster Details"
    }
    @IBAction func webLinkButtonTapped(_ sender: UIButton) {
        guard let monster = monster else { return }
        UIApplication.shared.canOpenURL(NSURL(string: monster.webLink)! as URL)
        UIApplication.shared.open(NSURL(string: monster.webLink)! as URL, options: [:], completionHandler: { (success) in
            print("Open url : \(success)")
        })
    }
    
    func updateViews() {
        guard let monster = monster else { return }
        
//        guard let monsterImage = UIImage(data: monster.monsterImage!) else { return }
        monsterImageView.image = monster.photo
//        monsterImageView.image = monsterImage
        nameLabel.text = monster.name
        originLabel.text = monster.origin
        regionLabel.text = monster.type
        descriptionTextView.text = monster.monsterDescription
    }


}
