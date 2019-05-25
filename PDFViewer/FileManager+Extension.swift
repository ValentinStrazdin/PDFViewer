//
//  FileManager+Extension.swift
//  PDFViewer
//
//  Created by Valentin Strazdin on 25/05/2019.
//  Copyright © 2019 Valentin Strazdin. All rights reserved.
//

import Foundation

extension FileManager {
    
    var documentsFolder: URL? {
        return self.urls(for: .documentDirectory, in: .userDomainMask).first
    }
}
