//
//  MNkalimat.swift
//  alkotobi
//
//  Created by merhab on 2‏/10‏/2018.
//  Copyright © 2018 merhab. All rights reserved.
//

import Foundation
import Cocoa

class MNSafha{
    var nass : String
    var kalimat : [MNKalima]
    init(nass:String){
        self.nass = nass
        kalimat = MNSafha.getKalimatFromNass(nass: nass)
    }
    init(kalimat:[MNKalima]){
        self.kalimat = kalimat
        nass = MNSafha.getNassFromKalimat(kalimat: kalimat)
    }
    
    static func cleanText(text:String)->String{
        var textOut = ""
        var notHorouf = ""
        for char in text.unicodeScalars {
            
            if  NSMutableCharacterSet.letters.contains(char)  {
                if notHorouf != "" {
                    textOut.append(" \(notHorouf) ")
                    notHorouf = ""
                }
                textOut.append(Character(char))
            }else {
                notHorouf.append(Character(char))
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
    
    
    
    static func getKalimatFromNass(nass:String,lastPosition:Double = 0)->[MNKalima]{
        let cleanNass = MNSafha.cleanText(text: nass)
        let words = MNSafha.words(text: cleanNass)
        var kalimat = [MNKalima]()
        for i in words.indices {
            var word = words[i]
            let kalima = MNKalima()
            kalima.position = lastPosition + 1 + Double(i)
            let tachkil = MNKalima.getTachkil(text: word)
            var str = String(tachkil)
            str = str.replacingOccurrences(of: "9", with: "")
            if str != ""{
                kalima.tashkil = tachkil
            }else{
                kalima.tashkil = -1
            }
            word = MNKalima.removeTachkil(text: word)
            let horofNorm = MNKalima.getNormHorof( text: word)
            str = String(horofNorm)
            str = str.replacingOccurrences(of: "9", with: "")
            if str != ""{
                kalima.horofNorm = horofNorm
            }else {kalima.horofNorm = -1}
            kalima.kalima = MNKalima.getNormalizedKalima(text: word)
            kalimat.append(kalima)
        }
        return kalimat
    }
    
    static func getNassFromKalimat(kalimat : [MNKalima])->String{
        var nass = ""
        var startIndex = nass.startIndex
        var endIndex = nass.endIndex
        for kalima in kalimat {
            var str = kalima.kalima
            if kalima.horofNorm != -1 {
                str =  MNKalima.getWordWithHorofNorm(word: str, horofNorm: kalima.horofNorm)
            }
            if kalima.tashkil != -1 {
                str = MNKalima.getWordWithTachkil(word: str, tachkil: kalima.tashkil)
            }
            
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
    
    func highLightKalima(kalima:MNKalima)->NSMutableAttributedString{
        var attributedNass = NSMutableAttributedString(string: nass)
        let nsRange = NSRange(kalima.range!, in: nass)
        let myAttribute = [ NSAttributedStringKey.foregroundColor: NSColor.blue ]
        attributedNass.addAttributes(myAttribute,range: nsRange)
    return attributedNass
}
}

