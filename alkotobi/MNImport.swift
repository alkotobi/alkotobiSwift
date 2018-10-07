//
//  MNImport.swift
//  alkotobi
//
//  Created by merhab on 6‏/10‏/2018.
//  Copyright © 2018 merhab. All rights reserved.
//

import Foundation
class MNImport{
    static func makeBookFrom(path : String){
        if path != "" {
            let databaseSource = MNDatabase(path: path)
            let kitabID = MNFile.getIdFromPath(path: path)
            let pathDistination = MNFile.getDataBasePath(kitabId: kitabID)
            
            let databaseDestination = MNDatabase(path: pathDistination)
            _ = databaseDestination.execute("PRAGMA journal_mode=WAL;")
            if !MNDatabase.tableExists(path: databaseDestination.path, table: "MNKitab"){
                _ = databaseDestination.execute("""
CREATE TABLE IF NOT EXISTS "MNKitab" ("ID" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT  , "nass" TEXT ,"safhaNo" INTEGER , "volume" Integer ) ;
CREATE VIRTUAL TABLE MNKitabIndex USING fts5(nass);
CREATE TABLE IF NOT EXISTS "MNIndex" ("ID" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,"title" text,"idSafha" INteger);

""")}
            
            let kitab = Book(dataBase: databaseSource)
            let jadwalKitab = MNJadwal(sijil: kitab)
            if !jadwalKitab.halKhawi{
                _ = databaseDestination.execute("""
                    attach database '\(databaseSource.path)' as source;
                    insert into MNIndex(title,idsafha) select tit , id from source.title;
                    DETACH DATABASE 'source';
                    """)
                while !jadwalKitab.halAkhirJadwal{
                    jadwalKitab.hatSijilHali()
                    let start = Date()
                    // let safha = MNSafha(dataBase: databaseDestination,nass: kitab.nass)
                    print("page:\(jadwalKitab.sijilRakam) from:\(jadwalKitab.kamSijil)")
                    var text = kitab.nass
                    let cln = MNSafha.cleanText(text: text)
                    text = MNKalima.removeTachkil(text: cln)
                    text = MNKalima.getNormalizedKalima(text: text)
                    
                    _ = databaseDestination.execute("""
                        insert into MNKitab(nass,safhaNo,volume) values('\(cln)',\(kitab.page),\(kitab.part));
                        insert into MNKitabIndex(nass) values('\(text)');
                        """)
                    // safha.hifdKalimat()
                    let end = Date()
                    let interval = end.timeIntervalSince(start)
                    print(" a page finish in \(interval)  seconds")
                    jadwalKitab.taharakIlaLahik()
                }
                
                
            }
            
            
    }
    }
}
