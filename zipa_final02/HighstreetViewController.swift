//
//  HighstreetViewController.swift
//  zipa_final02
//
//  Created by Lydia Kara on 24/04/2019.
//  Copyright © 2019 Lydia Kara. All rights reserved.
//

import UIKit

class HighstreetViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //connect to global database
    let database = Database()
    
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var storeLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    
    //decides which gender you pick
    var gender = true
    
    //if gender = true
    var womenPickerData: [[String]] = [[String]]()
    
    //if gender = false
    var menPickerData: [[String]] = [[String]]()
    
    //temp variables
    var sizePicked = "test"
    var storePicked = "test"
    
    override func viewDidLoad() {
        database.addDatabaseToFile()
        super.viewDidLoad()

        self.storePicker.delegate = self
        self.storePicker.dataSource = self
        
        womenPickerData = [[" ","2","4","6","8","10","12","14","16","18","20","22","24","26","28","30"],[" ","HM","Topshop","Missguided","Boohoo"]]
        
        menPickerData = [[" ","3XS","XXS","XS","S","M","L","XL","XXL","3XL","4XL","5XL","6XL"],[" ","Uniqlo","Topman","BoohooMAN"]]
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if gender == true {
            if component == 0 {
                return 16
            } else {
                return 5
            }
        } else {
            if component == 0 {
                return 13
            } else {
                return 4
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if gender == true {
            return womenPickerData[component][row]
        } else {
            return menPickerData[component][row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if gender == true {
            if component == 0 {
                //retrieve user selected UK size
                sizePicked = womenPickerData[component][row]
                sizeChangedWOM()
            } else {
                storePicked = womenPickerData[component][row]
                storeLabel.text = storePicked+" :"
                sizeChangedWOM()
            }
        } else {
            if component == 0 {
                //retrieve user selected UK size
                sizePicked = menPickerData[component][row]
                sizeChangedMEN()
            } else {
                storePicked = menPickerData[component][row]
                storeLabel.text = storePicked+" :"
                sizeChangedMEN()
            }
        }
    }
    
    func sizeChangedWOM() {
        print("ZIPA size selected: \(sizePicked)")
        if storePicked == "HM" {
            let hold = database.queryHM(sizeParam: sizePicked)
            print("HM size generated: \(hold)")
            sizeLabel.text = hold
        } else if (storePicked == "Topshop") {
            let hold = database.queryTopshop(sizeParam: sizePicked)
            print("Topshop size generated: \(hold)")
            sizeLabel.text = hold
        } else if (storePicked == "Missguided") {
            let hold = database.queryMissguided(sizeParam: sizePicked)
            print("Missguided size generated: \(hold)")
            sizeLabel.text = hold
        } else if (storePicked == "Boohoo") {
            let hold = database.queryBoohoo(sizeParam: sizePicked)
            print("Boohoo size generated: \(hold)")
            sizeLabel.text = hold
        }
    }
    
    func sizeChangedMEN() {
        print("ZIPA size selected: \(sizePicked)")
        if storePicked == "Uniqlo" {
            let hold = database.queryUniqlo(sizeParam: sizePicked)
            print("Uniqlo size generated: \(hold)")
            sizeLabel.text = hold
        } else if (storePicked == "Topman") {
            let hold = database.queryTopman(sizeParam: sizePicked)
            print("Topman size generated: \(hold)")
            sizeLabel.text = hold
        } else if (storePicked == "BoohooMAN") {
            let hold = database.queryBoohooMAN(sizeParam: sizePicked)
            print("BoohooMAN size generated: \(hold)")
            sizeLabel.text = hold
        }
    }
    
    
    @IBAction func womenSelected(_ sender: Any) {
        gender = true
        print("women selected: \(gender)")
        
        //reset picker to 0
        storePicker.reloadAllComponents()
        storePicker.selectRow(0, inComponent: 0, animated: true)
        storePicker.selectRow(0, inComponent: 1, animated: true)
        
        //reset variables
        sizePicked = " "
        storePicked = " "
        storeLabel.text = " "
        sizeLabel.text = " "
    }
    
    @IBAction func menSelected(_ sender: Any) {
        gender = false
        print("men selected: \(gender)")
        
        //reset picker to 0
        storePicker.reloadAllComponents()
        storePicker.selectRow(0, inComponent: 0, animated: true)
        storePicker.selectRow(0, inComponent: 1, animated: true)
        
        //reset variables
        sizePicked = " "
        storePicked = " "
        storeLabel.text = " "
        sizeLabel.text = " "
    }
    

}
