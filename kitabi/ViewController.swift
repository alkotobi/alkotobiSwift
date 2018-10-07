//
//  ViewController.swift
//  kitabi
//
//  Created by merhab on 5‏/10‏/2018.
//  Copyright © 2018 merhab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var offset = 1
    var limit = 400
    var path  = ""
    
    @IBAction func load(_ sender: UIButton) {
        if path == "" {let files = MNFile.searchDbFilesInRes()
            let fold = MNFile.createDbFolder(folder: MNFile.booksFolderName)
            for file in files{
            _ = MNFile.moveFileToBookFolder(file: file)
            }
            if MNFile.fileExists(path: MNFile.getDataBasePath(book: "13161")){
            path = MNFile.getDataBasePath(book: "13161")
            }
            
        }
        let db = MNDatabase(path: path)
        let mimi = db.getRecords(query: "SELECT name FROM sqlite_master WHERE type='table';")
        let dics = db.getRecords(of: "MNKalima", ofset: offset, limit: limit)
        let counts = db.getRecords(query: "select count(rowid) as count from MNkalima")
        let count = (counts[0]["count"] as! Int)
        if (offset + limit) < count {
            offset += limit
        }else{ limit = count - offset }
        var kalimat = [MNKalima]()
        DispatchQueue.global(qos: .userInteractive).async {
            for dic in dics{
                let kalima = MNKalima()
                kalima.objMinDic(dic: dic)
                kalima.getLafdaTashkil()
                kalimat.append(kalima)
           }
            let safha = MNSafha(dataBase: db, kalimat: kalimat)
           DispatchQueue.main.async {
                self.textView.text = safha.nass
            }
        }
    }
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

