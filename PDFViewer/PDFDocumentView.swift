//
//  PDFDocumentView.swift
//  PDFViewer
//
//  Created by Valentin Strazdin on 26/05/2019.
//  Copyright © 2019 Valentin Strazdin. All rights reserved.
//

import UIKit
import CoreGraphics

class PDFDocumentView: UIView {
    var fileURL: URL?
    var pageNumber: Int = 1
    
    override func draw(_ rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.setFillColor(UIColor.white.cgColor)
        ctx.fill(rect)
        
        guard let pdfURL = fileURL as CFURL?, let pdf = CGPDFDocument(pdfURL) else { return }
        // Flip coordinates
        ctx.scaleBy(x: 1, y: -1)
        ctx.translateBy(x: 0, y: -rect.size.height)
        guard let page = pdf.page(at: pageNumber) else { return }
        // get the rectangle of the cropped inside
        let mediaRect = page.getBoxRect(.cropBox)
        ctx.scaleBy(x: rect.size.width / mediaRect.size.width, y: rect.size.height / mediaRect.size.height)
        ctx.translateBy(x: -mediaRect.origin.x, y: -mediaRect.origin.y)
        // draw it
        ctx.drawPDFPage(page)
    }
    
}
