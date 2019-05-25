//
//  ViewController.swift
//  PDFViewer
//
//  Created by Valentin Strazdin on 25/05/2019.
//  Copyright © 2019 Valentin Strazdin. All rights reserved.
//

import UIKit
import CoreData

class DocumentsViewController: UITableViewController {
    var fetchedResultsController: NSFetchedResultsController<Document>!
    var selectedDocument: Document?
    
    let showPDFViewerSegueIdentifier = "showPDFViewer"

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Document>(entityName: "Document")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showCreateDocumentScreen), name: .openURL, object: nil)
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("There was an error fetching the list of Documents!")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("There was an error fetching the list of Documents!")
        }
    }

    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DocumentCell = tableView.dequeueReusableCell(withIdentifier: "DocumentCell", for: indexPath) as! DocumentCell
        let document = fetchedResultsController.object(at: indexPath)
        cell.document = document
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showPDFViewerSegueIdentifier,
            let vc = segue.destination as? PDFViewerContainer {
            if let documentCell = sender as? DocumentCell {
                vc.document = documentCell.document
            }
            else {
                vc.document = self.selectedDocument
            }
        }
    }
    
    @objc func showCreateDocumentScreen() {
        let storyboard = UIStoryboard(name: "CreateDocument", bundle: nil)
        if let nc = storyboard.instantiateInitialViewController() as? UINavigationController,
            let createDocumentController = nc.topViewController as? CreateDocumentController,
            let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            createDocumentController.fileURL = appDelegate.document?.fileURL
            createDocumentController.delegate = self
            nc.modalPresentationStyle = .formSheet
            self.present(nc, animated: true, completion: nil)
        }
    }
    
}

extension DocumentsViewController: CreateDocumentControllerDelegate {
    
    func documentCreated(_ document: Document) {
        self.selectedDocument = document
        self.performSegue(withIdentifier: showPDFViewerSegueIdentifier, sender: nil)
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("There was an error fetching the list of Documents!")
        }
    }
    
}
