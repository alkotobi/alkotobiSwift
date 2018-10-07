//
//  MNJadwal.swift
//  books
//
//  Created by merhab on 27‏/9‏/2018.
//  Copyright © 2018 merhab. All rights reserved.
//

import Foundation
class MNJadwal {
    var mo3arifat:[Int]
    var sijil : MNSijil
    var dataBase : MNDatabase
    var sijilRakam : Int
    var sql : MNSql
    var tawabi3 = [MNTabi3]()
    var ID :Int { return sijilRakam + 1 }
    var kamSijil : Int {
        return mo3arifat.count
    }
    var halAkhirJadwal = false
    var halAwalJadwal = false
    var halKhawi : Bool {
        return mo3arifat.count == 0
    }
    
    // initialisers
    
    private init(dataBase : MNDatabase){
        self.dataBase=dataBase
        sijil = MNSijil(dataBase: dataBase)
        sql = MNSql(ismJadwal: sijil.hatIsmJadwal())
        mo3arifat = dataBase.getArrayOfIDs(query: sql.hatSelectSql())
        sijilRakam = 0
    }
    private init(dataBase : MNDatabase ,a3mida : String = "*" ,whereSql : String = "" , filterSql : String = "" , orderBySql : String = "" , limit : Int = -1 , ofset : Int = -1) {
        self.dataBase = dataBase
        sijil = MNSijil(dataBase: dataBase)
        sql = MNSql(ismJadwal: sijil.hatIsmJadwal(), a3mida: a3mida, whereSql: whereSql, filterSql: filterSql, orderBySql: orderBySql, limit: limit, ofset: ofset)
         mo3arifat =  dataBase.getArrayOfIDs(query: sql.hatSelectSql())
                    sijilRakam = 0
        
    }
    init(sijil : MNSijil ,a3mida : String = "*" ,whereSql : String = "" , filterSql : String = "" , orderBySql : String = "" , limit : Int = -1 , ofset : Int = -1) {
        self.sijil = sijil
        self.dataBase = sijil.dataBase
        sql = MNSql(ismJadwal: sijil.hatIsmJadwal(), a3mida: a3mida, whereSql: whereSql, filterSql: filterSql, orderBySql: orderBySql, limit: limit, ofset: ofset)
         mo3arifat =  dataBase.getArrayOfIDs(query: sql.hatSelectSql())
             sijilRakam = 0
        

    }
    //*************
    
    func tahdith()  {
         mo3arifat =  dataBase.getArrayOfIDs(query: sql.hatSelectSql())
            sijilRakam = 0
     
    }
    
    func hatSijilHali() {
        sijil.sijilMinMo3arif(ID:ID)
        
    }
    func taharakIlaAwalJadwal()  {
        sijilRakam = 0
        halAwalJadwal = false
        halAkhirJadwal = false
    }
    func taharakIlaAkhirJadwal()  {
        sijilRakam = kamSijil-1
        halAwalJadwal = false
        halAkhirJadwal = false
    }
    func taharakIlaLahik(){
        if sijilRakam == kamSijil-1 {
            halAkhirJadwal = true
        } else {
            sijilRakam += 1
            halAwalJadwal = false
        }
    }
    func taharakIlaSabik(){
        if sijilRakam == 0 {
            halAwalJadwal = true
        }else {
            sijilRakam -= 1
            halAkhirJadwal = false
        }
    }
    
    func taharakIlaRakam(rakam : Int){
        if (rakam > -1) && (rakam < kamSijil){
            sijilRakam = rakam
            halAkhirJadwal=false
            halAwalJadwal=false
        }
    }
    
    func idafatTabi3(sijilTabi3 : MNSijil, miftahTabi3 : String , miftahMatbou3 : String){
        tawabi3.append(MNTabi3(sijilTabi3: sijilTabi3, miftahTabi3: miftahTabi3, miftahMatbou3: miftahMatbou3))
    }
    
}
class MNTabi3{
    var sijilTabi3 : MNSijil
    var sijilMatbou3 : MNSijil?
    var miftahTabi3 : String
    var miftahMatbou3 : String
    var ismJadwal : String {
        return sijilTabi3.hatIsmJadwal()
    }
    init(sijilTabi3 : MNSijil , miftahTabi3 : String , miftahMatbou3 : String) {
        self.miftahMatbou3 = miftahMatbou3
        self.miftahTabi3 = miftahTabi3
        self.sijilTabi3 = sijilTabi3
    }
    func hatTabi3Jadwal(sijilMatbou3 : MNSijil) -> MNJadwal {
       self.sijilMatbou3 = sijilMatbou3
        let whereSql = " \(miftahTabi3) = \(sijilMatbou3.dic[miftahMatbou3] as! Int) "
       return MNJadwal(sijil: sijilTabi3 , whereSql:whereSql)

    }
    func hifdSijil(sijil : MNSijil){
    sijil.dic[miftahTabi3] = sijilMatbou3?.dic[miftahMatbou3]
        sijil.objMinDic(dic: sijil.dic)
        try!sijil.hifd()
    }
}
enum AkhtaaSijilat : Error {
    case kharijNitak(String)
}
