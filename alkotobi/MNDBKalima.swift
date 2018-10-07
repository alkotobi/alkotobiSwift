//
//  MNDBKalima.swift
//  alkotobi
//
//  Created by merhab on 2‏/10‏/2018.
//  Copyright © 2018 merhab. All rights reserved.
//

import Foundation
class MNDBKalima : MNKalima{
    var dataBase : MNDatabase
    init(path:String){
        dataBase = MNDatabase(path: path)
    }
    func saveKalima(){
        let kalimaDataBasePath = MNFile.getBooksListPath()
        let kalimaDataBase = MNDatabase(path:kalimaDataBasePath)
        let IDs = kalimaDataBase.getArrayOfIDs(query: "select rowid from kalima where kalima ='\(self.kalima)'")
        if IDs.isEmpty {
            if kalimaDataBase.execute("insert into kalima(kalima) values('\(self.kalima)')"){
            self.kalimaId = kalimaDataBase.lastInsertRowid
            }
            else {
                self.kalimaId = IDs[0]
            }
        }
        
      let sql = "insert into kalimat(kalimaID,tachkil,horoufNorm) values(\(self.kalimaId),\(self.tashkil),\(self.horofNorm))"
        if dataBase.execute(sql) {
        self.ID = dataBase.lastInsertRowid
        }
    }
    // unic kalima table
    
    static func createKalimaTable(){
        let database = MNDatabase(path: MNFile.getBooksListPath())
        _ = database.execute(
        """
        CREATE TABLE IF NOT EXISTS `kalima` ( `kalima` TEXT NOT NULL UNIQUE, `kalimaID` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT );
        CREATE INDEX IF NOT EXISTS kalimaInd ON kalima (kalima) ;
        """
        )
    }
    static func createKitabTable(tableName : String){
        let database = MNDatabase(path: MNFile.getDataBasePath(book: tableName))
        _ = database.execute("""
            CREATE TABLE IF NOT EXISTS `kalimat` ( `kalimaID` INTEGER, `position` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, `tachkil` INTEGER, `horoufNorm` INTEGER );
            CREATE INDEX IF NOT EXISTS kalimaInd ON kalimat (kalimaID);
        """)
    }
}
