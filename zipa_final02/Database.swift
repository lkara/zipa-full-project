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
    //garments:
    let dressTable = Table("dress")
    let braTable = Table("bra")
    let shirtTable = Table("shirt")
    let menTrouser = Table("menTrouser")
    //highstreet:
    let womenHS = Table("womenHS")
    let menHS = Table("menHS")
    //international:
    let womenIntl = Table("womenIntl")
    let menIntl = Table("menIntl")
    
    //table columns
    //garments:
    let neck = Expression<Int>("neck")
    let chest = Expression<Int>("chest")
    let waist = Expression<Int>("waist")
    let hips = Expression<Int>("hips")
    let bust = Expression<Int>("bust")
    let underbust = Expression<Int>("underbust")
    let size = Expression<String>("size")
    let cup = Expression<String>("cup")
    let bra = Expression<String>("bra")
    let innerleg = Expression<Int>("innerleg")
    let length = Expression<String>("length")
    //highstreet:
    let hm = Expression<String>("hm")
    let topshop = Expression<String>("topshop")
    let missguided = Expression<String>("missguided")
    let boohoo = Expression<String>("boohoo")
    let uniqlo = Expression<String>("uniqlo")
    let topman = Expression <String>("topman")
    //international:
    let uk = Expression<String>("uk")
    let us = Expression<String>("us")
    let eu = Expression<String>("eu")
    let australia = Expression<String>("australia")
    let russia = Expression<String>("russia")
    let japan = Expression<String>("japan")
    
    //temporary variables:
    //women variables to hold current input:
    var dressTemp01 = "14"
    var dressTemp02 = "14"
    var tempBra = "test"
    var tempCup = "test"
    //men variables to hold current input:
    var shirtTemp = "test"
    var topTemp = "test"
    var trouserTemp = "test"
    //highstreet variables to hold current input:
    var womenHSTemp = "test"
    var menHSTemp = "test"
    //international variable to hold current input:
    var intlTemp = "test"

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
    
    //find my size ----------------------------------------------------------------------------
    func createCSVTable() {
        //drop tables if they already exist:
        //bra:
        do{
            try db.run(braTable.drop(ifExists: true))
            print("bra table dropped")
        } catch {
            print("error dropping bra table")
        }
        //dress:
        do{
            try db.run(dressTable.drop(ifExists: true))
            print("dress table dropped")
        } catch {
            print("error dropping dress table")
        }
        //shirt:
        do{
            try db.run(shirtTable.drop(ifExists: true))
            print("shirt table dropped")
        } catch {
            print("error dropping shirt table")
        }
        //men-trouser:
        do{
            try db.run(menTrouser.drop(ifExists: true))
            print("men-trouser table dropped")
        } catch {
            print("error dropping men-trouser table")
        }
        //create tables:
        //bra:
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
        
        //dress:
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
        
        //shirt:
        let createShirtTable = shirtTable.create { (table) in
            //add value/properties into table
            table.column(self.size)
            table.column(self.neck)
            table.column(self.chest)
        }
        
        do{
            try self.db.run(createShirtTable)
            print("created shirt table successfully")
        } catch {
            print("Error creating shirt table")
        }
        
        //men-trouser:
        let createTrouserTable = menTrouser.create { (table) in
            //add value/properties into table
            table.column(self.size)
            table.column(self.length)
            table.column(self.waist)
            table.column(self.innerleg)
        }
        
        do{
            try self.db.run(createTrouserTable)
            print("created men-trouser table successfully")
        } catch {
            print("Error creating men-trouser table")
        }
        
    }
    
    //populating from csv ----------------------------------------------------------------------
    //bra:
    func readBraFromCSV(){
        let braFilepath = Bundle.main.path(forResource: "women-bra", ofType: "csv")!
        
        let braStream = InputStream(fileAtPath: braFilepath)!
        let braCSV = try! CSVReader(stream: braStream, hasHeaderRow: true)
        
        
        while braCSV.next() != nil {
            do{
                try self.db.run(braTable.insert(self.cup <- braCSV["cup"]!, self.bra <- braCSV["bra"]!, self.bust <- Int(braCSV["bust"]!)!, self.underbust <- Int(braCSV["underbust"]!)!))
                //print("bra table successfully populated")
            } catch {
                print("error populating bra table")
            }
        }
        
    }
    
    //dress:
    func readDressFromCSV() {
        let dressFilepath = Bundle.main.path(forResource: "women-dress", ofType: "csv")!
        let dressStream = InputStream(fileAtPath: dressFilepath)!
        let dressCSV = try! CSVReader(stream: dressStream, hasHeaderRow: true)
        
        
        while dressCSV.next() != nil {
            do{
                try self.db.run(dressTable.insert(self.size <- dressCSV["size"]!, self.bust <- Int(dressCSV["bust"]!)!, self.waist <- Int(dressCSV["waist"]!)!, self.hips <- Int(dressCSV["hips"]!)!))
                //print("dress table successfully populated")
            } catch {
                print("error populating dress table")
            }
        }
    }
    
    //shirt:
    func readShirtFromCSV() {
        let shirtFilepath = Bundle.main.path(forResource: "men-shirt2", ofType: "csv")!
        let shirtStream = InputStream(fileAtPath: shirtFilepath)!
        let shirtCSV = try! CSVReader(stream: shirtStream, hasHeaderRow: true)
        
        
        while shirtCSV.next() != nil {
            do{
                try self.db.run(shirtTable.insert(self.size <- shirtCSV["size"]!, self.chest <- Int(shirtCSV["chest"]!)!, self.neck <- Int(shirtCSV["neck"]!)!))
                //print("shirt table successfully populated")
            } catch {
                print("error populating shirt table")
            }
        }
    }
    
    //trouser:
    func readTrouserFromCSV() {
        let trouserFilepath = Bundle.main.path(forResource: "men-trouser", ofType: "csv")!
        let trouserStream = InputStream(fileAtPath: trouserFilepath)!
        let trouserCSV = try! CSVReader(stream: trouserStream, hasHeaderRow: true)
        
        
        while trouserCSV.next() != nil {
            do{
                try self.db.run(menTrouser.insert(self.size <- trouserCSV["size"]!, self.length <- trouserCSV["length"]!, self.waist <- Int(trouserCSV["waist"]!)!, self.innerleg <- Int(trouserCSV["inside leg"]!)!))
                //print("trouser table successfully populated")
            } catch {
                print("error populating men-trouser table")
            }
        }
    }
    
    func printInConsole() {
        //bra:
        do{
            print("bra:")
            let printBra = try db.prepare(self.braTable)
            for braTable in printBra {
                print("Cup : \(braTable[self.cup]), Bra: \(braTable[self.bra]), Bust (cm): \(braTable[self.bust]), Underbust (cm): \(braTable[self.underbust])")
            }
        } catch {
            print("error printing bra table")
        }
        
        //dress:
        do{
            print("dress:")
            let printDress = try db.prepare(self.dressTable)
            for dressTable in printDress {
                print("Size : \(dressTable[self.size]), Bust: \(dressTable[self.bust]), Waist: \(dressTable[self.waist]), Hips: \(dressTable[self.hips])")
            }
        } catch {
            print("error printing dress table")
        }
        
        //shirt:
        do{
            print("shirt:")
            let printShirt = try db.prepare(self.shirtTable)
            for shirtTable in printShirt {
                print("Size : \(shirtTable[self.size]), Chest: \(shirtTable[self.chest]), Neck: \(shirtTable[self.neck])")
            }
        } catch {
            print("error printing shirt table")
        }
        
        //men-trouser:
        do{
            print("trouser:")
            let printTrouser = try db.prepare(self.menTrouser)
            for menTrouser in printTrouser {
                print("Size : \(menTrouser[self.size]), Length: \(menTrouser[self.length]), Waist: \(menTrouser[self.waist]), Inner Leg: \(menTrouser[self.innerleg])")
            }
        } catch {
            print("error printing men-trouser table")
        }
        
    }
    
    //garment - queries
    //bra:
    func queryForBra(bustParam: Int, underBustParam: Int) -> String {
        var returnInfo = "size not found"
        do{
            let braQuery = braTable.select(bra).where(underbust <= underBustParam).order(underbust.desc).limit(1)
            for braTable in try db.prepare(braQuery){
                tempBra = braTable[bra]
            }
            
            let cupQuery = braTable.select(cup).where(bra == tempBra && bust <= bustParam).order(bust.desc).limit(1)
            for braTable in try db.prepare(cupQuery){
                tempCup = braTable[cup]
            }
            returnInfo = "Your Bra Size is: \(tempBra) \(tempCup)"
        } catch {
            print("could not return bra")
        }
        
        return returnInfo
    }
    
    //women-top:
    func queryForTop(waistParam: Int, bustParam: Int) -> String {
        var returnInfo = "size not found"
        do{
            print("waistParam: \(waistParam)")
            print("bustParam: \(bustParam)")
            let waistQuery = dressTable.select(size).where(waist <= waistParam).order(waist.desc).limit(1)
            let bustQuery = dressTable.select(size).where(bust <= bustParam).order(bust.desc).limit(1)
            
            for dressTable in try db.prepare(bustQuery){
                dressTemp01 = dressTable[size]
                print("dressTemp01: \(dressTemp01)")
            }
            
            for dressTable in try db.prepare(waistQuery){
                dressTemp02 = dressTable[size]
                print("dressTemp02: \(dressTemp02)")
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
    
    //dress:
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
    
    //women-trouser:
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
    
    //shirt:
    func queryForShirt(chestParam: Int) -> String {
        var returnInfo = "size not found"
        do{
            let chestQuery = shirtTable.select(size).where(chest <= chestParam).order(chest.desc).limit(1)
            
            for shirtTable in try db.prepare(chestQuery){
                shirtTemp = shirtTable[size]
                print("size: \(shirtTemp)")
                returnInfo = "Your UK shirt Size is \(shirtTemp)"
            }
        } catch {
            print("could not query men-shirt")
        }
        
        return returnInfo
    }
    
    //men-top:
    func queryForMenTop(chestParam: Int) -> String {
        var returnInfo = "size not found"
        do{
            let chestQuery = shirtTable.select(size).where(chest <= chestParam).order(chest.desc).limit(1)
            
            for shirtTable in try db.prepare(chestQuery){
                topTemp = shirtTable[size]
                print("size: \(topTemp)")
                returnInfo = "Your UK top Size is \(topTemp)"
            }
        } catch {
            print("could not query men-top")
        }
        
        return returnInfo
    }
    
    //men-trouser:
    func queryForMenTrouser(waistParam: Int) -> String {
        var returnInfo = "size not found"
        do{
            let waistQuery = menTrouser.select(size).where(waist <= waistParam).order(waist.desc).limit(1)
            
            for menTrouser in try db.prepare(waistQuery){
                trouserTemp = menTrouser[size]
                print("size: \(trouserTemp)")
                returnInfo = "Your UK trouser Size is \(trouserTemp)"
            }
        } catch {
            print("could not query men-trouser")
        }
        
        return returnInfo
    }
    
    //highstreet ----------------------------------------------------------------------------
    func createHighstreetTables() {
        //drop tables if they already exist:
        //women-highstreet:
        do{
            try db.run(womenHS.drop(ifExists: true))
            print("women-highstreet table dropped")
        } catch {
            print("error dropping women-highstreet table")
        }
        
        //men-highstreet:
        do{
            try db.run(menHS.drop(ifExists: true))
            print("men-highstreet table dropped")
        } catch {
            print("error dropping women-highstreet table")
        }
        
        //create tables:
        //women-highstreet:
        let createWomenHS = womenHS.create { (table) in
            table.column(self.size)
            table.column(self.hm)
            table.column(self.topshop)
            table.column(self.missguided)
            table.column(self.boohoo)
        }
        
        do{
            try self.db.run(createWomenHS)
            print("created women-highstreet table successfully")
        } catch {
            print("Error creating women-highstreet table")
        }
        
        //men-highstreet:
        let createMenHS = menHS.create { (table) in
            table.column(self.size)
            table.column(self.uniqlo)
            table.column(self.topman)
            table.column(self.boohoo)
        }
        
        do{
            try self.db.run(createMenHS)
            print("created men-highstreet table successfully")
        } catch {
            print("Error creating men-highstreet table")
        }
    }
    
    //populate from csv
    //women-highstreet:
    func womenHSFromCSV(){
        let whsFilepath = Bundle.main.path(forResource: "women-highstreet", ofType: "csv")!
        let whsStream = InputStream(fileAtPath: whsFilepath)!
        let whsCSV = try! CSVReader(stream: whsStream, hasHeaderRow: true)
        
        while whsCSV.next() != nil {
            do{
                try self.db.run(womenHS.insert(self.size <- whsCSV["size"]!, self.hm <- whsCSV["hm"]!, self.topshop <- whsCSV["topshop"]!, self.missguided <- whsCSV["missguided"]!, self.boohoo <- whsCSV["boohoo"]!))
            } catch {
                print("error populating women-highstreet table")
            }
        }
        
    }
    
    //men-highstreet:
    func menHSFromCSV() {
        let mhsFilepath = Bundle.main.path(forResource: "men-highstreet", ofType: "csv")!
        let mhsStream = InputStream(fileAtPath: mhsFilepath)!
        let mhsCSV = try! CSVReader(stream: mhsStream, hasHeaderRow: true)
        
        while mhsCSV.next() != nil {
            do{
                try self.db.run(menHS.insert(self.size <- mhsCSV["size"]!, self.uniqlo <- mhsCSV["uniqlo"]!, self.topman <- mhsCSV["topman"]!, self.boohoo <- mhsCSV["boohoo"]!))
            } catch {
                print("error populating men-highstreet table")
            }
        }
    }
    
    func printHS() {
        //women-highstreet:
        do{
            print("women-highstreet:")
            let printWomenHS = try db.prepare(self.womenHS)
            for womenHS in printWomenHS {
                print("size : \(womenHS[self.size]), hm: \(womenHS[self.hm]), topshop: \(womenHS[self.topshop]), missguided: \(womenHS[self.missguided]), boohoo: \(womenHS[self.boohoo])")
            }
        } catch {
            print("error printing women-highstreet table")
        }
        
        //men-highstreet:
        do{
            print("men-highstreet:")
            let printMenHS = try db.prepare(self.menHS)
            for menHS in printMenHS {
                print("size : \(menHS[self.size]), uniqlo: \(menHS[self.uniqlo]), topman: \(menHS[self.topman]), boohooMAN: \(menHS[self.boohoo])")
            }
        } catch {
            print("error printing men-highstreet table")
        }
    }
    
    //highstreet - queries
    //hm:
    func queryHM(sizeParam: String) -> String {
        var returnInfo = "size not found"
        do{
            let storeQuery = womenHS.select(hm).where(size == sizeParam)
            for womenHS in try db.prepare(storeQuery){
                womenHSTemp = womenHS[hm]
                returnInfo = "In H&M, we recommend a size \(womenHSTemp)"
            }
        } catch {
            print("could not query women-highstreet table")
        }
        return returnInfo
    }
    
    //topshop:
    func queryTopshop(sizeParam: String) -> String {
        var returnInfo = "size not found"
        do{
            let storeQuery = womenHS.select(topshop).where(size == sizeParam)
            for womenHS in try db.prepare(storeQuery){
                womenHSTemp = womenHS[topshop]
                returnInfo = "In Topshop, we recommend a size \(womenHSTemp)"
            }
        } catch {
            print("could not query women-highstreet table")
        }
        return returnInfo
    }
    
    //missguided:
    func queryMissguided(sizeParam: String) -> String {
        var returnInfo = "size not found"
        do{
            let storeQuery = womenHS.select(missguided).where(size == sizeParam)
            for womenHS in try db.prepare(storeQuery){
                womenHSTemp = womenHS[missguided]
                returnInfo = "In Missguided, we recommend a size \(womenHSTemp)"
            }
        } catch {
            print("could not query women-highstreet table")
        }
        return returnInfo
    }
    
    //boohoo:
    func queryBoohoo(sizeParam: String) -> String {
        var returnInfo = "size not found"
        do{
            let storeQuery = womenHS.select(boohoo).where(size == sizeParam)
            for womenHS in try db.prepare(storeQuery){
                womenHSTemp = womenHS[boohoo]
                returnInfo = "In Boohoo, we recommend a size \(womenHSTemp)"
            }
        } catch {
            print("could not query women-highstreet table")
        }
        return returnInfo
    }
    
    //men:
    //uniqlo:
    func queryUniqlo(sizeParam: String) -> String {
        var returnInfo = "size not found"
        do{
            let storeQuery = menHS.select(uniqlo).where(size == sizeParam)
            for menHS in try db.prepare(storeQuery){
                menHSTemp = menHS[uniqlo]
                returnInfo = "In Uniqlo, we recommend a size \(menHSTemp)"
            }
        } catch {
            print("could not query men-highstreet table")
        }
        return returnInfo
    }
    
    //topman:
    func queryTopman(sizeParam: String) -> String {
        var returnInfo = "size not found"
        do{
            let storeQuery = menHS.select(topman).where(size == sizeParam)
            for menHS in try db.prepare(storeQuery){
                menHSTemp = menHS[topman]
                returnInfo = "In Topman, we recommend a size \(menHSTemp)"
            }
        } catch {
            print("could not query men-highstreet table")
        }
        return returnInfo
    }
    
    //boohooMAN:
    func queryBoohooMAN(sizeParam: String) -> String {
        var returnInfo = "size not found"
        do{
            let storeQuery = menHS.select(boohoo).where(size == sizeParam)
            for menHS in try db.prepare(storeQuery){
                menHSTemp = menHS[boohoo]
                returnInfo = "In BooHooMAN, we recommend a size \(menHSTemp)"
            }
        } catch {
            print("could not query men-highstreet table")
        }
        return returnInfo
    }
    
    //international ----------------------------------------------------------------------------
    func createIntlTables(){
        do{
            try db.run(womenIntl.drop(ifExists: true))
            print("women-international table dropped")
            try db.run(menIntl.drop(ifExists: true))
            print("men-international table dropped")
        } catch {
            print("error dropping international table")
        }
        
        //women international table
        let createWomenIntlTable = womenIntl.create { (table) in
            table.column(self.uk)
            table.column(self.us)
            table.column(self.eu)
            table.column(self.russia)
            table.column(self.japan)
        }
        
        //men international table
        let createMenIntlTable = menIntl.create { (table) in
            table.column(self.uk)
            table.column(self.us)
            table.column(self.eu)
            table.column(self.australia)
            table.column(self.japan)
        }
        
        do{
            try self.db.run(createWomenIntlTable)
            print("created women international table successfully")
        } catch {
            print("Error creating international table")
        }
        do{
            try self.db.run(createMenIntlTable)
            print("created men international table successfully")
        } catch {
            print("Error creating international table")
        }
    }
    
    func womenIntlFromCSV() {
        let wiFilepath = Bundle.main.path(forResource: "women-international", ofType: "csv")!
        let wiStream = InputStream(fileAtPath: wiFilepath)!
        let wiCSV = try! CSVReader(stream: wiStream, hasHeaderRow: true)
        
        while wiCSV.next() != nil {
            do{
                try self.db.run(womenIntl.insert(self.uk <- wiCSV["uk"]!, self.us <- wiCSV["us"]!, self.eu <- wiCSV["eu"]!, self.russia <- wiCSV["russia"]!, self.japan <- wiCSV["japan"]!))
            } catch {
                print("error populating women-international table")
            }
        }
    }
    
    func menIntlFromCSV() {
        let miFilepath = Bundle.main.path(forResource: "men-international", ofType: "csv")!
        let miStream = InputStream(fileAtPath: miFilepath)!
        let miCSV = try! CSVReader(stream: miStream, hasHeaderRow: true)
        
        while miCSV.next() != nil {
            do{
                try self.db.run(menIntl.insert(self.uk <- miCSV["uk"]!, self.us <- miCSV["us"]!, self.eu <- miCSV["eu"]!, self.australia <- miCSV["australia"]!, self.japan <- miCSV["japan"]!))
            } catch {
                print("error populating men-international table")
            }
        }
    }
    
    func printIntl() {
        //women-international:
        do{
            print("women-international:")
            let printWomenIntl = try db.prepare(self.womenIntl)
            for womenIntl in printWomenIntl {
                print("UK: \(womenIntl[self.uk]), US: \(womenIntl[self.us]), EU: \(womenIntl[self.eu]), Russia: \(womenIntl[self.russia]), Japan: \(womenIntl[self.japan])")
            }
        } catch {
            print("error printing women-international table")
        }
        
        //men-international:
        do{
            print("men-international:")
            let printMenIntl = try db.prepare(self.menIntl)
            for menIntl in printMenIntl {
                print("UK: \(menIntl[self.uk]), US: \(menIntl[self.us]), EU: \(menIntl[self.eu]), Australia: \(menIntl[self.australia]), Japan: \(menIntl[self.japan])")
            }
        } catch {
            print("error printing men-international table")
        }
    }
    
    //international - queries
    //women-international:
    func queryWomenIntlTableUS(ukParam: String) -> String {
        var returnInfo = "size not found"
        do{
            let usQuery = womenIntl.select(us).where(uk == ukParam)
            for womenIntl in try db.prepare(usQuery){
                intlTemp = womenIntl[us]
                returnInfo = "You are a US size \(intlTemp)"
            }
        } catch {
            print("could not query women-intl table")
        }
        return returnInfo
    }
    
    func queryWomenIntlTableEU(ukParam: String) -> String {
        var returnInfo = "size not found"
        do{
            let euQuery = womenIntl.select(eu).where(uk == ukParam)
            for womenIntl in try db.prepare(euQuery){
                intlTemp = womenIntl[eu]
                returnInfo = "You are an EU size \(intlTemp)"
            }
        } catch {
            print("could not query women-intl table")
        }
        return returnInfo
    }
    
    func queryWomenIntlTableRUS(ukParam: String) -> String {
        var returnInfo = "size not found"
        do{
            let rusQuery = womenIntl.select(russia).where(uk == ukParam)
            for womenIntl in try db.prepare(rusQuery){
                intlTemp = womenIntl[russia]
                returnInfo = "You are a Russian size \(intlTemp)"
            }
        } catch {
            print("could not query women-intl table")
        }
        return returnInfo
    }
    
    func queryWomenIntlTableJAP(ukParam: String) -> String {
        var returnInfo = "size not found"
        do{
            let japQuery = womenIntl.select(japan).where(uk == ukParam)
            for womenIntl in try db.prepare(japQuery){
                intlTemp = womenIntl[japan]
                returnInfo = "You are a Japan size \(intlTemp)"
            }
        } catch {
            print("could not query women-intl table")
        }
        return returnInfo
    }
    
    //men-international
    func queryMenIntlTableUS(ukParam: String) -> String {
        var returnInfo = "size not found"
        do{
            let usQuery = menIntl.select(us).where(uk == ukParam)
            for menIntl in try db.prepare(usQuery){
                intlTemp = menIntl[us]
                returnInfo = "You are a US size \(intlTemp)"
            }
        } catch {
            print("could not query men-intl table")
        }
        return returnInfo
    }
    
    func queryMenIntlTableEU(ukParam: String) -> String {
        var returnInfo = "size not found"
        do{
            let euQuery = menIntl.select(eu).where(uk == ukParam)
            for menIntl in try db.prepare(euQuery){
                intlTemp = menIntl[eu]
                returnInfo = "You are a EU size \(intlTemp)"
            }
        } catch {
            print("could not query men-intl table")
        }
        return returnInfo
    }
    
    func queryMenIntlTableAUS(ukParam: String) -> String {
        var returnInfo = "size not found"
        do{
            let ausQuery = menIntl.select(australia).where(uk == ukParam)
            for menIntl in try db.prepare(ausQuery){
                intlTemp = menIntl[australia]
                returnInfo = "You are a Australia size \(intlTemp)"
            }
        } catch {
            print("could not query men-intl table")
        }
        return returnInfo
    }
    
    func queryMenIntlTableJAP(ukParam: String) -> String {
        var returnInfo = "size not found"
        do{
            let japQuery = menIntl.select(japan).where(uk == ukParam)
            for menIntl in try db.prepare(japQuery){
                intlTemp = menIntl[japan]
                returnInfo = "You are a Japan size \(intlTemp)"
            }
        } catch {
            print("could not query men-intl table")
        }
        return returnInfo
    }
    
    
}


