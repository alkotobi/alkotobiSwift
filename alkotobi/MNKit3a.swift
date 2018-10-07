//
//  MNKit3a.swift
//  alkotobi
//
//  Created by merhab on 3‏/10‏/2018.
//  Copyright © 2018 merhab. All rights reserved.
//

import Foundation

class MNDBKit3a:MNSijil {
    var bidaya = -1
    var nihaya = -1

    override func makeDic() {
        super.makeDic()
        dic["bidaya"] = bidaya
        dic["nihaya"] = nihaya
    }
    
    override func objMinDic(dic: [String : Any]) {
        super.objMinDic(dic: dic)
        bidaya = dic["bidaya"] as? Int ?? -1
        nihaya = dic["nihaya"] as? Int ?? -1
    }
    
    static func createKit3aTable(tableName : String){
        let database = MNDatabase(path: MNFile.getDataBasePath(book: tableName))
        _ = database.execute("""
        CREATE TABLE IF NOT EXISTS kit3a (
        bidaya INTEGER,
        nihaya INTEGER,
        CONSTRAINT kit3a_PK PRIMARY KEY (nihaya,bidaya)
        );
""")
        
    }
    

}
