//
//  Global.swift
//  zipa_final02
//
//  Created by Lydia Kara on 21/04/2019.
//  Copyright © 2019 Lydia Kara. All rights reserved.
//

import Foundation
import SQLite
import CSV

class Global {
    //db = database now available globally to be used across all ViewControllers and .swift files
    var db: Connection!
    
    
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
    

