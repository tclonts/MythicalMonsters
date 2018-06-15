//
//  AddMonsterViewController.swift
//  MythicalMonsters
//
//  Created by Tyler Clonts on 6/6/18.
//  Copyright © 2018 Tyler Clonts. All rights reserved.
//

import UIKit

class AddMonsterViewController: UIViewController {

    
    @IBOutlet weak var monsterImageView: UIImageView!
    @IBOutlet weak var monsterNameTextField: UITextField!
    @IBOutlet weak var originTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var regionTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        descriptionTextView.isScrollEnabled = true
        descriptionTextView.layer.cornerRadius = 5
        descriptionTextView.layer.borderColor = UIColor.black.cgColor
        descriptionTextView.layer.borderWidth = 1.0
        descriptionTextView.textColor = UIColor.mmWhiteIce
        
//        descriptionTextView.text = "Monster desription..."
//        monsterNameTextField.text = "Name..."
        
        monsterNameTextField.delegate = self
        originTextField.delegate = self
        regionTextField.delegate = self
        descriptionTextView.delegate = self
        
        textViewDidBeginEditing(descriptionTextView)
        textViewDidEndEditing(descriptionTextView)
        
        textFieldDidBeginEditing(monsterNameTextField)
        textFieldDidEndEditing(monsterNameTextField)
        
        textFieldDidBeginEditing(originTextField)
        textFieldDidEndEditing(originTextField)
        
        textFieldDidBeginEditing(regionTextField)
        textFieldDidEndEditing(regionTextField)
        
        scrollViewDidScroll(scrollView)
        scrollView.isDirectionalLockEnabled = true
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
    
    
    let imagePicker = UIImagePickerController()
    var monster: MythicalMonster?

    @IBAction func monsterImagePIckerTapped(_ sender: UITapGestureRecognizer) {
        addMonsterImage()
    }
    
    @IBAction func saveMonsterButtonTapped(_ sender: UIBarButtonItem) {
        if (monsterNameTextField.text?.isEmpty)! || (originTextField.text?.isEmpty)! || (descriptionTextView.text?.isEmpty)! || (regionTextField.text?.isEmpty)! {
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
        guard let description = descriptionTextView.text else { return }
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

extension AddMonsterViewController: UITextViewDelegate, UITextFieldDelegate {

    func textViewDidChange(_ textView: UITextView) {
        print(textView.text)
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)

        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }

    func textViewDidBeginEditing(_ textView: UITextView) {

        if descriptionTextView.textColor == UIColor.mmWhiteIce {
            descriptionTextView.text = nil
            descriptionTextView.textColor = UIColor.black
        }

        if (textView.text == "Monster description...")   {
            textView.text = ""
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {

        if descriptionTextView.text.isEmpty {
            descriptionTextView.text = "Monster description..."
            descriptionTextView.textColor = UIColor.mmWhiteIce
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.textColor == UIColor.mmWhiteIce {
            textField.text = nil
            textField.textColor = UIColor.black
            if (textField.text == "Name...")   {
                textField.text = ""
            }
        }
    }
    

    func textFieldDidEndEditing(_ textField: UITextField) {
        if (monsterNameTextField.text?.isEmpty)! {
            monsterNameTextField.text = "Name..."
            monsterNameTextField.textColor = UIColor.mmWhiteIce
        }
        
        if (originTextField.text?.isEmpty)! {
            originTextField.text = "Origin..."
            originTextField.textColor = UIColor.mmWhiteIce
        }
        
        if (regionTextField.text?.isEmpty)! {
            regionTextField.text = "Region..."
            regionTextField.textColor = UIColor.mmWhiteIce
        }
    }
    
}

