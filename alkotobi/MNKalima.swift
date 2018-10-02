//
//  File.swift
//  testingTests
//
//  Created by merhab on 30‏/9‏/2018.
//  Copyright © 2018 merhab. All rights reserved.
//
//You can use a subscript (note the Swift 4 one-sided range):
//
//let index = str.index(str.startIndex, offsetBy: 5)
//let mySubstring = str[..<index] // Hello
//or prefix:
//
//let index = str.index(str.startIndex, offsetBy: 5)
//let mySubstring = str.prefix(upTo: index) // Hello
//or even easier:
//
//let mySubstring = str.prefix(5) // Hello
//End of a string
//
//Using subscripts:
//
//let index = str.index(str.endIndex, offsetBy: -10)
//let mySubstring = str[index...] // playground
//or suffix:
//
//let index = str.index(str.endIndex, offsetBy: -10)
//let mySubstring = str.suffix(from: index) // playground
//or even easier:
//
//let mySubstring = str.suffix(10) // playground
//Note that when using the suffix(from: index) I had to count back from the end by using -10. That is not necessary when just using suffix(x), which just takes the last x characters of a String.
//Range in a string
//
//Again we simply use subscripts here.
//
//let start = str.index(str.startIndex, offsetBy: 7)
//let end = str.index(str.endIndex, offsetBy: -6)
//let range = start..<end
//
//let mySubstring = str[range]  // play
//Converting Substring to String
//
//Don't forget, when you are ready to save your substring, you should convert it to a String so that the old string's memory can be cleaned up.
//
//let myString = String(mySubstring)




//startIndex and endIndex
//
//startIndex is the index of the first character
//endIndex is the index after the last character.

//Example
//
//// character
//str[str.startIndex] // H
//str[str.endIndex]   // error: after last character
//
//// range
//let range = str.startIndex..<str.endIndex
//str[range]  // "Hello, playground"

//offsetBy
//
//As in: index(String.Index, offsetBy: String.IndexDistance)
//
//The offsetBy value can be positive or negative and starts from the given index. Although it is of the type String.IndexDistance, you can give it an Int.
//Examples
//
//// character
//let index = str.index(str.startIndex, offsetBy: 7)
//str[index]  // p
//
//// range
//let start = str.index(str.startIndex, offsetBy: 7)
//let end = str.index(str.endIndex, offsetBy: -6)
//let range = start..<end
//str[range]  // play
//limitedBy
//
//As in: index(String.Index, offsetBy: String.IndexDistance, limitedBy: String.Index)
//
//The limitedBy is useful for making sure that the offset does not cause the index to go out of bounds. It is a bounding index. Since it is possible for the offset to exceed the limit, this method returns an Optional. It returns nil if the index is out of bounds.


import Foundation
class MNKalima {
    static let numbers = Array(48...57)
    static let arkam = Array(1632...1641)
    static let tachkil = Array(1611...1623)
    static let horouf = Array(1569...1594)+Array(1601...1610)+[32]
    static let horoufTachkil = horouf + tachkil
    static let InvisibleChar = [9,10,12,8205]
    static let romoz = Array(61473...61572)
    static let othmani = Array(1643...1772)
    static let t1 :Character = "َ"
    static let t2 :Character  = "ً"
    static let t3 :Character  = "ُ"
    static let t4 :Character  = "ٌ"
    static let t5 :Character  = "ِ"
    static let t6 :Character  = "ٍ"
    static let t7 :Character  = "ْ"
    static let t8 :Character  = "ّ"
    static let tachkilMarks = [t1,t2,t3,t4,t5,t6,t7,t8]
    // horof of normalization
    static let n1 :Character = "أ"
    static let n2 :Character = "إ"
    static let n3 :Character = "آ"
    static let n4 :Character = "ء"
    static let n5 :Character = "ئ"
    static let n6 :Character = "ؤ"
    static let n7 :Character = "ي"
    static let n8 :Character = "ا"
    static let alifat = [n1,n2,n3,n4,n5,n6,n7,n8]
 //   static let tarkim = [33...47]+[58...95]+[123,125,176,247]+[1548...1567]+[1600,1642,1643,1648]+[8211...8230]
    static let kawsOthmani = [64830,64831]
    var kalima = "" // normalized
    var tashkil = -1
    var horofNorm = -1
    var position = -1.0
    var range : Range<String.Index>?
    
    func splitToNumCode()->[UInt32]{
        var codes = [UInt32]()
        for chr in kalima.unicodeScalars{
            codes.append(chr.value)

        }
        return codes

    }

    static func getNormalizedKalima(text : String)->String{
        
        let nassArray = Array(MNNass.removeTashkil(text: text))
        var NormalizedArray = [Character]()
        for char in nassArray {
            
            if ArabiaThawabit.alif.contains(char){
                NormalizedArray.append("ا")
                
            }else if char == "ي"
            { NormalizedArray.append("ى")
            }else {
                NormalizedArray.append(char)
            }
        }
        return String(NormalizedArray)
    }

    
    static func removeTachkil(text:String)->String{
//            let mutableString = NSMutableString(string: text) as CFMutableString
//            CFStringTransform(mutableString, nil, kCFStringTransformStripCombiningMarks, Bool(truncating: 0))
//            let normalized = (mutableString as NSMutableString).copy() as! NSString
        var str = ""
        for char in text.unicodeScalars {
            if !tachkil.contains(Int(char.value)){
              str.append(Character(char))
            }
        }
            
            return String(str)
        }
    static func getTachkil(text:String)->Int{
        var chars=[Character]()
        for scal in text.unicodeScalars {
          chars.append(Character(scal))
        }
        var tachkils = [Character]()
        for i in chars.indices{

            switch chars[i]{
            case t1 :
                tachkils.append("1")
            case t2 :
                tachkils.append("2")
            case t3 :
                tachkils.append("3")
            case t4 :
                tachkils.append("4")
            case t5 :
                tachkils.append("5")
            case t6 :
                tachkils.append("6")
            case t7 :
                tachkils.append("7")
            case t8 :
                tachkils.append("8")
            default:
                tachkils.append("9")
            }
            
        }
        
        let str = String(tachkils)
        return Int(str )!
}
    
    static func getNormHorof(text:String)->Int{
        var horofNorm = [Character]()
        for char in text{
            
            switch char{
            case n1 :
                horofNorm.append("1")
            case n2 :
                horofNorm.append("2")
            case n3 :
                horofNorm.append("3")
            case n4 :
                horofNorm.append("4")
            case n5 :
                horofNorm.append("5")
            case n6 :
                horofNorm.append("6")
            case n7 :
                horofNorm.append("7")
            default:
                horofNorm.append("9")
            }
            
        }
        
        let str = String(horofNorm)
        return Int(str)!
    }

    
    static func getArrayOfTashkil(tachkil : Int)->[Character]{
        let str = String(tachkil)
        var arr = [Character]()
        for char in str {
            switch char{
            case "1" : arr.append(MNKalima.t1)
            case "2" : arr.append(MNKalima.t2)
            case "3" : arr.append(MNKalima.t3)
            case "4" : arr.append(MNKalima.t4)
            case "5" : arr.append(MNKalima.t5)
            case "6" : arr.append(MNKalima.t6)
            case "7" : arr.append(MNKalima.t7)
            case "8" : arr.append(MNKalima.t8)
            default:
                       arr.append("9")
            }
        }
        return arr
    }
    static func getArrayOfHorofNorm(horofNorm : Int)->[Character]{
        let str = String(horofNorm)
        var arr = [Character]()
        for char in str {
            switch char{
            case "1" : arr.append(MNKalima.n1)
            case "2" : arr.append(MNKalima.n2)
            case "3" : arr.append(MNKalima.n3)
            case "4" : arr.append(MNKalima.n4)
            case "5" : arr.append(MNKalima.n5)
            case "6" : arr.append(MNKalima.n6)
            case "7" : arr.append(MNKalima.n7)
            default:
                       arr.append("9")
            }
        }
        return arr
    }
    static func getWordWithTachkil(word:String,tachkil:Int)->String  {
 
        var arr3=[Character]()
        let arrhorof = Array(word)
        let arrTachkil = MNKalima.getArrayOfTashkil(tachkil: tachkil)
        var i = 0
        for j in arrTachkil.indices {
            if arrTachkil[j] == "9" {
                arr3.append(arrhorof[i])
                i += 1
      
            }else{
                arr3.append(arrTachkil[j])
            }
        

        }
    return String(arr3)
    }
    static func getWordWithHorofNorm(word:String,horofNorm:Int)->String  {
        
        var arr3=[Character]()
        let arrhorof = Array(word)
        let arrHorofNorm = MNKalima.getArrayOfHorofNorm(horofNorm: horofNorm)
        for i in arrHorofNorm.indices{

            if arrHorofNorm[i] != "9"{
                arr3 +=  [arrHorofNorm[i]]
            }else{
                arr3 += [arrhorof[i]]
            }
        }
        return String(arr3)
        
        
    }

}
        
extension String {
    var words: [String] {
        var words: [String] = []
        self.enumerateSubstrings(in: startIndex..<endIndex, options: .byWords) { word,_,_,_ in
            guard let word = word else { return }
            words.append(word)
        }
        return words
    }
}

