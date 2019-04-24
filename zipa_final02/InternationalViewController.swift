//
//  InternationalViewController.swift
//  zipa_final02
//
//  Created by Lydia Kara on 24/04/2019.
//  Copyright © 2019 Lydia Kara. All rights reserved.
//

import UIKit

class InternationalViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
   
    let global = Global()
    
    @IBOutlet weak var countrySelected: UILabel!
    @IBOutlet weak var sizeReturned: UILabel!
    @IBOutlet weak var ukSizePicker: UIPickerView!
    
    //decides which gender you pick
    var gender = true
    
    
    //if gender = true
    var womenPickerData: [[String]] = [[String]]()
    
    //if gender = false
    var menPickerData: [[String]] = [[String]]()
    
    //temp variables
    var sizePicked = "test"
    var countryPicked = "test"
    
    override func viewDidLoad() {
        global.addDatabaseToFile()
        super.viewDidLoad()
        
        //connect data
        self.ukSizePicker.delegate = self
        self.ukSizePicker.dataSource = self
        
        //input data as array
        womenPickerData = [[" ","2","4","6","8","10","12","14","16","18","20","22","24","26","28","30"],[" ","US","France","Spain","Australia","Russia","Japan"]]
        
        menPickerData = [[" ","XXXS","XXS","XS","S","M","L","XL","XXL","3XL","4XL","5XL","6XL"],[" ","US","France","Spain","Australia","Japan"]]
        
        print("gender: \(gender)")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if gender == true {
            if component == 0 {
                return 16
            } else {
                return 7
                }
        } else {
            if component == 0 {
                return 13
            } else {
                return 6
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
                countryPicked = womenPickerData[component][row]
                countrySelected.text = countryPicked+" :"
                sizeChangedWOM()
            }
        } else {
            if component == 0 {
                //retrieve user selected UK size
                sizePicked = menPickerData[component][row]
                sizeChangedMEN()
            } else {
                countryPicked = menPickerData[component][row]
                countrySelected.text = countryPicked+" :"
                sizeChangedMEN()
            }
        }
        
        
    }
    
    func sizeChangedWOM() {
        print("UK size selected: \(sizePicked)")
        if countryPicked == "US" {
            let hold = global.queryWomenIntlTableUS(ukParam: sizePicked)
            print("US size generated: \(hold)")
            sizeReturned.text = hold
        } else if (countryPicked == "France" || countryPicked == "Spain") {
            let hold = global.queryWomenIntlTableEU(ukParam: sizePicked)
            print("EU size generated: \(hold)")
            sizeReturned.text = hold
        } else if countryPicked == "Australia" {
            sizeReturned.text = "You are an Austalia size "+sizePicked
        } else if countryPicked == "Russia" {
            let hold = global.queryWomenIntlTableRUS(ukParam: sizePicked)
            print("Russia size generated: \(hold)")
            sizeReturned.text = hold
        } else {
            //japan
            let hold = global.queryWomenIntlTableJAP(ukParam: sizePicked)
            print("Japan size generated: \(hold)")
            sizeReturned.text = hold
        }
    }
    
    func sizeChangedMEN() {
        print("UK size selected: \(sizePicked)")
        if countryPicked == "US" {
            let hold = global.queryMenIntlTableUS(ukParam: sizePicked)
            print("US size generated: \(hold)")
            sizeReturned.text = hold
        } else if (countryPicked == "France" || countryPicked == "Spain") {
            let hold = global.queryMenIntlTableEU(ukParam: sizePicked)
            print("EU size generated: \(hold)")
            sizeReturned.text = hold
        } else if countryPicked == "Australia" {
            let hold = global.queryMenIntlTableAUS(ukParam: sizePicked)
            print("Australia size generated: \(hold)")
            sizeReturned.text = hold
        } else {
            //japan
            let hold = global.queryMenIntlTableJAP(ukParam: sizePicked)
            print("Japan size generated: \(hold)")
            sizeReturned.text = hold
        }
    }
    
    @IBAction func womenSelected(_ sender: Any) {
        gender = true
        print("women selected: \(gender)")
        
        //reset picker to 0
        ukSizePicker.reloadAllComponents()
        ukSizePicker.selectRow(0, inComponent: 0, animated: true)
        ukSizePicker.selectRow(0, inComponent: 1, animated: true)
        
        //reset variables
        sizePicked = " "
        countryPicked = " "
        countrySelected.text = " "
        sizeReturned.text = " "
    }
    
    
    @IBAction func menSelected(_ sender: Any) {
        gender = false
        print("men selected: \(gender)")
        
        //reset picker to 0
        ukSizePicker.reloadAllComponents()
        ukSizePicker.selectRow(0, inComponent: 0, animated: true)
        ukSizePicker.selectRow(0, inComponent: 1, animated: true)
        
        //reset variables
        sizePicked = " "
        countryPicked = " "
        countrySelected.text = " "
        sizeReturned.text = " "
    }
}

