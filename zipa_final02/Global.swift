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
    let womenTop = Table("womenTop")
    let womenTrouser = Table("womenTrouser")
    let braStrap = Table("braStrap")
    let bra = Table("bra")
    
    //women (additional) table columns
    let bust = Expression<Int>("bust")
    let underbust = Expression<Int>("underbust")
    let hips = Expression<Int>("hips")
    
    //women variables to hold current input
    var dressTemp = "test"
    var womenTopTemp = "test"
    var womenTrouserTemp = "test"
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
            print("Error creating File")
        }
    }
    
    //--------------------------------------------------------------------------------------------------------
    //MEN
    //--------------------------------------------------------------------------------------------------------
   //CREATE
    func createMenTables() {
        //create men garment tables
        print("---------------------------------------------------")
        print("drop tables if they already exist")
        do{
            try db.run(shirt.drop(ifExists: true))
            print("shirt table dropped")
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
        
        print("creating men garment tables")
        print("---------------------------------------------------")
        
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
            print("Created shirt table successfully")
        } catch {
            print("Error creating shirt table")
        }
        
        do{
            try self.db.run(createMenTopTable)
            print("Created men-top table successfully")
        } catch {
            print("Error creating men-top table")
        }
        
        do{
            try self.db.run(createMenTrouserTable)
            print("Created men-trousers table successfully")
        } catch {
            print("Error creating men-trouser table")
        }
        
        
    }
    
    //POPULATE
    func populateMenTables() {
        print("---------------------------------------------------")
        print("populating men garment tables")
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
            print("successfully populated shirt table")
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
    //CREATE
    func createWomenTables() {
        //create women garment tables
        print("---------------------------------------------------")
        print("drop tables if they already exist")
        do{
            try db.run(womenTop.drop(ifExists: true))
            print("women-top table dropped")
        } catch {
            print("error dropping women-top table")
        }
        
        print("creating women garment tables")
        print("---------------------------------------------------")
        //create women-top table
        let createWomenTopTable = womenTop.create { (table) in
            //add value/properties into table
            table.column(self.size)
            table.column(self.bust)
            table.column(self.waist)
        }
        
        //run create statements for all men garment tables
        do{
            try self.db.run(createWomenTopTable)
            print("Created women-top table successfully")
        } catch {
            print("Error creating women-top table")
        }
    }
    
    //POPULATE
    func populateWomenTables() {
        print("---------------------------------------------------")
        print("populating men garment tables")
        do{
            try db.run(womenTop.delete())
        } catch {
            print("Error deleting content of women-top")
        }
        
        //populate women-top table
        do{
            try self.db.run(womenTop.insert(self.bust <- 73, self.waist <- 55, self.size <- "2"))
            try self.db.run(womenTop.insert(self.bust <- 76, self.waist <- 58, self.size <- "4"))
            try self.db.run(womenTop.insert(self.bust <- 78, self.waist <- 60, self.size <- "6"))
            try self.db.run(womenTop.insert(self.bust <- 81, self.waist <- 63, self.size <- "8"))
            try self.db.run(womenTop.insert(self.bust <- 86, self.waist <- 68, self.size <- "10"))
            try self.db.run(womenTop.insert(self.bust <- 91, self.waist <- 73, self.size <- "12"))
            try self.db.run(womenTop.insert(self.bust <- 96, self.waist <- 78, self.size <- "14"))
            try self.db.run(womenTop.insert(self.bust <- 101, self.waist <- 83, self.size <- "16"))
            try self.db.run(womenTop.insert(self.bust <- 109, self.waist <- 91, self.size <- "18"))
            try self.db.run(womenTop.insert(self.bust <- 116, self.waist <- 98, self.size <- "20"))
            try self.db.run(womenTop.insert(self.bust <- 123, self.waist <- 105, self.size <- "22"))
            try self.db.run(womenTop.insert(self.bust <- 130, self.waist <- 112, self.size <- "24"))
            try self.db.run(womenTop.insert(self.bust <- 137, self.waist <- 119, self.size <- "26"))
            try self.db.run(womenTop.insert(self.bust <- 144, self.waist <- 129, self.size <- "28"))
            try self.db.run(womenTop.insert(self.bust <- 151, self.waist <- 133, self.size <- "30"))
            print("successfully populated women-top table")
        } catch {
            print("Error populating women-top table")
        }
    }
    
    //PRINT IN CONSOLE
    func printWomenTables() {
        do{
            //retrieve rows within the database in a sequence (array)
            //print women-top table
            print("printing women-top table")
            let printWomenTable = try db.prepare(self.womenTop)
            for womenTop in printWomenTable {
                print("Bust (cm): \(womenTop[self.bust]), Waist (cm): \(womenTop[self.waist]), Size: \(womenTop[self.size])")
            }
        }catch {
            print("Error printing women-top table")
        }
    }
    
    //QUERIES
    func queryWomenTopTable(waistParam: Int) -> String {
        var returnInfo = "size not found"
        do{
            let waistQuery = womenTop.select(size).where(waist <= waistParam).order(waist.desc).limit(1)
            
            for womenTop in try db.prepare(waistQuery){
                womenTopTemp = womenTop[size]
                print("size: \(womenTopTemp)")
                returnInfo = "Your UK top Size is \(womenTopTemp)"
            }
        } catch {
            print("could not query women-top")
        }
        
        return returnInfo
    }
    
    
    
    
    
    
    
    
    
    
    
}
    
