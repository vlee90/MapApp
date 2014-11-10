//
//  ReminderTableViewController.swift
//  MapApp
//
//  Created by Vincent Lee on 11/5/14.
//  Copyright (c) 2014 VincentLee. All rights reserved.
//

import UIKit
import CoreData

class ReminderTableViewController: UIViewController, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    @IBOutlet weak var tableView: UITableView!
    var fetchedResultsController: NSFetchedResultsController!
    var managedObjectContext: NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        
        tableView.registerNib(UINib(nibName: "ReminderTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "REMINDER_TABLEVIEW_CELL")
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.managedObjectContext = appDelegate.managedObjectContext
        
        var fetchRequest = NSFetchRequest(entityName: "Reminder")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: "Reminders")
                self.fetchedResultsController.delegate = self
        
        var error: NSError?
        if self.fetchedResultsController.performFetch(&error) {
            println("Error: \(error?.description)")
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didGetCloudChanges:", name: NSPersistentStoreDidImportUbiquitousContentChangesNotification, object: appDelegate.persistentStoreCoordinator)
        
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("REMINDER_TABLEVIEW_CELL", forIndexPath: indexPath) as ReminderTableViewCell
        if let reminder = self.fetchedResultsController.fetchedObjects![indexPath.row] as? Reminder {
            cell.nameLabel.text = reminder.name
            cell.coordinateLabel.text = "\(reminder.coordinate)"
            cell.radiusLabel.text = "\(reminder.radius)"
            cell.dateLabel.text = "\(reminder.date)"
        }
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.reloadData()
    }
    
    func didGetCloudChanges(notification: NSNotification) {
        self.managedObjectContext.mergeChangesFromContextDidSaveNotification(notification)
    }
}
