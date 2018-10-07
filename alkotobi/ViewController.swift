//
//  ViewController.swift
//  alkotobi
//
//  Created by merhab on 2‏/10‏/2018.
//  Copyright © 2018 merhab. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    var offset = 1
    var limit = 200
    var path  = ""
    var kitab : MNDBKitab?
    @IBOutlet var textView: NSTextView!
    
    @IBAction func right(_ sender: NSButton) {
        if !(kitab?.halAwalJadwal)!{
            kitab?.taharakIlaSabik()
            kitab?.hatSijilHali()
            textView.string = (kitab?.kitab.nass)!
        }
    }
    @IBAction func left(_ sender: NSButton) {
        if !(kitab?.halAkhirJadwal)!{
            kitab?.taharakIlaLahik()
            kitab?.hatSijilHali()
            textView.string = (kitab?.kitab.nass)!
        }
    }
    @IBAction func swip(_ sender: NSPanGestureRecognizer) {
        
    }
    @IBAction func load(_ sender: NSButton) {
 
         path =  MNUI.openDialogue(fileType: "kitab")
        kitab = MNDBKitab(path: path, limit: 50)
        
    }
    
    @IBAction func test(_ sender: Any) {
        _ = MNFile.createDbFolder(folder: MNFile.booksFolderName)
        
        
        
            let path =  MNUI.openDialogue(fileType: "db")
            MNImport.makeBookFrom(path: path)
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

