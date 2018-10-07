//
//  ShamelaBook.swift
//  alkotobi
//
//  Created by merhab on 3‏/10‏/2018.
//  Copyright © 2018 merhab. All rights reserved.
//

import Foundation
class  Book: MNSijil {
   var  id = -1
   var nass = ""
   var part = -1
   var page = -1
   var Hno = -1
    
    override func makeDic() {
        super.makeDic()
        dic["id"] = id
        dic["nass"] = nass
        dic["part"] = part
        dic["page"] = page
        dic["Hno"] = Hno
    }
    override func objMinDic(dic: [String : Any]) {
        super.objMinDic(dic: dic)
          id = dic["id"] as? Int ?? -1
         nass = dic["nass"] as? String ?? ""
         part =  dic["part"] as? Int ?? -1
         page = dic["page"] as? Int ?? -1
         Hno = dic["Hno"] as? Int ?? -1
    }
}
class Title : MNSijil {
    var id = -1
    var tit = ""
    var lvl = -1
    var sub = -1
    override func makeDic() {
        super.makeDic()
        dic["id"] = id
        dic["tit"] = tit
        dic["lvl"] = lvl
        dic["sub"] = sub
    }
    override func objMinDic(dic: [String : Any]) {
        super.objMinDic(dic: dic)
        id = dic["id"] as? Int ?? -1
        tit = dic["tit"] as? String ?? ""
        lvl = dic["lvl"] as? Int ?? -1
        sub = dic["sub"] as? Int ?? -1
    }
}
