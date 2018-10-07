//
//  MNLafda.swift
//  alkotobi
//
//  Created by merhab on 3‏/10‏/2018.
//  Copyright © 2018 merhab. All rights reserved.
//

import Foundation
class MNlafda : MNSijil{
var lafda = ""
    override func makeDic() {
        super.makeDic()
        dic["lafda"] = lafda
    }
    
    override func objMinDic(dic: [String : Any]) {
        super.objMinDic(dic: dic)
        lafda = dic["lafda"] as? String ?? ""
    }
    
    override func inchaJadwal()->Bool  {
        if super.inchaJadwal() {
        if dataBase.execute("CREATE UNIQUE INDEX lafdaIDX ON MNlafda (lafda);") {
            return true
        }else {return false}

    }
        return true
}
}

//***************************8

class MNTashkil : MNSijil{
    var tashkil = ""
    override func makeDic() {
        super.makeDic()
        dic["tashkil"] = tashkil
    }
    
    override func objMinDic(dic: [String : Any]) {
        super.objMinDic(dic: dic)
        tashkil = dic["tashkil"] as? String ?? ""
    }
    
    override func inchaJadwal()->Bool  {
        if super.inchaJadwal() {
            if dataBase.execute("CREATE UNIQUE INDEX tashkilIDX ON MNTashkil (tashkil);") {
                return true
            }else {return false}
            
        }
        return true
    }
}
