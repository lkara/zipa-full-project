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
    let global = Global()
    
    //will hold user input temporarily even when moving between views
    struct tempUser {
        static var tempBust = 0
        static var tempUnderbust = 0
        static var tempWaist = 0
        static var tempHips = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        global.addDatabaseToFile()
        // Do any additional setup after loading the view.
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
        
        tempUser.tempBust = Int(userBust!)!
        tempUser.tempUnderbust = Int(userUnderbust!)!
        tempUser.tempWaist = Int(userWaist!)!
        tempUser.tempHips = Int(userHips!)!
        
        print("temp bust is currently: \(tempUser.tempBust)")
        print("temp underbust is currently: \(tempUser.tempUnderbust)")
        print("temp waist is currently: \(tempUser.tempWaist)")
        print("temp hips is currently: \(tempUser.tempHips)")
        
    }
    
    @IBAction func topButtonPressed(_ sender: Any) {
        let output = global.queryWomenTopTable(bustParam: tempUser.tempBust)
        print(output)
        displayLabel.text = output
    }
    
    @IBAction func dressButtonPressed(_ sender: Any) {
        let output = global.queryDressTable(hipsParam: tempUser.tempHips)
        print(output)
        displayLabel.text = output
    }
    
    @IBAction func trouserButtonPressed(_ sender: Any) {
        let output = global.queryDressTable(hipsParam: tempUser.tempHips)
        print(output)
        displayLabel.text = output
    }
    
    @IBAction func braButtonPressed(_ sender: Any) {
        print("bra button still to be finished")
       // let output = global.queryWomenBraTable(waistParam: tempUser.tempWaist)
       // print(output)
       // displayLabel.text = output
    }
}
