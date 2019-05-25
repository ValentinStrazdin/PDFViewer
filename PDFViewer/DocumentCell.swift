//
//  DocumentCell.swift
//  PDFViewer
//
//  Created by Valentin Strazdin on 25/05/2019.
//  Copyright © 2019 Valentin Strazdin. All rights reserved.
//

import UIKit

class DocumentCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    
    let megaByte: Float = 1024 * 1024
    
    var document: Document? {
        didSet {
            guard let document = document else { return }
            self.titleLabel.text = document.title
            self.authorLabel.text = document.author
            self.sizeLabel.text = ""
            if let documentsFolder = FileManager.default.documentsFolder,
                let fileName = document.fileName {
                let url = documentsFolder.appendingPathComponent(fileName)
                if let size = try? FileManager.default.attributesOfItem(atPath: url.path)[.size] as? UInt64 {
                    self.sizeLabel.text = String(format: "%.1f MB", Float(size) / megaByte)
                }
            }
            
        }
    }
}
