//
//  FemaleUserViewController.swift
//  zipa_final02
//
//  Created by Lydia Kara on 23/04/2019.
//  Copyright © 2019 Lydia Kara. All rights reserved.
//

import UIKit

class FemaleUserViewController: UIViewController {

    //connect to global database
    let database = Database()
    
    //will hold user input temporarily even when moving between views
    struct tempUser {
        static var tempBust = 0
        static var tempUnderbust = 0
        static var tempWaist = 0
        static var tempHips = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        database.addDatabaseToFile()
    }
    
    //user input from text fields
    @IBOutlet weak var bustTextField: UITextField!
    @IBOutlet weak var underbustTextField: UITextField!
    @IBOutlet weak var waistTextField: UITextField!
    @IBOutlet weak var hipsTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    

    @IBOutlet weak var displayLabel: UILabel!
    
    @IBAction func addUserMeasures() {
        //convert string input to integer
        let userBust = bustTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let userUnderbust = underbustTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let userWaist = waistTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let userHips = hipsTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //assigning the inputted values to tempUser variables
        if(!userBust!.isEmpty){
        tempUser.tempBust = Int(userBust!)!
        tempUser.tempUnderbust = Int(userUnderbust!)!
        tempUser.tempWaist = Int(userWaist!)!
        tempUser.tempHips = Int(userHips!)!
        }
        
        //popup error messages to set min/max range
        //bust range
        if(tempUser.tempBust > 155){
            createAlert(title: "Bust input too large", message: "input out of range")
        } else if(tempUser.tempBust < 70){
            createAlert(title: "Bust input too small", message: "input out of range")
        }
        //underbust range
        if(tempUser.tempUnderbust > 120){
            createAlert(title: "Neck input too large", message: "input out of range")
        } else if(tempUser.tempUnderbust < 67){
            createAlert(title: "Neck input too small", message: "input out of range")
        }
        //waist range
        if(tempUser.tempWaist > 140){
            createAlert(title: "Waist input too large", message: "input out of range")
        } else if(tempUser.tempWaist < 55){
            createAlert(title: "Waist input too small", message: "input out of range")
        }
        //hips range
        if(tempUser.tempHips > 160){
            createAlert(title: "Waist input too large", message: "input out of range")
        } else if(tempUser.tempHips < 80){
            createAlert(title: "Waist input too small", message: "input out of range")
        }
        
        print("temp bust is currently: \(tempUser.tempBust)")
        print("temp underbust is currently: \(tempUser.tempUnderbust)")
        print("temp waist is currently: \(tempUser.tempWaist)")
        print("temp hips is currently: \(tempUser.tempHips)")
        
    }
    
    @IBAction func editMade() {
        updateButtonState()
    }
    
    func updateButtonState() {
        let bustText = bustTextField.text ?? ""
        let underbustText = underbustTextField.text ?? ""
        let waistText = waistTextField.text ?? ""
        let hipsText = hipsTextField.text ?? ""
        
        submitButton.isEnabled = !bustText.isEmpty && !underbustText.isEmpty && !waistText.isEmpty && !hipsText.isEmpty
    }
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
  
    @IBAction func topButtonPressed(_ sender: Any) {
        let output = database.queryForTop(bustParam: tempUser.tempBust, waistParam: tempUser.tempWaist)
        print(output)
        displayLabel.text = output
    }
    
    @IBAction func dressButtonPressed(_ sender: Any) {
        let output = database.queryForDress(waistParam: tempUser.tempWaist, hipsParam: tempUser.tempHips)
        print(output)
        displayLabel.text = output
    }
    
    @IBAction func trouserButtonPressed(_ sender: Any) {
        let output = database.queryForTrouser(waistParam: tempUser.tempWaist, hipsParam: tempUser.tempHips)
        print(output)
        displayLabel.text = output
    }
 
    @IBAction func braButtonPressed(_ sender: Any) {
        let output = database.queryForBra(bustParam: tempUser.tempBust, underBustParam: tempUser.tempUnderbust)
        print(output)
        displayLabel.text = output
    }
}
