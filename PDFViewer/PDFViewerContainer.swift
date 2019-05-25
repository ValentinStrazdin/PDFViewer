//
//  PDFViewerContainer.swift
//  PDFViewer
//
//  Created by Valentin Strazdin on 25/05/2019.
//  Copyright © 2019 Valentin Strazdin. All rights reserved.
//

import UIKit

class PDFViewerContainer: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var pdfDocumentView: PDFDocumentView!
    
    var document: Document?
    var pagesCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let document = document, let fileName = document.fileName,
            let documentsFolder = FileManager.default.documentsFolder else { return }
        self.title = document.title
        let fileURL = documentsFolder.appendingPathComponent(fileName)
        self.pdfDocumentView.fileURL = fileURL
        guard let pdfURL = fileURL as CFURL?, let pdf = CGPDFDocument(pdfURL) else { return }
        self.pagesCount = pdf.numberOfPages
    }
    
    @IBAction func nextPage(_ sender: Any) {
        let pageNumber = self.pdfDocumentView.pageNumber
        if pageNumber < pagesCount {
            self.pdfDocumentView.pageNumber = pageNumber + 1
            self.pdfDocumentView.setNeedsDisplay()
        }
    }
    
}
