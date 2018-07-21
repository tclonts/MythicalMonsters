//
//  AddMonsterViewController.swift
//  MythicalMonsters
//
//  Created by Tyler Clonts on 6/6/18.
//  Copyright © 2018 Tyler Clonts. All rights reserved.
//

import UIKit
import CloudKit

class AddMonsterViewController: UIViewController {

    
    @IBOutlet weak var monsterImageView: UIImageView!
    @IBOutlet weak var monsterNameTextField: UITextField!
    @IBOutlet weak var originTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var regionTextField: UITextField!
    @IBOutlet weak var webLinkTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var addMonsterLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        descriptionTextView.isScrollEnabled = true
        descriptionTextView.layer.cornerRadius = 5
        descriptionTextView.layer.borderColor = UIColor.mmKhaki.cgColor
        descriptionTextView.layer.borderWidth = 2.0
        scrollView.backgroundColor = UIColor.mmDarkGray
        
        monsterNameTextField.delegate = self
        originTextField.delegate = self
        regionTextField.delegate = self
        webLinkTextField.delegate = self
        longitudeTextField.delegate = self
        latitudeTextField.delegate = self
        descriptionTextView.delegate = self
        
        monsterNameTextField.autocapitalizationType = .words
        originTextField.autocapitalizationType = .words
        regionTextField.autocapitalizationType = .words
        
        textViewDidBeginEditing(descriptionTextView)
        textViewDidEndEditing(descriptionTextView)
        
        textFieldDidBeginEditing(monsterNameTextField)
        textFieldDidEndEditing(monsterNameTextField)
        
        textFieldDidBeginEditing(originTextField)
        textFieldDidEndEditing(originTextField)
        
        textFieldDidBeginEditing(regionTextField)
        textFieldDidEndEditing(regionTextField)
        
        textFieldDidBeginEditing(webLinkTextField)
        textFieldDidEndEditing(webLinkTextField)
        
        textFieldDidBeginEditing(longitudeTextField)
        textFieldDidEndEditing(longitudeTextField)
        
        textFieldDidBeginEditing(latitudeTextField)
        textFieldDidEndEditing(latitudeTextField)
        
        scrollViewDidScroll(scrollView)
        scrollView.isDirectionalLockEnabled = true
        
        
    }
    
    // MARK: - Properties
    let imagePicker = UIImagePickerController()
    var monster: MythicalMonster?

    
    // MARK: -Actions
    @IBAction func monsterImagePIckerTapped(_ sender: UITapGestureRecognizer) {
        addMonsterImage()
    }
    
    @IBAction func saveMonsterButtonTapped(_ sender: UIBarButtonItem) {
        if (monsterNameTextField.text?.isEmpty)! || (originTextField.text?.isEmpty)! || (latitudeTextField.text?.isEmpty)! || (longitudeTextField.text?.isEmpty)! || (descriptionTextView.text?.isEmpty)! || (regionTextField.text?.isEmpty)! || (webLinkTextField.text?.isEmpty)! || monsterNameTextField.text  == "Name..." || longitudeTextField.text == "Longitude..." || latitudeTextField.text == "Latitude..." || originTextField.text == "Origin..." || regionTextField.text == "Type..." || webLinkTextField.text == "WebLink..." || descriptionTextView.text == "Monster description..." {
            //display alert message
            DispatchQueue.main.async {
                self.presentSimpleAlert(title: "oops", message: "all textfields required")
            }
            return
        }
        
        guard let image = monsterImageView.image else { return }
        guard let imageData = UIImageJPEGRepresentation(image, 0.01) else { return }
        guard let monsterName = monsterNameTextField.text else { return }
        guard let longitude = longitudeTextField.text else { return }
        guard let latitude = latitudeTextField.text else { return }
        guard let origin = originTextField.text else { return }
        guard let description = descriptionTextView.text else { return }
        guard let type = regionTextField.text else { return }
        guard let webLink = webLinkTextField.text else { return }
        guard let lat = Double(latitude),
            let lon = Double(longitude) else { return }
        let locationCoordinates = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        
        
        MonstersController.shared.createMonster(monsterImage: image, name: monsterName, longitude: longitude, latitude: latitude, coordinate: locationCoordinates, origin: origin, description: description, type: type, webLink: webLink) { (true)  in
        
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Success", message: "Monster Added!", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
                self.performSegue(withIdentifier: "backToTV", sender: self)
            }
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            print("Success Saving")
            }
        }
    }
    
    // Simple Alert
    func presentSimpleAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismisss", style: .cancel, handler: nil)
        alert.addAction(dismissAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    // ScrollView function
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
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
            descriptionTextView.textColor = UIColor.mmDarkBrown
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
            textField.textColor = UIColor.mmDarkBrown
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
            regionTextField.text = "Type..."
            regionTextField.textColor = UIColor.mmWhiteIce
        }
        if (webLinkTextField.text?.isEmpty)! {
            webLinkTextField.text = "WebLink..."
            webLinkTextField.textColor = UIColor.mmWhiteIce
        }
        if (longitudeTextField.text?.isEmpty)! {
            longitudeTextField.text = "Longitude..."
            longitudeTextField.textColor = UIColor.mmWhiteIce
        }
        if (latitudeTextField.text?.isEmpty)! {
            latitudeTextField.text = "Latitude..."
            latitudeTextField.textColor = UIColor.mmWhiteIce
        }
    }
    // Texfields can only be numbers for the number sections
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        
//        let characterSet = CharacterSet.letters
//        
//        if string.rangeOfCharacter(from: characterSet.inverted) != nil {
//            return false
//        }
//        return true
//    }
}

