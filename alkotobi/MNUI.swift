//
//  MNUI.swift
//  alkotobi
//
//  Created by merhab on 2‏/10‏/2018.
//  Copyright © 2018 merhab. All rights reserved.
//

import Foundation
import Cocoa
class MNUI{
    static func openDialogue(fileType:String)->String{
        let dialog = NSOpenPanel();
        
        dialog.title                   = "Choose a \(fileType) file";
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = false;
        dialog.canChooseDirectories    = true;
        dialog.canCreateDirectories    = true;
        dialog.allowsMultipleSelection = false;
        dialog.allowedFileTypes        = [fileType];
        
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            let result = dialog.url // Pathname of the file
            
            if (result != nil) {
                let path = result!.path
                return  path
            }
        }
        return ""
    }
}
