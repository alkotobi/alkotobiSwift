//
//  MNkalimat.swift
//  alkotobi
//
//  Created by merhab on 2‏/10‏/2018.
//  Copyright © 2018 merhab. All rights reserved.
//

import Foundation
//import Cocoa

class MNSafha{
    var nass : String
    var kalimat : [MNKalima]
    var dataBase : MNDatabase
    init(dataBase:MNDatabase, nass:String){
        self.dataBase = dataBase
        self.nass = nass
        self.kalimat = [MNKalima]()
        getKalimatFromNass()
    }
    init(dataBase:MNDatabase,kalimat:[MNKalima]){
        self.dataBase = dataBase
        self.kalimat = kalimat
        nass = MNSafha.getNassFromKalimat(kalimat: kalimat)
    }
    
    static func cleanText(text:String)->String{
        var textOut = ""
        var notHorouf = ""
        for char in text.unicodeScalars {
            
            if  NSMutableCharacterSet.letters.contains(char)  {
                if notHorouf != "" {
                    textOut.append(" \(notHorouf)")
                    notHorouf = ""
                }
                textOut.append(Character(char))
            }else {
                // must replace the ' because sqlite problem
                if Character(char) == "'" {notHorouf.append("\"")}else{
                    notHorouf.append(Character(char))}
            }
            
        }
        if notHorouf != "" {
            textOut.append(" \(notHorouf) ")
        }
        return textOut
        
    }
    
    static func words(text:String)->[String]{
        return text.components(separatedBy: .whitespaces)
            .filter{!$0.isEmpty}
    }
    
    
    
        func getKalimatFromNass(){
        let cleanNass = MNSafha.cleanText(text: nass)
        let words = MNSafha.words(text: cleanNass)
        for i in words.indices {
            var word = words[i]
            let kalima = MNKalima(dataBase: dataBase)
            //kalima.position = lastPosition + 1 + i
            kalima.tashkil = MNKalima.getTachkil(text: word)
            word = MNKalima.removeTachkil(text: word)
            kalima.kalima = MNKalima.getNormalizedKalima(text: word)
           // kalima.hifd()
            kalimat.append(kalima)
        }

    }
    static func getKalimatFromNass(nass : String)->[MNKalima]{
        var kalimat = [MNKalima]()
        let cleanNass = MNSafha.cleanText(text: nass)
        let words = MNSafha.words(text: cleanNass)
        for i in words.indices {
            var word = words[i]
            let kalima = MNKalima(dataBase: MNDatabase(path: ""))
            //kalima.position = lastPosition + 1 + i
            kalima.tashkil = MNKalima.getTachkil(text: word)
            word = MNKalima.removeTachkil(text: word)
            kalima.kalima = MNKalima.getNormalizedKalima(text: word)
            // kalima.hifd()
            kalimat.append(kalima)
        }
       return kalimat
    }
    
    static func getNassFromKalimat(kalimat : [MNKalima])->String{
        var nass = ""
        var startIndex = nass.startIndex
        var endIndex = nass.endIndex
        for kalima in kalimat {
            kalima.getLafdaTashkil()
            let str = kalima.kalima
            if nass == "" {
                nass = str
                startIndex = nass.startIndex
                endIndex = nass.endIndex
                kalima.range = (startIndex..<endIndex)
                
            }else{
                nass = nass + " "
                startIndex = nass.endIndex
                nass = nass + str
                endIndex = nass.endIndex
                kalima.range = startIndex..<endIndex
                
            }
        }
        
        return nass
    }
    
//    func highLightKalima(kalima:MNKalima)->NSMutableAttributedString{
//        let attributedNass = NSMutableAttributedString(string: nass)
//        let nsRange = NSRange(kalima.range!, in: nass)
//        let myAttribute = [ NSAttributedStringKey.foregroundColor: NSColor.blue ]
//        attributedNass.addAttributes(myAttribute,range: nsRange)
//    return attributedNass
//}
    
    func hifdKalimat() {
        for kalima in kalimat{
            kalima.hifd()
        }
    }
}

