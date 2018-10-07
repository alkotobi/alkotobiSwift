//
//  MNRecord.swift
//  books
//
//  Created by merhab on 9‏/9‏/2018.
//  Copyright © 2018 merhab. All rights reserved.
//



import Foundation

protocol MNObject {
    func makeDic()
    func objMinDic(dic:[String:Any])
}

class MNSijil  {
static let IDfieldName = "ID"
    var dic : [String:Any]
    var ID = -1
    var dataBase : MNDatabase
    init(path : String = "") {
        dic = [String:Any]()
        dataBase = MNDatabase(path: path)
        if path == "" {
            makeDic()
          _ = inchaJadwal()
        }else {makeDic()}


    }
    init(dataBase : MNDatabase) {
        dic = [String:Any]()
        self.dataBase = dataBase
        makeDic()



    }
    
    func getColumns() -> String {
        var columns = ""
        for key in dic.keys {
            if columns == "" {
                columns = key
            }else{
                columns = columns + ",\(key)"
            }
        }
        return columns
    }
    
    func sijilMinMo3arif(ID:Int){
        let db =  self.dataBase
        let sql = "select * from \(hatIsmJadwal()) where ID = \(ID)"
        
            let  records =  db.getRecords(query: sql)
            if !records.isEmpty{
                objMinDic(dic: records[0])
            }else{
                objMinDic(dic: [String : Any]())
            }
            

    }
    func hifd()  {
        let db =  self.dataBase
        
            if !MNDatabase.tableExists(path: db.path, table: hatIsmJadwal()){
             _ = db.execute(createTableSql())
        }
             _ = db.execute(insertSql())
            ID = db.lastInsertRowid

    }
    func ta3dil()  {
        let db =  self.dataBase
        _ = db.execute(updateSql())

    }
    func hifdAwTa3dil(){


        if ID == -1 {
             hifd()
        }else{
             ta3dil()
        }

    }
    func inchaJadwal()->Bool {
        let db =  self.dataBase
        if db.execute(createTableSql()) {
            return true
        }else {return false}

    }
    
    func halMa3doum()->Bool{
        if ID == -1 {return true}else{return false}
    }
    func hatDic()->[String:Any]{
        makeDic()
        return dic
    }
    func makeDic(){
        dic["ID"]=ID

    }
    func objMinDic(dic:[String:Any])   {
       self.ID = dic["ID"] as? Int ?? -1
       self.dic = dic
    }

    
      func hatIsmJadwal() -> String {
        return String(describing: type(of: self))
    }
    
    func insertSql() -> String {
        var sql = ""
        var fields = ""
        var values = ""
        let dic = hatDic()
        for key in dic.keys {
            if key != "ID"{
            if fields == "" {
                fields = key
            }else {
                fields = fields + ",\(key)"
            }
            if values == "" {
                if dic[key] is String{
                    if dic[key] as! String == "" {
                        values = "null"
                    }else{
                        values = "'\(dic[key] as! String)'"}
                }else if dic[key] is Int{
                    if ((dic[key] as! Int) == -1) {values = "null"}else {
                        values = "\(dic[key] as! Int)"}
                }else if dic[key] is Double{
                    values = "\(dic[key] as! Double)"
                }
                
            }else{
                if dic[key] is String{
                    if dic[key] as! String == "" {
                        values = values + ",null"
                    }else{
                        values = values + ",'\(dic[key] as! String)'"}
                }else if dic[key] is Int{
                    if ((dic[key] as! Int) == -1) {values = values + ",null"}else {
                        values = values + ",\(dic[key] as! Int)"}
                }else if dic[key] is Double{
                    values = values + ",\(dic[key] as! Double)"
                }
                
            }
        }
        }
        sql = "INSERT INTO \(hatIsmJadwal())(\(fields)) VALUES(\(values))"
        return sql
    }
    
    func updateSql() -> String {
        var sql = ""
        var values = ""
        var str = ""
        for key in dic.keys {

            
                if dic[key] is String{
                    values = "'\(dic[key] as! String)'"
                }else if dic[key] is Int{
                    values = "\(dic[key] as! Int)"
                }else if dic[key] is Double{
                    values = "\(dic[key] as! Double)"
                }
                

            if str == "" {
             str = "\(key)=\(values)"
            }else{
             str = str + ",\(key)=\(values)"
            }
        }
        sql = "UPDATE \(hatIsmJadwal()) SET \(str) "
        return sql
    }
    
    func createTableSql() -> String {
  
        let tableName = hatIsmJadwal()
        var str = ""
        var str2 = ""
        var props = dic
        
        
        for key in props.keys {
            switch props[key] {
            case is String :
                if str == "" {
                    str = "\"\(key)\" TEXT  "
                } else {
                    str = str + " , \"\(key)\" TEXT DEFAULT  "
                }
                if str2 == "" {
                    str2 = " CREATE INDEX IF NOT EXISTS \(key)Ind ON \(tableName) (\(key)) ;"
                }else {
                    str2 = str2 + " CREATE INDEX IF NOT EXISTS \(key)Ind ON \(tableName) (\(key)) ;"
                    
                }
                
            case is Int :
                if key == "ID" {
                    if str == "" {
                        str = "\"ID\" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT "
                    } else {
                        str = str + " , \"ID\" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT "
                    }
                }else {
                    if str == "" {
                        str = "\"\(key)\" INTEGER  "
                    } else {
                        str = str + " , \"\(key)\" INTEGER  "
                    }
                }
            case is Bool :
                if str == "" {
                    str = "\"\(key)\" INTEGER  "
                } else {
                    str = str + " , \"\(key)\" INTEGER  "
                }
            case is Double :
                if str == "" {
                    str = "\"\(key)\" REAL "
                } else {
                    str = str + " , \"\(key)\" REAL  "
                }
            default: break
                // str = ""
            }
        }
        str = "CREATE TABLE IF NOT EXISTS \"\(tableName)\" (" + str + ") ; " + str2
        
        return str
        }
    
    func getTableStructure ()->String{
                let db =  self.dataBase
        
        let str = db.getTableStruct(table: hatIsmJadwal())
        return str
        
        
    }
    
    private func sqlAddFieldToTableStruct(fieldName : String , fieldType : String)-> String {
        var str = "ALTER TABLE \(hatIsmJadwal()) ADD "
        switch fieldType {
        case  "String" :
            if str == "" {
                str = "\(fieldName) TEXT DEFAULT '' "
            } else {
                str = str + " \(fieldName) TEXT DEFAULT '' "
            }
            
        case "Int" :
            if str == "" {
                str = "\(fieldName) INTEGER DEFAULT -1 "
            } else {
                str = str + " \(fieldName) INTEGER DEFAULT -1 "
            }
        case "Bool" :
            if str == "" {
                str = "\(fieldName) INTEGER DEFAULT 0 "
            } else {
                str = str + " \(fieldName) INTEGER DEFAULT 0 "
            }
        case "Double" :
            if str == "" {
                str = "\(fieldName) REAL DEFAULT -1 "
            } else {
                str = str + " \(fieldName) REAL DEFAULT -1 "
            }
        default: break
            // str = ""
        }
        return str
    }

    func AddColumnToTabletructure(alterTableSql SQL : String)throws -> Bool {
        let db =  self.dataBase

        if db.execute(SQL) {
            return true
        }else {return false}

        
    }
    
    func updateTableStruct()->Bool {

        var str = ""
        
        let fields = dic
        let tblStruct = getTableStructure()
        for i in fields.keys {
            if !tblStruct.contains(i) {
                var type = ""
                switch fields[i] {
                case is String:
                    type = "String"
                case is Int:
                    type = "Int"
                case is Double:
                    type = "Double"
                case .none:
                    break
                case .some(_):
                    break
                }
                if str == "" {
                    str = sqlAddFieldToTableStruct(fieldName: i, fieldType:type)
                }else {
                    str = str + " ; " + sqlAddFieldToTableStruct(fieldName: i, fieldType:type )
                }
                
            }
        }
        if try!AddColumnToTabletructure(alterTableSql: str) {
            return true
        } else {
            return false
        }
        
    }

    func hatAwalObj(filter close : String){
        let db =  self.dataBase
        var str = ""
        if close == ""
        {
            str = "select * from \(hatIsmJadwal()) limit 1 "
        } else {
            str  = "select * from \(hatIsmJadwal()) where \(close) limit 1 "
        }
        let flds = db.getRecords(query: str)
        if flds.count > 0 {
             objMinDic(dic: flds[0])
        }
    }
    
    func hifdAwTa3dil(record : MNSijil) -> Bool {

        if record.halMa3doum() { return false}
        else {
            if self.halMa3doum() {
                objMinDic(dic: record.dic)
                try! self.hifd()
                
            }else {

                    objMinDic(dic: record.dic)
                     try! self.ta3dil()
                    
                
                
            }
        }
       return true
    }
    
}
///********************
class MNSql {
    var ismJadwal : String
    var a3mida : String = "*"
    var whereSql : String = ""
    var filterSql : String = ""
    var orderBySql : String = ""
    var limit : Int = -1
    var ofset : Int = -1
    var safhaRakm : Int
    init (ismJadwal : String , a3mida : String = "*" ,whereSql : String = "" , filterSql : String = "" , orderBySql : String = "" , limit : Int = -1 , ofset : Int = -1   ){
        self.ismJadwal = ismJadwal
        self.a3mida = a3mida
        self.whereSql = whereSql
        self.filterSql = filterSql
        self.orderBySql = orderBySql
        self.limit = limit
        self.ofset = ofset
        safhaRakm = 1
    }
    
    func hatSelectSql()->String{
        var sql = "SELECT \(a3mida) FROM \(ismJadwal)"
        if whereSql != "" {
            sql = sql + " WHERE (\(whereSql))"
        }
        if filterSql != "" {
            if whereSql != "" {
                sql = sql + " AND (\(filterSql))"
            }else {
                sql = sql + " WHERE (\(filterSql))"
            }
        }
        if orderBySql != "" {
            sql = sql + " ORDERE BY \(orderBySql)"
        }
        if limit != -1 {
            sql = sql + " LIMIT \(limit) OFFSET \(ofset) "
        }
        return sql
    }
    

    
}

class Field {
    var name : String = ""
    var type : String = ""
    var val : Any
    init(with val:Any)
    {
        self.val=val
    }
    
}





