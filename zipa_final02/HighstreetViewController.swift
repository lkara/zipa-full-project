//
//  HighstreetViewController.swift
//  zipa_final02
//
//  Created by Lydia Kara on 24/04/2019.
//  Copyright © 2019 Lydia Kara. All rights reserved.
//

import UIKit

class HighstreetViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    

    let global = Global()
    
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
        global.addDatabaseToFile()
        super.viewDidLoad()

        self.storePicker.delegate = self
        self.storePicker.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
    
    
    @IBAction func womenSelected(_ sender: Any) {
    }
    
    @IBAction func menSelected(_ sender: Any) {
    }
    

}
