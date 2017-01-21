//
//  PillTableViewController.swift
//  SimpillPage
//
//  Created by Mason Swofford on 4/20/16.
//  Copyright © 2016 Mason Swofford. All rights reserved.
//

import UIKit

class PillTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var pills = [Pill]()

    
    func loadSamplePills(){
        let pill1 = Pill(name: "Adderall", instructions: "Take with food", dispensionTime: nil, pillsRemaining: 50)!
        let pill2 = Pill(name: "Birth Control", instructions: "take immediately", dispensionTime: nil, pillsRemaining: 30)!
        
        pills += [pill1, pill2]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load any saved meals, otherwise load sample data.
        if let savedPills = loadPills() {
            pills += savedPills
        }
        else {
            loadSamplePills()
        }
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
        return pills.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "PillTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PillTableViewCell

        // Fetches the appropriate pill for the data source layout.
        let pill = pills[(indexPath as NSIndexPath).row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        
        cell.nameLabel.text = pill.name
        if pill.dispensionTime != nil {
            cell.dispensionLabel.text = dateFormatter.string(from: pill.dispensionTime! as Date)
        }
        else {
            cell.dispensionLabel.text = ""
        }
        cell.pillsRemainingLabel.text = String(pill.pillsRemaining)
        cell.instructionsLabel.text = pill.instructions

        return cell
    }
    @IBAction func unwindToPillList(_ sender: UIStoryboardSegue) {
    
        if let sourceViewController = sender.source as? PillViewController, let pill = sourceViewController.pill {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                pills[(selectedIndexPath as NSIndexPath).row] = pill
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new pill.
                let newIndexPath = IndexPath(row: pills.count, section: 0)
                pills.append(pill)
                tableView.insertRows(at: [newIndexPath], with: .bottom)
            }
            
            // Save the meals.
            savePills()
        }
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            pills.remove(at: (indexPath as NSIndexPath).row)
            savePills()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let pillDetailViewController = segue.destination as! PillViewController
            // Get the cell that generated this segue.
            if let selectedPillCell = sender as? PillTableViewCell {
                let indexPath = tableView.indexPath(for: selectedPillCell)!
                let selectedPill = pills[(indexPath as NSIndexPath).row]
                pillDetailViewController.pill = selectedPill
            }
        }
        else if segue.identifier == "AddItem" {
            print("Adding new pill.")
        }
    }
    
    // MARK: NSCoding
    
    func savePills() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(pills, toFile: Pill.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save pills...")
        }
    }
    
    func loadPills() -> [Pill]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Pill.ArchiveURL.path!) as? [Pill]
    }


}
