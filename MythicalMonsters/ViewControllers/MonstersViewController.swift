//
//  MonstersViewController.swift
//  MythicalMonsters
//
//  Created by Tyler Clonts on 6/19/18.
//  Copyright © 2018 Tyler Clonts. All rights reserved.
//

import UIKit



class MonstersViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var viewTagValue = 10
    var tagValue = 100
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        scrollView.delegate = self
        
        
        scrollView.contentSize.width = self.scrollView.frame.width * CGFloat(MonstersController.shared.mythicalMonster.count)
        var i = 0
        let view = CustomView(frame: CGRect(x: 10 + (self.scrollView.frame.width * CGFloat(i)), y: 80, width: self.scrollView.frame.width - 20, height: self.scrollView.frame.height - 90))
        
        
//        MonstersController.shared.loadFromPersistentStore {
        
            DispatchQueue.main.async {
                
                for monster in MonstersController.shared.mythicalMonster {
                    
            
           
                view.tag = i + self.viewTagValue
                self.scrollView.addSubview(view)
                
                // View Title label
                let label = UILabel(frame: CGRect.init(origin: CGPoint.init(x: 0, y: 20), size: CGSize.init(width: 0, height: 40)))
                label.text = "Monster"
                label.font = UIFont.boldSystemFont(ofSize: 30)
                label.textColor = UIColor.black
                label.sizeToFit()
                label.tag = i + self.tagValue
                if i == 0 {
                    
                    label.center.x = view.center.x
                } else {
                    label.center.x = view.center.x - self.scrollView.frame.width/2
                }
                self.scrollView.addSubview(label)
                
                i += 1
            }
        }
//    }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == scrollView {
            for i in 0..<MonstersController.shared.mythicalMonster.count {
                let label = scrollView.viewWithTag(i + tagValue) as! UILabel
                let view = scrollView.viewWithTag(i + viewTagValue) as! CustomView
                var scrollContentOffset = scrollView.contentOffset.x + self.scrollView.frame.width
                var viewOffset = (view.center.x - scrollView.bounds.width / 4) - scrollContentOffset
                label.center.x = scrollContentOffset - ((scrollView.bounds.width / 4 - viewOffset) / 2)
                
            }
        }
    }
}








