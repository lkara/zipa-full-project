//
//  Global.swift
//  zipa_final02
//
//  Created by Lydia Kara on 21/04/2019.
//  Copyright © 2019 Lydia Kara. All rights reserved.
//

import Foundation
import SQLite

class Global {
    //db = database now available globally to be used across all ViewControllers and .swift files
    var db: Connection!
    
    //men garment tables
    let shirt = Table("shirt")
    let menTop = Table("menTop")
    let menTrouser = Table("menTrouser")
    
    //men table columns
    let neck = Expression<Int>("neck")
    let chest = Expression<Int>("chest")
    let waist = Expression<Int>("waist")
    let size = Expression<String>("size")
    
    //men variables to hold current input
    var shirtTemp = "test"
    var topTemp = "test"
    var trouserTemp = "test"
    
    //women garment tables
    let dress = Table("dress")
    let braStrap = Table("braStrap")
    let bra = Table("bra")
    
    //women (additional) table columns
    let bust = Expression<Int>("bust")
    let underbust = Expression<Int>("underbust")
    let hips = Expression<Int>("hips")
    
    //women variables to hold current input
    var dressTemp = "test"
    var braTemp = "test"

    //create a file path on users device to stored static database for all garments (men & women)
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
    
    //--------------------------------------------------------------------------------------------------------
    //MEN
    //--------------------------------------------------------------------------------------------------------
   //CREATE
    func createMenTables() {
        //create men garment tables
        print("---------------------------------------------------")
        print("drop tables if they already exist:")
        do{
            try db.run(shirt.drop(ifExists: true))
            print("men-shirt table dropped")
        } catch {
            print("error dropping shirt table")
        }
        do{
            try db.run(menTop.drop(ifExists: true))
            print("men-top table dropped")
        } catch {
            print("error dropping menTop table")
        }
        do{
            try db.run(menTrouser.drop(ifExists: true))
            print("men-trouser table dropped")
        } catch {
            print("error dropping menTrouser table")
        }
        
        print("---------------------------------------------------")
        print("creating men garment tables:")
        //create shirt table
        let createShirtTable = shirt.create { (table) in
            //add value/properties into table
            table.column(self.size)
            table.column(self.neck)
            table.column(self.chest)
        }
        
        //create men-top table
        let createMenTopTable = menTop.create { (table) in
            table.column(self.size)
            table.column(self.chest)
        }
        
        //create men-trouser table
        let createMenTrouserTable = menTrouser.create { (table) in
            table.column(self.size)
            table.column(self.waist)
        }
        
        //run create statements for all men garment tables
        do{
            try self.db.run(createShirtTable)
            print("created men-shirt table successfully")
        } catch {
            print("Error creating shirt table")
        }
        
        do{
            try self.db.run(createMenTopTable)
            print("created men-top table successfully")
        } catch {
            print("Error creating men-top table")
        }
        
        do{
            try self.db.run(createMenTrouserTable)
            print("created men-trousers table successfully")
        } catch {
            print("Error creating men-trouser table")
        }
        
        
    }
    
    //POPULATE
    func populateMenTables() {
        print("---------------------------------------------------")
        print("populating men garment tables:")
        do{
            try db.run(shirt.delete())
            try db.run(menTop.delete())
            try db.run(menTrouser.delete())
        } catch {
            print("Error deleting content of tables")
        }
        
        //populate men-shirts table
        do{
            try self.db.run(shirt.insert(self.chest <- 81, self.neck <- 34, self.size <- "XXXS"))
            try self.db.run(shirt.insert(self.chest <- 86, self.neck <- 36, self.size <- "XXS"))
            try self.db.run(shirt.insert(self.chest <- 91, self.neck <- 38, self.size <- "XS"))
            try self.db.run(shirt.insert(self.chest <- 96, self.neck <- 41, self.size <- "S"))
            try self.db.run(shirt.insert(self.chest <- 101, self.neck <- 44, self.size <- "M"))
            try self.db.run(shirt.insert(self.chest <- 106, self.neck <- 46, self.size <- "L"))
            try self.db.run(shirt.insert(self.chest <- 111, self.neck <- 48, self.size <- "XL"))
            try self.db.run(shirt.insert(self.chest <- 116, self.neck <- 50, self.size <- "XXL"))
            try self.db.run(shirt.insert(self.chest <- 121, self.neck <- 52, self.size <- "XXXL"))
            print("successfully populated men-shirt table")
        } catch {
            print("Error populating shirt table")
        }
        
        //populate men-top table
        do{
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
            print("successfully populated men-top table")
        } catch {
            print("Error populating men-top table")
        }
        
        //populate men-trouser table
        do{
            try self.db.run(menTrouser.insert(self.waist <- 66, self.size <- "W26"))
            try self.db.run(menTrouser.insert(self.waist <- 71, self.size <- "W28"))
            try self.db.run(menTrouser.insert(self.waist <- 74, self.size <- "W29"))
            try self.db.run(menTrouser.insert(self.waist <- 76, self.size <- "W30"))
            try self.db.run(menTrouser.insert(self.waist <- 79, self.size <- "W31"))
            try self.db.run(menTrouser.insert(self.waist <- 81, self.size <- "W32"))
            try self.db.run(menTrouser.insert(self.waist <- 84, self.size <- "W33"))
            try self.db.run(menTrouser.insert(self.waist <- 86, self.size <- "W34"))
            try self.db.run(menTrouser.insert(self.waist <- 91, self.size <- "W36"))
            try self.db.run(menTrouser.insert(self.waist <- 97, self.size <- "W38"))
            try self.db.run(menTrouser.insert(self.waist <- 102, self.size <- "W40"))
            try self.db.run(menTrouser.insert(self.waist <- 107, self.size <- "W42"))
            try self.db.run(menTrouser.insert(self.waist <- 112, self.size <- "W44"))
            try self.db.run(menTrouser.insert(self.waist <- 117, self.size <- "W46"))
            try self.db.run(menTrouser.insert(self.waist <- 122, self.size <- "W48"))
            print("successfully populated men-trouser table")
        } catch {
            print("Error populating men-trouser table")
        }
        
        
    }
    
    //PRINT IN CONSOLE
    func printMenTables() {
        print("---------------------------------------------------")
        do{
            //retrieve rows within the database in a sequence (array)
            //print men-shirt table
            print("printing shirts table")
            let printShirt = try db.prepare(self.shirt)
            for shirt in printShirt {
                print("Chest (cm): \(shirt[self.chest]), Neck (cm): \(shirt[self.neck]), Size: \(shirt[self.size])")
            }
            
            //print men-top table
            print("---------------------------------------------------")
            print("printing men-top table")
            let printTop = try db.prepare(self.menTop)
            for menTop in printTop {
                print("Chest (cm): \(menTop[self.chest]), Size: \(menTop[self.size])")
            }
            
            //print men-trouser table
            print("---------------------------------------------------")
            print("printing men-trouser table")
            let printTrouser = try db.prepare(self.menTrouser)
            for menTrouser in printTrouser {
                print("Waist (cm): \(menTrouser[self.waist]), Size: \(menTrouser[self.size])")
            }
            
        } catch {
            print("Error printing men garment tables")
        }
    }
    
    //QUERIES
    func queryShirtTable(chestParam: Int) -> String {
        var returnInfo = "size not found"
        do{
            let chestQuery = shirt.select(size).where(chest <= chestParam).order(chest.desc).limit(1)
            
            for shirt in try db.prepare(chestQuery){
                shirtTemp = shirt[size]
                print("size: \(shirtTemp)")
                returnInfo = "Your UK shirt Size is \(shirtTemp)"
            }
        } catch {
            print("could not query men-shirt")
        }
        
        return returnInfo
    }
    
    func queryMenTopTable(chestParam: Int) -> String {
        var returnInfo = "size not found"
        do{
            let chestQuery = menTop.select(size).where(chest <= chestParam).order(chest.desc).limit(1)
            
            for menTop in try db.prepare(chestQuery){
                topTemp = menTop[size]
                print("size: \(topTemp)")
                returnInfo = "Your UK top Size is \(topTemp)"
            }
        } catch {
            print("could not query men-top")
        }
        
        return returnInfo
    }
    
    func queryMenTrouserTable(waistParam: Int) -> String {
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
    
    //--------------------------------------------------------------------------------------------------------
    //WOMEN
    //--------------------------------------------------------------------------------------------------------
    func createWomenTables() {
        //create women garment tables
        print("---------------------------------------------------")
        print("drop tables if they already exist:")
        do{
            try db.run(dress.drop(ifExists: true))
            print("women-dress table dropped")
        } catch {
            print("error dropping women-dress table")
        }

        print("---------------------------------------------------")
        print("creating women garment tables:")
        //create women-top table
        let createDressTable = dress.create { (table) in
            //add value/properties into table
            table.column(self.size)
            table.column(self.bust)
            table.column(self.waist)
            table.column(self.hips)
        }
        
        //run create statements for all men garment tables
        do{
            try self.db.run(createDressTable)
            print("created women-dress table successfully")
        } catch {
            print("Error creating women-dress table")
        }
    }
    
    //POPULATE
    func populateWomenTables() {
        print("---------------------------------------------------")
        print("populating women garment tables:")
        do{
            try db.run(dress.delete())
        } catch {
            print("Error deleting content of women tables")
        }
    
        //populate women-dress table - can be used for women-tops, women-trouser, and women-dress
        do{
            try self.db.run(dress.insert(self.bust <- 73, self.waist <- 55, self.hips <- 80, self.size <- "2"))
            try self.db.run(dress.insert(self.bust <- 76, self.waist <- 58, self.hips <- 83, self.size <- "4"))
            try self.db.run(dress.insert(self.bust <- 78, self.waist <- 63, self.hips <- 86, self.size <- "6"))
            try self.db.run(dress.insert(self.bust <- 81, self.waist <- 68, self.hips <- 88, self.size <- "8"))
            try self.db.run(dress.insert(self.bust <- 86, self.waist <- 73, self.hips <- 93, self.size <- "10"))
            try self.db.run(dress.insert(self.bust <- 91, self.waist <- 78, self.hips <- 98, self.size <- "12"))
            try self.db.run(dress.insert(self.bust <- 96, self.waist <- 83, self.hips <- 103, self.size <- "14"))
            try self.db.run(dress.insert(self.bust <- 101, self.waist <- 91, self.hips <- 108, self.size <- "16"))
            try self.db.run(dress.insert(self.bust <- 109, self.waist <- 98, self.hips <- 116, self.size <- "18"))
            try self.db.run(dress.insert(self.bust <- 116, self.waist <- 105, self.hips <- 123, self.size <- "20"))
            try self.db.run(dress.insert(self.bust <- 123, self.waist <- 112, self.hips <- 130, self.size <- "22"))
            try self.db.run(dress.insert(self.bust <- 130, self.waist <- 119, self.hips <- 137, self.size <- "24"))
            try self.db.run(dress.insert(self.bust <- 137, self.waist <- 126, self.hips <- 144, self.size <- "26"))
            try self.db.run(dress.insert(self.bust <- 144, self.waist <- 133, self.hips <- 151, self.size <- "28"))
            try self.db.run(dress.insert(self.bust <- 151, self.waist <- 140, self.hips <- 158, self.size <- "30"))
            print("successfully populated women-dress table")
        } catch {
            print("Error populating women-top table")
        }
    }
    
    //PRINT IN CONSOLE
    func printWomenTables() {
        do{
            //retrieve rows within the database in a sequence (array)
            //print dress table
            print("printing women-top table")
            let printDressTable = try db.prepare(self.dress)
            for dress in printDressTable {
                print("Bust (cm): \(dress[self.bust]), Waist (cm): \(dress[self.waist]), Hips (cm): \(dress[self.hips]) Size: \(dress[self.size])")
            }
        }catch {
            print("Error printing women-top table")
        }
    }
    
    //QUERIES
    func queryWomenTopTable(bustParam: Int) -> String {
        var returnInfo = "size not found"
        do{
            let bustQuery = dress.select(size).where(bust <= bustParam).order(bust.desc).limit(1)
            
            for dress in try db.prepare(bustQuery){
                dressTemp = dress[size]
                print("size: \(dressTemp)")
                returnInfo = "Your UK top Size is \(dressTemp)"
            }
        } catch {
            print("could not query women-top")
        }
        
        return returnInfo
    }
    
    func queryDressTable(hipsParam: Int) -> String {
        var returnInfo = "size not found"
        do{
            let hipsQuery = dress.select(size).where(hips <= hipsParam).order(hips.desc).limit(1)
            
            for dress in try db.prepare(hipsQuery){
                dressTemp = dress[size]
                print("size: \(dressTemp)")
                returnInfo = "Your UK top Size is \(dressTemp)"
            }
        } catch {
            print("could not query women-dress")
        }
        
        return returnInfo
    }
    
    //--------------------------------------------------------------------------------------------------------
    //International
    //--------------------------------------------------------------------------------------------------------
    //WOMEN
    
    let womenIntl = Table("womenIntl")
    let menIntl = Table("menIntl")
    
    let uk = Expression<String>("uk")
    let us = Expression<String>("us")
    let eu = Expression<String>("eu")
    let australia = Expression<String>("australia")
    let russia = Expression<String>("russia")
    let japan = Expression<String>("japan")
    
    //store queried value to return
    var intlTemp = "test"

    func createIntl() {
        print("---------------------------------------------------")
        print("drop tables if they already exist:")
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
        
        print("---------------------------------------------------")
        print("creating international tables:")
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
    
    func populateIntl() {
        print("---------------------------------------------------")
        print("populating international tables:")
        do{
            try db.run(womenIntl.delete())
            try db.run(menIntl.delete())
        } catch {
            print("Error deleting content of international tables")
        }
        
        //populate women-intl table
        do{
            try self.db.run(womenIntl.insert(self.uk <- "2", self.us <- "00", self.eu <- "30", self.russia <- "36/38", self.japan <- "1"))
            try self.db.run(womenIntl.insert(self.uk <- "4", self.us <- "0", self.eu <- "32", self.russia <- "38", self.japan <- "3"))
            try self.db.run(womenIntl.insert(self.uk <- "6", self.us <- "2", self.eu <- "34", self.russia <- "38/40", self.japan <- "5"))
            try self.db.run(womenIntl.insert(self.uk <- "8", self.us <- "4", self.eu <- "36", self.russia <- "40", self.japan <- "7"))
            try self.db.run(womenIntl.insert(self.uk <- "10", self.us <- "6", self.eu <- "38", self.russia <- "42/44", self.japan <- "9"))
            try self.db.run(womenIntl.insert(self.uk <- "12", self.us <- "8", self.eu <- "40", self.russia <- "48", self.japan <- "11"))
            try self.db.run(womenIntl.insert(self.uk <- "14", self.us <- "10", self.eu <- "42", self.russia <- "48", self.japan <- "13"))
            try self.db.run(womenIntl.insert(self.uk <- "16", self.us <- "12", self.eu <- "44", self.russia <- "50", self.japan <- "15"))
            try self.db.run(womenIntl.insert(self.uk <- "18", self.us <- "14", self.eu <- "46", self.russia <- "54", self.japan <- "17"))
            try self.db.run(womenIntl.insert(self.uk <- "20", self.us <- "16", self.eu <- "48", self.russia <- "58", self.japan <- "19"))
            try self.db.run(womenIntl.insert(self.uk <- "22", self.us <- "18", self.eu <- "50", self.russia <- "60/62", self.japan <- "21"))
            try self.db.run(womenIntl.insert(self.uk <- "24", self.us <- "20", self.eu <- "52", self.russia <- "64", self.japan <- "23"))
            try self.db.run(womenIntl.insert(self.uk <- "26", self.us <- "22", self.eu <- "54", self.russia <- "66/68", self.japan <- "25"))
            try self.db.run(womenIntl.insert(self.uk <- "28", self.us <- "24", self.eu <- "56", self.russia <- "70", self.japan <- "27"))
            try self.db.run(womenIntl.insert(self.uk <- "30", self.us <- "28", self.eu <- "58", self.russia <- "72/74", self.japan <- "29"))
            print("successfully populated women-international table")
        } catch {
            print("Error populating women-intl tables")
        }
        
        //populate men-intl table
        do{
            try self.db.run(menIntl.insert(self.uk <- "XXXS", self.us <- "4XS", self.eu <- "42", self.australia <- "34", self.japan <- "n/a"))
            try self.db.run(menIntl.insert(self.uk <- "XXS", self.us <- "XXXS", self.eu <- "44", self.australia <- "36", self.japan <- "XS"))
            try self.db.run(menIntl.insert(self.uk <- "XS", self.us <- "XXS", self.eu <- "46", self.australia <- "38", self.japan <- "S"))
            try self.db.run(menIntl.insert(self.uk <- "S", self.us <- "XS", self.eu <- "48", self.australia <- "40", self.japan <- "M"))
            try self.db.run(menIntl.insert(self.uk <- "M", self.us <- "S", self.eu <- "50", self.australia <- "42", self.japan <- "L"))
            try self.db.run(menIntl.insert(self.uk <- "L", self.us <- "M", self.eu <- "52", self.australia <- "44", self.japan <- "XL"))
            try self.db.run(menIntl.insert(self.uk <- "XL", self.us <- "L", self.eu <- "54", self.australia <- "46", self.japan <- "XXL"))
            try self.db.run(menIntl.insert(self.uk <- "XXL", self.us <- "XL", self.eu <- "56", self.australia <- "48", self.japan <- "3XL"))
            try self.db.run(menIntl.insert(self.uk <- "3XL", self.us <- "XXL", self.eu <- "58", self.australia <- "50", self.japan <- "4XL"))
            try self.db.run(menIntl.insert(self.uk <- "4XL", self.us <- "3XL", self.eu <- "60", self.australia <- "52", self.japan <- "n/a"))
            try self.db.run(menIntl.insert(self.uk <- "5XL", self.us <- "4XL", self.eu <- "62", self.australia <- "54", self.japan <- "n/a"))
            try self.db.run(menIntl.insert(self.uk <- "6XL", self.us <- "5XL", self.eu <- "64", self.australia <- "56", self.japan <- "n/a"))
            print("successfully populated men-international table")
        } catch {
            print("Error populating men-intl tables")
        }
        print("---------------------------------------------------")
            
    }
    
    func printIntlTables(){
        print("---------------------------------------------------")
        //print women-intl table
        do{
            let printWomenIntl = try db.prepare(self.womenIntl)
            for womenIntl in printWomenIntl {
                print("UK: \(womenIntl[self.uk]), US: \(womenIntl[self.us]), EU: \(womenIntl[self.eu]), Russia: \(womenIntl[self.russia]), Japan: \(womenIntl[self.japan])")
            }
        } catch {
            print("Error prining women-intl tables")
            print("---------------------------------------------------")
        }
        
        //print men-intl table
        do{
            let printMenIntl = try db.prepare(self.menIntl)
            for menIntl in printMenIntl {
                print("UK: \(menIntl[self.uk]), US: \(menIntl[self.us]), EU: \(menIntl[self.eu]), Australia: \(menIntl[self.australia]), Japan: \(menIntl[self.japan])")
            }
        } catch {
            print("Error prining men-intl tables")
        }
    }
    
    //--------------------------------------------------------------------------------------------------------
    //International - Queries
    //--------------------------------------------------------------------------------------------------------
    //women
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
    
    //men
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
    

