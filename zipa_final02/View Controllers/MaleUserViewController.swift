//
//  MaleUserViewController.swift
//  zipa_final02
//
//  Created by Lydia Kara on 21/04/2019.
//  Copyright © 2019 Lydia Kara. All rights reserved.
//

import UIKit
import SQLite

class MaleUserViewController: UIViewController {
    
    //connect to global database
    let global = Global()
    
    //will hold user input temporarily even when moving between views
    struct tempUser {
        static var tempChest = 0
        static var tempNeck = 0
        static var tempWaist = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        global.addDatabaseToFile()
        
    }

    //user input from text fields
    @IBOutlet weak var chestTextField: UITextField!
    @IBOutlet weak var neckTextField: UITextField!
    @IBOutlet weak var waistTextField: UITextField!
    @IBOutlet weak var newUserButton: UIButton!
    
    
    @IBAction func addNewUser(_ sender: Any) {
        //convert string input to integer
        let userChest = chestTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let userNeck = neckTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let userWaist = waistTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //assigning the inputted values to tempUser variables
        if(!userChest!.isEmpty){
        tempUser.tempChest = Int(userChest!)!
        tempUser.tempNeck = Int(userNeck!)!
        tempUser.tempWaist = Int(userWaist!)!
        }
        
        
        //popup error messages to set min/max range
        //chest range
        if(tempUser.tempChest > 150){
            createAlert(title: "Chest input too large", message: "input out of range")
        } else if(tempUser.tempChest < 65){
            createAlert(title: "Chest input too small", message: "input out of range")
        }
        //neck range
        if(tempUser.tempNeck > 55){
            createAlert(title: "Neck input too large", message: "input out of range")
        } else if(tempUser.tempNeck < 30){
            createAlert(title: "Neck input too small", message: "input out of range")
        }
        //waist range
        if(tempUser.tempWaist > 140){
            createAlert(title: "Waist input too large", message: "input out of range")
        } else if(tempUser.tempWaist < 65){
            createAlert(title: "Waist input too small", message: "input out of range")
        }
        
        
        
        print("temp chest is currently: \(tempUser.tempChest)")
        print("temp waist is currently: \(tempUser.tempWaist)")
        print("temp neck is currently: \(tempUser.tempNeck)")
        
    }
    
    @IBAction func editMade() {
        updateButtonState()
    }
    
    func updateButtonState() {
        let neckText = neckTextField.text ?? ""
        let waistText = waistTextField.text ?? ""
        let chestText = chestTextField.text ?? ""
        
        newUserButton.isEnabled = !neckText.isEmpty && !waistText.isEmpty && !chestText.isEmpty
    }
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var displaySize: UILabel!
    @IBAction func shirtButtonPressed(_ sender: Any) {
        print("temp chest: \(tempUser.tempChest)")
        let output = global.queryShirtTable(chestParam: tempUser.tempChest)
        print(output)
        displaySize.text = output
    }
    
    @IBAction func topButtonPressed(_ sender: Any) {
        print("temp chest: \(tempUser.tempChest)")
        let output = global.queryMenTopTable(chestParam: tempUser.tempChest)
        print(output)
        displaySize.text = output
    }
    
    
    @IBAction func trouserButtonPressed(_ sender: Any) {
        print("temp waist: \(tempUser.tempWaist)")
        let output = global.queryMenTrouserTable(waistParam: tempUser.tempWaist)
        print(output)
        displaySize.text = output
    }
    
    
    
}
