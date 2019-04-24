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
    
    var ukPickerData: [[String]] = [[String]]()
    
    var sizePicked = "test"
    var countryPicked = "test"
    
    override func viewDidLoad() {
        global.addDatabaseToFile()
        super.viewDidLoad()
        //connect data
        self.ukSizePicker.delegate = self
        self.ukSizePicker.dataSource = self
        
        //input data as array
        ukPickerData = [[" ","2","4","6","8","10","12","14","16","18","20","22","24","26","28","30"],[" ","US","France","Spain","Australia","Russia","Japan"]]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 16
        } else {
            return 7
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ukPickerData[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            //retrieve user selected UK size
            sizePicked = ukPickerData[component][row]
            sizeChanged()
        } else {
            countryPicked = ukPickerData[component][row]
            countrySelected.text = countryPicked+" :"
            sizeChanged()
        }
        
    }
    
    func sizeChanged() {
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
    
    


}
