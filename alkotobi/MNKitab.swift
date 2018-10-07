//
//  MNKitab.swift
//  alkotobi
//
//  Created by merhab on 6‏/10‏/2018.
//  Copyright © 2018 merhab. All rights reserved.
//

import Foundation
class MNKitab:MNSijil{
   // MNKitab(nass,safhaNo,volume)
    var nass = ""
    var safhaNo = -1
    var volume = -1
    override func makeDic() {
        super.makeDic()
        dic["nass"] = nass
        dic["safhaNo"] = safhaNo
        dic["volume"] = volume
    }
    override func objMinDic(dic: [String : Any]) {
        super.objMinDic(dic: dic)
        nass = dic["nass"] as? String ?? ""
        safhaNo = dic["safhaNo"] as? Int ?? -1
        volume = dic["volume"] as? Int ?? -1
    }
    
    func getSafhaKalimat()->MNSafha {
        let kalimat = MNSafha.getKalimatFromNass(nass: nass)
        let safha = MNSafha(dataBase: MNDatabase(path: ""),kalimat: kalimat)
        return safha     
    }
    
}
