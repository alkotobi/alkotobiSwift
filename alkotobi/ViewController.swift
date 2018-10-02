//
//  ViewController.swift
//  alkotobi
//
//  Created by merhab on 2‏/10‏/2018.
//  Copyright © 2018 merhab. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet var textView: NSTextView!
    
    @IBAction func test(_ sender: Any) {
        let str =
"""
حَدَّثَنَا عَبْدُ اللَّهِ بْنُ يُوسُفَ قَالَ حَدَّثَنِي اللَّيْثُ قَالَ حَدَّثَنِي سَعِيدٌ هُوَ ابْنُ أَبِي سَعِيدٍ عَنْ أَبِي شُرَيْحٍ أَنَّهُ قَالَ لِعَمْرِو بْنِ سَعِيدٍ وَهُوَ يَبْعَثُ الْبُعُوثَ إِلَى مَكَّةَ ائْذَنْ لِي أَيُّهَا الْأَمِيرُ أُحَدِّثْكَ
"""
       let kalimat = MNSafha.getKalimatFromNass(nass: str)
        let safha = MNSafha(kalimat: kalimat)
        let int = Int(textView.string)
        let attr = safha.highLightKalima(kalima: safha.kalimat[int!])
        textView.textStorage?.append(attr)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

