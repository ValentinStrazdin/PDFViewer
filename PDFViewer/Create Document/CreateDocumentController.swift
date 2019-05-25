//
//  CreateDocumentController.swift
//  PDFViewer
//
//  Created by Valentin Strazdin on 25/05/2019.
//  Copyright © 2019 Valentin Strazdin. All rights reserved.
//

import UIKit
import CoreData

protocol CreateDocumentControllerDelegate: NSObjectProtocol {
    func documentCreated(_ document: Document)
}

class CreateDocumentController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    
    var fileURL: URL?
    weak var delegate: CreateDocumentControllerDelegate?
    
    @IBAction func saveDocument() {
        guard let sourceURL = fileURL,
            let documentTitle = titleTextField.text, !documentTitle.isEmpty,
            let author = authorTextField.text, !author.isEmpty,
            let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let documentsFolder = FileManager.default.documentsFolder else { return }
        let fileName = "\(UUID().uuidString).pdf"
        let destURL = documentsFolder.appendingPathComponent(fileName)
        do {
            try FileManager.default.copyItem(at: sourceURL, to: destURL)
            try FileManager.default.removeItem(at: sourceURL)
            appDelegate.document = nil
        }
        catch let error as NSError {
            print("Could not copy file to documents. \(error), \(error.userInfo)")
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let document = NSEntityDescription.insertNewObject(forEntityName: "Document", into: managedContext) as? Document else { return }
        document.title = documentTitle
        document.author = author
        document.fileName = fileName
        document.dateAdded = Date()
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        dismiss(animated: true, completion: {
            self.delegate?.documentCreated(document)
        })
    }
    
    @IBAction func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UITextFieldDelegate methods
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textLength = textField.text?.count ?? 0
        // Here we validate document name
        return (!string.containsInvalidFileNameChars && (textLength + string.count) < 250)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let text = textField.text?.trimmingCharacters(in: .whitespaces)
        textField.text = text
        if !text.isNilOrEmpty {
            textField.resignFirstResponder()
            return true
        }
        else {
            return false
        }
    }
}
