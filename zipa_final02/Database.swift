//
//  Database.swift
//  CSV.swift
//
//  Created by Lydia Kara on 29/04/2019.
//

//
//  Database.swift
//  zipa_final02
//
//  Created by Lydia Kara on 21/04/2019.
//  Copyright © 2019 Lydia Kara. All rights reserved.
//

import Foundation
import SQLite
import CSV

class Database {
    //db = database now available globally to be used across all ViewControllers and .swift files
    var db: Connection!
    
    //tables
    let dressTable = Table("dress")
    let braTable = Table("bra")
    
    //table columns
    let neck = Expression<Int>("neck")
    let chest = Expression<Int>("chest")
    let waist = Expression<Int>("waist")
    let hips = Expression<Int>("hips")
    let bust = Expression<Int>("bust")
    let underbust = Expression<Int>("underbust")
    let size = Expression<String>("size")
    let cup = Expression<String>("cup")
    let bra = Expression<String>("bra")
    
    //women variables to hold current input
    var dressTemp01 = "test"
    var dressTemp02 = "test"
    var tempBra = "test"
    var tempCup = "test"

    //create a file path on users device to stored static database for all garments (men & women)
    //called in ViewDidLoad()
    func addDatabaseToFile() {
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
            print("Error creating Database")
        }
    }
    
    func createCSVTable() {
        print("drop tables if they already exist:")
        do{
            try db.run(braTable.drop(ifExists: true))
            print("bra table dropped")
        } catch {
            print("error dropping bra table")
        }
        do{
            try db.run(dressTable.drop(ifExists: true))
            print("dress table dropped")
        } catch {
            print("error dropping dress table")
        }
        //bra table from csv
        let createBraTable = braTable.create { (table) in
            table.column(self.cup)
            table.column(self.bra)
            table.column(self.bust)
            table.column(self.underbust)
            
        }
        
        do{
            try self.db.run(createBraTable)
            print("created bra table successfully")
        } catch {
            print("Error creating bra table")
        }
        
        //dress table from csv
        let createDressTable = dressTable.create { (table) in
            //add value/properties into table
            table.column(self.size)
            table.column(self.bust)
            table.column(self.waist)
            table.column(self.hips)
        }
        
        do{
            try self.db.run(createDressTable)
            print("created women-dress table successfully")
        } catch {
            print("Error creating women-dress table")
        }
    }
    

    //bra
    func readBraFromCSV(){
        let braFilepath = Bundle.main.path(forResource: "women-bra", ofType: "csv")!
        let braStream = InputStream(fileAtPath: braFilepath)!
        let braCSV = try! CSVReader(stream: braStream, hasHeaderRow: true)
        
        
        while braCSV.next() != nil {
            do{
                try self.db.run(braTable.insert(self.cup <- braCSV["cup"]!, self.bra <- braCSV["bra"]!, self.bust <- Int(braCSV["bust"]!)!, self.underbust <- Int(braCSV["underbust"]!)!))
            } catch {
                print("error populating bra table")
            }
        }
        
    }
    //dress
    func readDressFromCSV() {
        let dressFilepath = Bundle.main.path(forResource: "women-dress", ofType: "csv")!
        let dressStream = InputStream(fileAtPath: dressFilepath)!
        let dressCSV = try! CSVReader(stream: dressStream, hasHeaderRow: true)
        
        
        while dressCSV.next() != nil {
            do{
                try self.db.run(dressTable.insert(self.size <- dressCSV["size"]!, self.bust <- Int(dressCSV["bust"]!)!, self.waist <- Int(dressCSV["waist"]!)!, self.hips <- Int(dressCSV["hips"]!)!))
            } catch {
                print("error populating dress table")
            }
        }
    }
    
    func printInConsole() {
        //bra
        do{
            let printBra = try db.prepare(self.braTable)
            for braTable in printBra {
                print("Cup : \(braTable[self.cup]), Bra: \(braTable[self.bra]), Bust (cm): \(braTable[self.bust]), Underbust (cm): \(braTable[self.underbust])")
            }
        } catch {
            print("error printing bra table")
        }
        //dress
        do{
            let printDress = try db.prepare(self.dressTable)
            for dressTable in printDress {
                print("Size : \(dressTable[self.size]), Bust: \(dressTable[self.bust]), Waist: \(dressTable[self.waist]), Hips: \(dressTable[self.hips])")
            }
        } catch {
            print("error printing dress table")
        }
    }
    
    func queryForBra(bustParam: Int, underBustParam: Int) -> String {
        var returnInfo = "size not found"
        do{
            let braQuery = braTable.select(bra).where(underbust <= underBustParam).order(underbust.desc).limit(1)
            let cupQuery = braTable.select(cup).where(bust <= bustParam).order(bust.desc).limit(1)
            
            for braTable in try db.prepare(braQuery){
                tempBra = braTable[bra]
            }
            
            for braTable in try db.prepare(cupQuery){
                tempCup = braTable[cup]
            }
            returnInfo = "Your Bra Size is: \(tempBra) \(tempCup)"
        } catch {
            print("could not return bra")
        }
        
        return returnInfo
    }
    
    //QUERIES
    func queryForTop(bustParam: Int, waistParam: Int) -> String {
        var returnInfo = "size not found"
        do{
            let bustQuery = dressTable.select(size).where(bust <= bustParam).order(bust.desc).limit(1)
            let waistQuery = dressTable.select(size).where(waist <= waistParam).order(waist.desc).limit(1)
            
            for dressTable in try db.prepare(bustQuery){
                dressTemp01 = dressTable[size]
            }
            
            for dressTable in try db.prepare(waistQuery){
                dressTemp02 = dressTable[size]
            }
            
            //figure whether to return a size or a range:
            if(dressTemp01 == dressTemp02){
                returnInfo = "Your Top Size is: \(dressTemp01)"
            } else if (Int(dressTemp01)! > Int(dressTemp02)!){
                returnInfo = "Your Top Size is: \(dressTemp02) - \(dressTemp01)"
            } else {
                returnInfo = "Your Top Size is: \(dressTemp01) - \(dressTemp02)"
            }
        } catch {
            print("could not return top size")
        }
        
        return returnInfo
    }
    
    func queryForDress(waistParam: Int, hipsParam: Int) -> String {
        var returnInfo = "size not found"
        do{
            let waistQuery = dressTable.select(size).where(waist <= waistParam).order(waist.desc).limit(1)
            let hipsQuery = dressTable.select(size).where(hips <= hipsParam).order(hips.desc).limit(1)
            
            for dressTable in try db.prepare(waistQuery){
                dressTemp01 = dressTable[size]
            }
            
            for dressTable in try db.prepare(hipsQuery){
                dressTemp02 = dressTable[size]
            }
            
            //figure whether to return a size or a range:
            if(dressTemp01 == dressTemp02){
                returnInfo = "Your Dress Size is: \(dressTemp01)"
            } else if (Int(dressTemp01)! > Int(dressTemp02)!){
                returnInfo = "Your Dress Size is: \(dressTemp02) - \(dressTemp01)"
            } else {
                returnInfo = "Your Dress Size is: \(dressTemp01) - \(dressTemp02)"
            }
        } catch {
            print("could not return top size")
        }
        
        return returnInfo
    }
    
    func queryForTrouser(waistParam: Int, hipsParam: Int) -> String {
        var returnInfo = "size not found"
        do{
            let waistQuery = dressTable.select(size).where(waist <= waistParam).order(waist.desc).limit(1)
            let hipsQuery = dressTable.select(size).where(hips <= hipsParam).order(hips.desc).limit(1)
            
            for dressTable in try db.prepare(waistQuery){
                dressTemp01 = dressTable[size]
            }
            
            for dressTable in try db.prepare(hipsQuery){
                dressTemp02 = dressTable[size]
            }
            
            //figure whether to return a size or a range:
            if(dressTemp01 == dressTemp02){
                returnInfo = "Your Trouser Size is: \(dressTemp01)"
            } else if (Int(dressTemp01)! > Int(dressTemp02)!){
                returnInfo = "Your Trouser Size is: \(dressTemp02) - \(dressTemp01)"
            } else {
                returnInfo = "Your Trouser Size is: \(dressTemp01) - \(dressTemp02)"
            }
        } catch {
            print("could not return top size")
        }
        
        return returnInfo
    }
    
}


