//
//  AddMonsterViewController.swift
//  MythicalMonsters
//
//  Created by Tyler Clonts on 6/6/18.
//  Copyright © 2018 Tyler Clonts. All rights reserved.
//

import UIKit

class AddMonsterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var monsterImageView: UIImageView!
    @IBOutlet weak var monsterNameTextField: UITextField!
    @IBOutlet weak var originTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var regionTextField: UITextField!
    
    
    let imagePicker = UIImagePickerController()
    var monster: MythicalMonster?

    @IBAction func monsterImagePIckerTapped(_ sender: UITapGestureRecognizer) {
        addMonsterImage()
    }
    
    @IBAction func saveMonsterButtonTapped(_ sender: UIBarButtonItem) {
        if (monsterNameTextField.text?.isEmpty)! || (originTextField.text?.isEmpty)! || (descriptionTextField.text?.isEmpty)! || (regionTextField.text?.isEmpty)! {
            //display alert message
            DispatchQueue.main.async {
                self.presentSimpleAlert(title: "oops", message: "all textfields required")
            }
            return
        }
        
        guard let image = monsterImageView.image else { return }
        guard let imageData = UIImageJPEGRepresentation(image, 0.01) else { return }
        guard let monsterName = monsterNameTextField.text else { return }
        guard let origin = originTextField.text else { return }
        guard let description = descriptionTextField.text else { return }
        guard let region = regionTextField.text else { return }
        
        
     MonstersController.shared.createMonster(monsterImage: image, name: monsterName, origin: origin, description: description, Region: region)
    }
    // Simple Alert
    func presentSimpleAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismisss", style: .cancel, handler: nil)
        alert.addAction(dismissAction)
        self.present(alert, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
