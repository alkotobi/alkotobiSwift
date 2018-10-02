//
//  MNDBSafha.swift
//  alkotobi
//
//  Created by merhab on 2‏/10‏/2018.
//  Copyright © 2018 merhab. All rights reserved.
//

import Foundation
class MNDBSafha : MNSafha{
    var dataBase : MNDatabase?
    
    init(kitabId:Int){
        dataBase = MNDatabase(path: MNFile.getDataBasePath(kitabId: kitabId))
        super.init(nass: "")
    }
    

}
