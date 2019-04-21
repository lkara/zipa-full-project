//
//  ViewController.swift
//  zipa_final02
//
//  Created by Lydia Kara on 21/04/2019.
//  Copyright © 2019 Lydia Kara. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController, UITextFieldDelegate{
    
    var db: Connection!
    let menTop = Table("menTop")
    let chest = Expression<Int>("chest")
    let size = Expression<String>("size")
    var userInput = 0
    var hold = "test"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            //create file to store database on users device
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
            //create file URL to store database
            //file name: Users, stored locally on users device with extension 'sqlite3'
            let fileUrl = documentDirectory.appendingPathComponent("garments").appendingPathExtension("sqlite3")
            
            //make a connection and create a database
            let database = try Connection(fileUrl.path)
            
            //connect this 'database' to Global database
            self.db = database
        } catch {
            print("Error creating File")
        }
    }
    
    //create men-top table

    @IBAction func createMenTopTable(_ sender: Any) {
        print("creating men-top table")
        
        let createTable = self.menTop.create { (table) in
            //add value/properties into table
            table.column(self.chest)
            table.column(self.size)
        }
        
        do{
            //run CreateTable
            try self.db.run(createTable)
            print("Created table successfully")
        } catch {
            print("Error creating table")
        }
    }
    
    //populate men-top table
    @IBAction func populateMenTopTable(_ sender: Any) {
        do{
            try self.db.run(menTop.delete())
        } catch {
            print("Error deleting content of menTop")
        }
        
        do{
            //populate men-tops table
            try self.db.run(menTop.insert(self.chest <- 81, self.size <- "XXXS"))
            try self.db.run(menTop.insert(self.chest <- 86, self.size <- "XXS"))
            try self.db.run(menTop.insert(self.chest <- 91, self.size <- "XS"))
            try self.db.run(menTop.insert(self.chest <- 96, self.size <- "S"))
            try self.db.run(menTop.insert(self.chest <- 102, self.size <- "M"))
            try self.db.run(menTop.insert(self.chest <- 107, self.size <- "L"))
            try self.db.run(menTop.insert(self.chest <- 112, self.size <- "XL"))
            try self.db.run(menTop.insert(self.chest <- 117, self.size <- "XXL"))
            try self.db.run(menTop.insert(self.chest <- 122, self.size <- "3XL"))
            try self.db.run(menTop.insert(self.chest <- 127, self.size <- "4XL"))
            try self.db.run(menTop.insert(self.chest <- 132, self.size <- "5XL"))
            try self.db.run(menTop.insert(self.chest <- 137, self.size <- "6XL"))

            
            print("successfully inserted")
        } catch {
            print("Error creating table")
        }
    }
    
    //print men-top table
    @IBAction func printMenTopTable(_ sender: Any) {
        print("Listing men-tops table")
        
        do{
            //retrieve rows within the database in a sequence (array)
            let text = try self.db.prepare(self.menTop)
            for menTop in text {
                print("Chest (cm): \(menTop[self.chest]), Size: \(menTop[self.size])")
            }
            
        } catch {
            print("Error listing users")
        }
    }
    
    //user input chest measurements
    
    @IBOutlet weak var chestTextField: UITextField!
    
    
    @IBOutlet weak var displaySize: UILabel!
    
    @IBAction func menTopSubmitButton(_ sender: Any) {
        let userChest = chestTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let userInput = Int(userChest!)
        
        if(userChest?.isEmpty)!{
            print("No input in Chest")
            return
        } else {
            print(userInput!)
        }
        
        if(userInput! < 60 || userInput! >= 150){
            displaySize.text = "Please try again"
            return
        }
        
        
        do{
            let query = menTop.select(size).where(chest <= userInput!).order(chest.desc).limit(1)
            
            for menTop in try db.prepare(query){
                hold = menTop[size]
                print("size: \(hold)")
                let fullSentence = "Your UK Size is \(hold)"
                displaySize.text = fullSentence
                }
            
            
            } catch {
                print("could not query men-top")
            }
        
        
        }
        
        
        
    }
    


